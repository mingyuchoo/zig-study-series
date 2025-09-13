# README

## How to build and run code

```bash
zig build-exe <file_name>.zig
./<file_name>
```

## How to build object

```bash
zig build-obj <file_name>.zig
```

## How to test

```bash
zig test <test_file_name>.zig
```

## Repository structure

- `03.HelloWorld/` — Basic “Hello, World!” examples.
- `04.Comments/` — Line, block, and documentation comments (`///`, `//!`, etc.).
- `05.Values/` — Values, variables, mutability, string literals, initialization.
- `06.ZigTest/` — Using `zig test`, nested containers, skipping tests, leak detection.
- `07.Variables/` — Identifiers, comptime variables, container-level/static/thread-local.
- `08.Integers/` — Integer literals and runtime vs comptime behavior.
- `09.Floats/` — Float literals, special values, and float mode (exe/obj).
- `10.Operators/` — Operator examples. May produce build artifacts in this folder.
- `11.Arrays/` — Arrays, multi-dimensional arrays, null-terminated arrays.
- `12.Vectors/` — Vector types and operations.
- `13.Pointers/` — Pointer types, arithmetic, and comptime conversions.

## Running examples

You can build and run examples in two common ways:

1. Build a binary, then run it

```bash
zig build-exe <file_name>.zig
./<file_name>          # POSIX
```

On Windows PowerShell:

```powershell
zig build-exe <file_name>.zig
./<file_name>.exe
```

1. Run directly (compile + run in one step)

```bash
zig run <file_name>.zig
```

## Notes

- Some folders (e.g., `09.Floats/`) demonstrate different build modes (`exe`, `obj`).
- Test files are regular `.zig` files that include `test` blocks; run them with `zig test` as shown above.
- If a folder contains previously built artifacts (e.g., `10.Operators/operators` or `operators.o`), you can safely delete them and rebuild as needed.

## How to generate documentation

```bash
zig test -femit-docs <file_name>.zig
```
