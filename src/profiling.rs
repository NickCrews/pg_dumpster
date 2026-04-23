#[cfg(feature = "profiling")]
use std::collections::BTreeMap;
#[cfg(feature = "profiling")]
use std::sync::Mutex;
#[cfg(feature = "profiling")]
use std::time::{Duration, Instant};

#[cfg(feature = "profiling")]
struct ProfileEntry {
    total: Duration,
    count: u64,
}

#[cfg(feature = "profiling")]
static START_TIME: std::sync::LazyLock<Instant> = std::sync::LazyLock::new(Instant::now);

#[cfg(feature = "profiling")]
static PROFILE_DATA: std::sync::LazyLock<Mutex<BTreeMap<String, ProfileEntry>>> =
    std::sync::LazyLock::new(|| Mutex::new(BTreeMap::new()));

#[cfg(feature = "profiling")]
static CHECKPOINTS: std::sync::LazyLock<Mutex<Vec<(String, Duration)>>> =
    std::sync::LazyLock::new(|| Mutex::new(Vec::new()));

#[cfg(feature = "profiling")]
pub struct ScopeTimer {
    name: &'static str,
    start: Instant,
}

#[cfg(feature = "profiling")]
impl ScopeTimer {
    pub fn new(name: &'static str) -> Self {
        Self {
            name,
            start: Instant::now(),
        }
    }
}

#[cfg(feature = "profiling")]
impl Drop for ScopeTimer {
    fn drop(&mut self) {
        record(self.name, self.start.elapsed());
    }
}

#[cfg(feature = "profiling")]
pub fn record(name: &str, duration: Duration) {
    let mut data = PROFILE_DATA.lock().unwrap();
    let entry = data.entry(name.to_string()).or_insert(ProfileEntry {
        total: Duration::ZERO,
        count: 0,
    });
    entry.total += duration;
    entry.count += 1;
}

pub fn checkpoint(_name: &str) {
    #[cfg(feature = "profiling")]
    {
        let elapsed = START_TIME.elapsed();
        CHECKPOINTS
            .lock()
            .unwrap()
            .push((_name.to_string(), elapsed));
    }
}

pub fn print_profile_summary() {
    #[cfg(feature = "profiling")]
    {
        eprintln!("\n=== Profile Summary ===");
        let checkpoints = CHECKPOINTS.lock().unwrap();
        if !checkpoints.is_empty() {
            eprintln!("\n=== Checkpoints ===");
            let mut last_time = Duration::ZERO;
            for (name, elapsed) in checkpoints.iter() {
                let delta = elapsed.saturating_sub(last_time);
                eprintln!(
                    "[{:>10.6}s] (+{:>10.6}s) {}",
                    elapsed.as_secs_f64(),
                    delta.as_secs_f64(),
                    name
                );
                last_time = *elapsed;
            }
        }

        let data = PROFILE_DATA.lock().unwrap();
        if data.is_empty() {
            return;
        }
        eprintln!("\n=== Section Summary ===");
        let mut entries: Vec<_> = data.iter().collect();
        entries.sort_by(|a, b| b.1.total.cmp(&a.1.total));
        let rows: Vec<_> = entries
            .iter()
            .map(|(name, entry)| {
                let avg = if entry.count > 0 {
                    entry.total / entry.count as u32
                } else {
                    Duration::ZERO
                };
                (
                    name.as_str(),
                    format!("{:.3?}", entry.total),
                    entry.count.to_string(),
                    format!("{:.3?}", avg),
                )
            })
            .collect();

        let name_w = rows
            .iter()
            .map(|r| r.0.len())
            .max()
            .unwrap_or(4)
            .max("name".len());
        let total_w = rows
            .iter()
            .map(|r| r.1.len())
            .max()
            .unwrap_or(5)
            .max("total".len());
        let count_w = rows
            .iter()
            .map(|r| r.2.len())
            .max()
            .unwrap_or(5)
            .max("count".len());
        let avg_w = rows
            .iter()
            .map(|r| r.3.len())
            .max()
            .unwrap_or(3)
            .max("avg".len());

        eprintln!(
            "  {name:<name_w$}  {total:>total_w$}  {count:>count_w$}  {avg:>avg_w$}",
            name = "name",
            total = "total",
            count = "count",
            avg = "avg",
            name_w = name_w,
            total_w = total_w,
            count_w = count_w,
            avg_w = avg_w,
        );
        eprintln!(
            "  {:-<name_w$}  {:-<total_w$}  {:-<count_w$}  {:-<avg_w$}",
            "",
            "",
            "",
            "",
            name_w = name_w,
            total_w = total_w,
            count_w = count_w,
            avg_w = avg_w,
        );
        for (name, total, count, avg) in rows {
            eprintln!(
                "  {name:<name_w$}  {total:>total_w$}  {count:>count_w$}  {avg:>avg_w$}",
                name = name,
                total = total,
                count = count,
                avg = avg,
                name_w = name_w,
                total_w = total_w,
                count_w = count_w,
                avg_w = avg_w,
            );
        }
        eprintln!("=======================\n");
    }
}

pub fn reset() {
    #[cfg(feature = "profiling")]
    {
        PROFILE_DATA.lock().unwrap().clear();
        CHECKPOINTS.lock().unwrap().clear();
    }
}
