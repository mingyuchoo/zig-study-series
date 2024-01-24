const print = @import("std").debug.print;

pub fn main() void {

    // `var` identifiers can change (mutable)
    var y: i32 = 5678;

    y += 1;

    print("{d}", .{y});
}
