const std = @import("std");
const expect = std.testing.expect;
const print = std.debug.print;

test "pointer slicing" {
    var array: [10]u8 = [_]u8{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };
    print("\n{d}\n", .{array.len});

    var start: usize = 2;

    const slice = array[start..4];
    print("\n{d}\n", .{slice.len});

    try expect(slice.len == 2);

    try expect(array[3] == 4);

    slice[1] += 1;
    try expect(array[3] == 5);
}
