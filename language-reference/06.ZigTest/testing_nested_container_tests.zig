const std = @import("std");
const expect = std.testing.expect;

// Imported source file tests will run when referneced from a top-level test declaration.
// The next line alone does not cause "testing_introduction.zig" tests to run.
const imported_file = @import("testing_introduction.zig");

test {
    // To run nested container tests, either, call `refAllDecls` which will
    // reference all declarations located in the given argument.
    // `@This()` is a builtin function that returns the innermost container it is called from.
    // In this example, the innermost container is the file (implicitly a struct).
    std.testing.refAllDecls(@This());

    // or, refernce each container individually from a top-level test declaration.
    // The `_ = C;` syntax is a no-op reference to the identifier `C`.

    _ = S;
    _ = U;
    _ = @import("testing_introduction.zig");
}

const S = struct {
    test "S demo test" {
        try expect(true);
    }

    const SE = enum {
        V,
        // This test won't run becuase its container (SE) is not referneced.
        test "This Test Won't Run" {
            try expect(false);
        }
    };
};

const U = union { // U is referenced by the file's top-level test declaration
    s: US, // and US is referneced here; therefor, "U.Us demo test" will run

    const US = struct {
        test "U.US demo test" {
            // This test is a top-level test declaration for the struct.
            // The struct is nested (declared) inside of a union.
            try expect(true);
        }
    };
    test "U demo test" {
        try expect(true);
    }
};
