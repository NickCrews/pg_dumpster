pub mod arrow_tsv;
pub mod entries;
pub mod http_range_reader;
pub mod profiling;
pub mod reader;
pub mod table_read;
pub mod test_utils;
pub mod tsv;

pub use duckdb;

/// Time the enclosing scope from this point until the scope exits.
/// Compiles to nothing when the `profiling` feature is disabled.
#[macro_export]
macro_rules! profile_section {
    ($name:expr) => {
        #[cfg(feature = "profiling")]
        let _profile_guard = $crate::profiling::ScopeTimer::new($name);
    };
}

/// Time a specific expression and record it under the given name.
/// Compiles to just the expression when the `profiling` feature is disabled.
#[macro_export]
macro_rules! profile_block {
    ($name:expr, $block:expr) => {{
        #[cfg(feature = "profiling")]
        let _start = ::std::time::Instant::now();
        let _result = $block;
        #[cfg(feature = "profiling")]
        $crate::profiling::record($name, _start.elapsed());
        _result
    }};
}

/// Log a checkpoint with the time since process startup.
/// This helps with correlating profiling data with logs.
/// Compiles to nothing when the `profiling` feature is disabled.
#[macro_export]
macro_rules! profile_checkpoint {
    ($name:expr) => {
        #[cfg(feature = "profiling")]
        $crate::profiling::checkpoint($name);
    };
}

/// Print a summary of all recorded profiling data.
/// Compiles to nothing when the `profiling` feature is disabled.
#[macro_export]
macro_rules! profile_print_summary {
    () => {
        #[cfg(feature = "profiling")]
        $crate::profiling::print_profile_summary();
    };
}
