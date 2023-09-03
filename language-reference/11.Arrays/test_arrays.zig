const expect = @import("std").testing.expect;
const assert = @import("std").debug.assert;
const mem = @import("std").mem;

// array literal
const message = [_]u8{
    'h',
    'e',
    'l',
    'l',
    'o',
};

// get the size of an array
comptime {
    assert(message.len == 5);
}

// A string literal is a single-item pointer to an array.
const same_message = "hello";

comptime {
    assert(mem.eql(u8, &message, same_message));
}

test "iterate over an array" {
    var sum: usize = 0;
    for (message) |byte| {
        sum += byte;
    }
    try expect(sum == 'h' + 'e' + 'l' * 2 + 'o');
}

// // modifiable array
// var some_integers: [100]i32 = undefined;
//
// test "modify an array" {
//     for (&some_integers, 0..) |*item, i| {
//         item.* = @intCast(i);
//     }
//     try expect(some_integers[10] == 10);
//     try expect(some_integers[99] == 99);
// }

// array concatenation works if the values are known at compile time
const part_one = [_]i32{ 1, 2, 3, 4 };
const part_two = [_]i32{ 5, 6, 7, 8 };
const all_of_it = part_one ++ part_two;
comptime {
    assert(mem.eql(i32, &all_of_it, &[_]i32{ 1, 2, 3, 4, 5, 6, 7, 8 }));
}

// remember that string literals are arrays
const hello = "hello";
const world = "world";
const hello_world = hello ++ " " ++ world;
comptime {
    assert(mem.eql(u8, hello_world, "hello world"));
}

// ** does repeating patterns
const patterns = "ab" ** 3;
comptime {
    assert(mem.eql(u8, patterns, "ababab"));
}

// initialize an array to zero
const all_zero = [_]u16{0} ** 10;

comptime {
    assert(all_zero.len == 10);
    assert(all_zero[5] == 0);
}

// use compile-time code to initialize an array
const Point = struct {
    x: i32,
    y: i32,
};

// var fancy_array = init: {
//     var initial_value: [10]Point = undefined;
//     for (&initial_value, 0..) |*pt, i| {
//         pt.* = Point{
//             .x = @intCast(i),
//             .y = @intCast(i * 2),
//         };
//     }
//     break :init initial_value;
// };
