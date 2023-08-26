const std = @import("std");

test "detect leak" {
    var list = std.ArrayList(u21).init(std.testing.allocator);

    // missing `defer list.deinit();`
    try list.append('A');

    try std.testing.expect(list.items.len == 1);
}
