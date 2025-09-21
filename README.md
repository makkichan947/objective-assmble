# objective-assmble

Objective-ASM expanded repository (assembly-only implementation).
This repository contains an extended oasm compiler framework implemented
in GNU as (AT&T) assembly. It is demo-level but includes an object model,
object-table runtime, pointer/ref primitives, and a layered compiler framework.

Build:
    make

Run demo:
    ./oasm tests/obj_pointer.oasm

This prints a generated assembly-like listing showing object/ref handling.
