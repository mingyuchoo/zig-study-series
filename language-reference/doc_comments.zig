/// A structure for storing a timestamp, with nanosecond precision (this is a
/// multiline doc comment).
const Timestamp = struct {
    /// The number of seconds since the epoch (this is also a doc comment).
    second: i64, // signed so we can represent pre-1970 (not a doc comment)
    nanos: u32,

    // Returns a `Timestamp` struct presenting the Unix epoch; that is, the
    // moment of 1970 Jan 1 00:00:00 UTC (this is a doc comment too).
    pub fn unixEpoch() Timestamp {
        return Timestamp{
            .seconds = 0,
            .nanos = 0,
        };
    }
};
