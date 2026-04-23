use anyhow::{Context, Result};
use std::{
    fs::File,
    io::{Read, Seek, SeekFrom},
    path::Path,
};

use libpgdump::{CustomDataLoader, TableOfContents};

use crate::http_range_reader::HttpRangeReader;

pub enum DumpReader {
    File(File),
    Http(HttpRangeReader),
}

impl Read for DumpReader {
    fn read(&mut self, buf: &mut [u8]) -> std::io::Result<usize> {
        match self {
            Self::File(reader) => reader.read(buf),
            Self::Http(reader) => reader.read(buf),
        }
    }
}

impl Seek for DumpReader {
    fn seek(&mut self, pos: SeekFrom) -> std::io::Result<u64> {
        match self {
            Self::File(reader) => reader.seek(pos),
            Self::Http(reader) => reader.seek(pos),
        }
    }
}

pub struct UnopenedReader {
    pub reader: DumpReader,
}

impl UnopenedReader {
    pub fn new(source: impl Into<String>) -> Result<UnopenedReader> {
        let source = source.into();
        let reader = if source.starts_with("http://") || source.starts_with("https://") {
            DumpReader::Http(HttpRangeReader::new(source))
        } else {
            let file = File::open(Path::new(&source))
                .with_context(|| format!("failed to open dump file {}", source))?;
            DumpReader::File(file)
        };
        Ok(UnopenedReader { reader })
    }

    pub fn read_toc(self) -> Result<CustomDataLoader<DumpReader>> {
        CustomDataLoader::from_readable(self.reader).context("failed to read dump header and TOC")
    }

    pub fn use_toc(self, toc: &TableOfContents) -> CustomDataLoader<DumpReader> {
        CustomDataLoader {
            reader: self.reader,
            toc: toc.clone(),
        }
    }
}

pub fn open_file_reader(path: &Path) -> Result<CustomDataLoader<File>> {
    let file =
        File::open(path).with_context(|| format!("failed to open dump file {}", path.display()))?;
    CustomDataLoader::from_readable(file).context("failed to read dump header and TOC")
}

/// Create and open a libpgdump [CustomDataLoader] that reads from a PostgreSQL dump file available at the given HTTP URL, using range requests to fetch the dump in chunks.
pub fn open_http_reader(url: impl Into<String>) -> Result<CustomDataLoader<HttpRangeReader>> {
    let reader = HttpRangeReader::new(url.into());
    CustomDataLoader::from_readable(reader).context("failed to read dump header and TOC")
}

pub fn open_reader(source: impl Into<String>) -> Result<CustomDataLoader<DumpReader>> {
    UnopenedReader::new(source)?.read_toc()
}
