#!/bin/sh
set -e
./oasm tests/obj_pointer.oasm > out.s
echo "Wrote out.s"
