Objective-ASM (expanded) - Language spec (summary)

- Everything is an object.
- Objects have OID (32-bit integer).
- References are objRef storing an OID.
- Syntax (minimal demo):
    objInt iX = 42
    objRef pX = &iX
    fnPrint(pX^)

- Hungarian-like prefixes:
    objInt, objRef, objStr, fn, sz, i

This repo implements runtime object table and simple compiler pipeline in assembly.
