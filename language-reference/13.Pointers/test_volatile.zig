const expect = @import("std").testing.expect;

test "volatile" {
    // Memory Mapped Input/Output(MMIO)
    const mmio_ptr: *volatile u8 = @ptrFromInt(0x12345678);
    try expect(@TypeOf(mmio_ptr) == *volatile u8);
}
