const std = @import("std");

// 2s + 10 = s + 15

fn left(s: u32) u32 {
    return 2 * s + 5;
}

fn right(s: u32) u32 {
    return s + 15;
}

pub fn main() !void {
    var i: u8 = 0;
    while (i < 100) {
        if (left(i) == right(i)) {
            std.debug.print("I found the number s: {}\n", .{i});
            return;
        }

        i += 1;
    }
}
