const x = 1234;

fn foo() void {
    // `const` identifier cannot change. (immutable)
    // It works at file scope as well as inside functions.
    const y = 5678;

    // Once assigned, an identifier cannot be changed.
    y += 1;
}

pub fn main() void {
    foo();
}
