use std::io::{self, Read, Seek, SeekFrom};

use anyhow::{Context, Result, bail};
use reqwest::blocking::{Client, Response};
use reqwest::header::{CONTENT_LENGTH, CONTENT_RANGE, RANGE};

pub struct HttpRangeReader {
    client: Client,
    url: String,
    position: u64,
    cached_file_size: Option<u64>,
    current_response: Option<Response>,
}

impl HttpRangeReader {
    pub fn new(url: String) -> Self {
        Self {
            client: Client::new(),
            url,
            position: 0,
            cached_file_size: None,
            current_response: None,
        }
    }

    pub fn file_size(&mut self) -> Result<u64> {
        if let Some(size) = self.cached_file_size {
            return Ok(size);
        }
        let response = send_range_request(&self.client, &self.url, "bytes=0-0")
            .with_context(|| format!("failed to fetch file size from {}", self.url))?;
        let status = response.status();
        if !status.is_success() {
            bail!("range request for file size failed with status {status}");
        }
        let size = parse_total_size(response.headers()).context("could not determine file size")?;
        self.cached_file_size = Some(size);
        Ok(size)
    }

    fn ensure_response(&mut self) -> Result<()> {
        if self.current_response.is_some() {
            return Ok(());
        }
        let range = format!("bytes={}-", self.position);
        let response = send_range_request(&self.client, &self.url, &range)
            .with_context(|| format!("failed to start range request from {}", self.position))?;
        let status = response.status();
        if status.as_u16() != 206 {
            bail!("expected HTTP 206 for range request, got {status}");
        }
        if self.cached_file_size.is_none() {
            if let Ok(size) = parse_total_size(response.headers()) {
                self.cached_file_size = Some(size);
            }
        }
        self.current_response = Some(response);
        Ok(())
    }
}

fn parse_total_size(headers: &reqwest::header::HeaderMap) -> Result<u64> {
    if let Some(content_range) = headers.get(CONTENT_RANGE) {
        let value = content_range
            .to_str()
            .context("invalid Content-Range header")?;
        if let Some(total_part) = value.split('/').nth(1) {
            let total = total_part
                .parse::<u64>()
                .context("invalid Content-Range total size")?;
            return Ok(total);
        }
    }
    if let Some(content_length) = headers.get(CONTENT_LENGTH) {
        let value = content_length
            .to_str()
            .context("invalid Content-Length header")?
            .parse::<u64>()
            .context("invalid Content-Length value")?;
        return Ok(value);
    }
    bail!("missing Content-Range or Content-Length headers")
}

impl Read for HttpRangeReader {
    fn read(&mut self, buf: &mut [u8]) -> io::Result<usize> {
        if buf.is_empty() {
            return Ok(0);
        }
        self.ensure_response().map_err(io::Error::other)?;
        let n = self.current_response.as_mut().unwrap().read(buf)?;
        self.position += n as u64;
        Ok(n)
    }
}

impl Seek for HttpRangeReader {
    fn seek(&mut self, pos: SeekFrom) -> io::Result<u64> {
        // eprintln!("Seeking to {:?} from position {}", pos, self.position);
        let new_position = match pos {
            SeekFrom::Start(offset) => offset as i128,
            SeekFrom::Current(delta) => self.position as i128 + delta as i128,
            SeekFrom::End(delta) => {
                let size = self.file_size().map_err(io::Error::other)?;
                size as i128 + delta as i128
            }
        };
        if new_position < 0 {
            return Err(io::Error::new(
                io::ErrorKind::InvalidInput,
                "seek before start of stream",
            ));
        }
        let new_position = new_position as u64;
        if new_position != self.position {
            self.current_response = None;
        }
        self.position = new_position;
        Ok(self.position)
    }
}

fn send_range_request(
    client: &Client,
    url: &str,
    range: &str,
) -> Result<reqwest::blocking::Response> {
    // eprintln!("Sending range request {range} to {url}... ");
    let response = client
        .get(url)
        .header(RANGE, range)
        .send()
        .with_context(|| format!("failed to send range request {range} to {url}"))?;
    Ok(response)
}
