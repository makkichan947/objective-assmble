Object model:

Object table (runtime) maps OID -> { addr, size, type }.
OID 0 is null.
API (assembly symbols provided):
- alloc_object : allocate object, returns oid in rax
- free_object  : free object by oid
- ref_create   : create objRef to target oid, returns ref_oid
- ref_deref    : deref objRef: given ref_oid returns target oid

The demo uses text-based parsing to detect '&' and '^' usage and emits markers.
