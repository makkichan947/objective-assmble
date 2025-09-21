AS = as
LD = ld
ASFLAGS =
LDFLAGS =

SRCS = src/front/main.S src/front/lexer.S src/front/parser.S src/front/symbols.S \
       src/middle/ir_gen.S src/middle/optimizer.S src/back/codegen_x86_64.S \
       src/runtime/syscalls.S src/runtime/object_table.S src/runtime/ref.s \
       src/runtime/mem.S src/utils/strings.S src/utils/error.S

OBJS = $(SRCS:.S=.o) $(SRCS:.s=.o)

all: oasm

oasm: $(OBJS)
	$(LD) -o $@ $(OBJS)

%.o: %.S
	$(AS) $(ASFLAGS) -o $@ $<

%.o: %.s
	$(AS) $(ASFLAGS) -o $@ $<

clean:
	rm -f $(OBJS) oasm
