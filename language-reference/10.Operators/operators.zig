const print = @import("std").debug.print;
const math = @import("std").math;
const mem = @import("std").mem;

pub fn main() void {

    // Addition
    // 2 + 5 == 7
    const v1 = 2 + 5;
    print("{}\n", .{v1});

    // Wrapping Addition
    // @as(u32, std.math.maxInt(u32)) +% 1 == 0
    const v2 = @as(u32, math.maxInt(u32)) +% 1;
    print("{}\n", .{v2});

    // Saturating Addition
    // @as(u32, std.math.maxInt(u32)) +| 1 == @as(u32, std.math.maxInt(u32))
    // @as(u32, std.math.maxInt(u32)) == 4294967295 in Linux x64
    const v3 = @as(u32, math.maxInt(u32)) +| 1;
    print("{}\n", .{v3});

    // Subtraction
    // 2 - 5 == -3
    const v4 = 2 - 5;
    print("{}\n", .{v4});

    // Wrapping Substraction
    // @as(u32, 0) -% 1 == std.math.maxInt(u32)
    // std.math.amxInt(u32) == 4294967295 in Linux x64
    const v5 = @as(u32, 0) -% 1;
    print("{}\n", .{v5});

    // Saturating Subtraction
    // @as(u32, 0) -| 1 == 0
    const v6 = @as(u32, 0) -| 1;
    print("{}\n", .{v6});

    // Negation
    // -1 == 0 - 1
    const v7 = -1;
    print("{}\n", .{v7});

    // Wrapping Negation
    // -%@as(i32, std.math.minInt(i32)) == std.math.minInt(i32)
    const v8 = -%@as(i32, math.minInt(i32));
    print("{}\n", .{v8});

    // Multiplication
    // 2 * 5 == 10
    const v9 = 2 * 5;
    print("{}\n", .{v9});

    // Wrapping Multiplication
    // @as(u8, 200) *% 2 == 144
    const v10 = @as(u8, 200) *% 2;
    print("{}\n", .{v10});

    // Saturating Multiplication
    // @as(u8, 200) *| 2 == 255
    const v11 = @as(u8, 200) *| 2;
    print("{}\n", .{v11});

    // Division
    // 10 / 5 == 2
    const v12 = 10 / 5;
    print("{}\n", .{v12});

    // Remainder Division
    // 10 % 3 == 1
    const v13 = 10 % 3;
    print("{}\n", .{v13});

    // Bit Shift Left
    // 1 << 8 == 256
    const v14 = 1 << 8;
    print("{}\n", .{v14});

    // Saturating Bit Shift Left
    // @as(u8, 1) <<| 8 == 255
    const v15 = @as(u8, 1) <<| 8;
    print("{}\n", .{v15});

    // Bit Shift Right
    // 10 >> 1 == 5
    const v16 = 10 >> 1;
    print("{}\n", .{v16});

    // Bitwise AND
    // 0b011 & 0b101 == 0b001
    const v17 = 0b011 & 0b101;
    print("{b}\n", .{v17});

    // Bitwise OR
    // 0b011 | 0b101 == 0b001
    const v18 = 0b011 | 0b101;
    print("{b}\n", .{v18});

    // Bitwise XOR
    // 0b011 ^ 0b101 == 0b110
    const v19 = 0b011 ^ 0b101;
    print("{b}\n", .{v19});

    // Bitwise NOT
    // ~@as(u8, 0b10101111) == 0b01010000
    const v20 = ~@as(u8, 0b10101111);
    print("{b}\n", .{v20});

    // `orelse`
    // Optionals: If `a` is `null`, return `b` ("default value"),
    //            otherwise returns the unwrapped value of `a`.
    //            Note that `b` may be a value of type `noreturn`.
    const v21: ?u32 = null;
    const uwr21 = v21 orelse 1234; // uwr21 == 1234
    print("{}\n", .{uwr21});

    // `.?`
    // Optionals: `a` orelse unreachable
    const v22: ?u32 = 5678; // v22.? == 5678
    print("{}\n", .{v22.?});

    // `catch`
    // Error Unions: If `a` is an `error`, returns `b` ("default value"),
    //               otherwise returns the unwrapped value of `a`
    //               Note that `b` may be a value of type `noreturn`.
    //               `err` is the `error` adn is in scope of the expression `b`
    const v23: anyerror!u32 = error.Broken;
    const uwr23 = v23 catch 1234; // uwr23 == 1234
    print("{}\n", .{uwr23});

    // Boolean AND
    // (false and true) == false
    const v24 = false and true;
    print("{}\n", .{v24});

    // Boolean OR
    // (false or true) == true
    const v25 = false or true;
    print("{}\n", .{v25});

    // Boolean NOT
    // !false == true
    const v26 = !false;
    print("{}\n", .{v26});

    // Boolean `a == b`
    // (1 == 1) == true
    const v27 = (1 == 1);
    print("{}\n", .{v27});

    // Optional: Return `true` if `a` is `null`,
    //           otherwise returns `false`.
    const v28: ?u32 = null;
    print("{}\n", .{v28 == null});

    // Boolean `a != b`
    const v29 = (1 != 1); // false
    print("{}\n", .{v29});

    // Boolean `a > b`
    const v30 = (1 > 1); // false
    print("{}\n", .{v30});

    // Boolean `a >= b`
    const v31 = (1 >= 1); // true
    print("{}\n", .{v31});

    // Boolean `a < b`
    const v32 = (1 < 1); // false
    print("{}\n", .{v32});

    // Boolean `a <= b`
    const v33 = (1 <= 1); // true
    print("{}\n", .{v33});

    // Array concatenation: `a ++ b`
    // : Only available when the lengths of both `a` and `b` are compile-time known.
    const arr1 = [_]u32{ 1, 2 };
    const arr2 = [_]u32{ 3, 4 };
    const arr3 = arr1 ++ arr2;
    const v34 = mem.eql(u32, &arr3, &[_]u32{ 1, 2, 3, 4 });
    print("{}\n", .{v34});

    // Array multiplication: `a ** b`
    // : Only available when the lengths of both `a` and `b` are compile-time known.
    const arr4 = "ab" ** 3;
    const v35 = mem.eql(u8, arr4, "ababab");
    print("{}\n", .{v35});

    // Address of: `&a`
    const v36: u32 = 1234;
    const ptr36 = &v36;
    print("{}\n", .{ptr36.*});

    // Point dereference: `a.*`
    const v37: u32 = 1234;
    const ptr37 = &v37;
    print("{}\n", .{ptr37.*});

    // Merging Error Sets: `a || b`
    const V38 = error{One};
    const V39 = error{Two};
    const V40 = (V38 || V39); // == error{One, Two}
    print("{}\n", .{V40});
}
