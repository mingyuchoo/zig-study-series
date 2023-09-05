const std = @import("std");
const expect = std.testing.expect;
const expectEqual = std.testing.expectEqual;
const print = std.debug.print;

test "pointer arithmetic with many-item pointer" {
    const array = [_]i32{
        1,
        2,
        3,
        4,
    };
    var ptr: [*]const i32 = &array;

    try expect(ptr[0] == 1);

    print("\n", .{});
    for (0.., array) |idx, item| {
        try expect(ptr[idx] == item);
        try expect(ptr[idx] == array[idx]);

        print("{d}\n", .{item});
    }
    ptr += 1;
    try expect(ptr[0] == 2);
}

test "pointer arithmetic with slices" {
    var array = [_]i32{
        1,
        2,
        3,
        4,
    };
    var length: usize = 0;
    var slice = array[length..array.len];

    try expect(slice[0] == 1);
    try expect(slice.len == 4);

    slice.ptr += 1;
    // now the slice is in an bad state
    // since len has not been updated.

    try expect(slice[0] == 2);
    try expect(slice.len == 4);
}
