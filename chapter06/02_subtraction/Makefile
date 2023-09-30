AS=yasm
GDB=gdb
CFLAGS=-no-pie -z noexecstack
GDBFLAGS=-ex "break main"
ASFLAGS=-f elf64 -g dwarf2
PROG=ex

%.o : %.s ; $(AS) $(ASFLAGS) -l $*.lst $< -o $@

all: $(PROG)

$(PROG).o: $(PROG).s

$(PROG): $(PROG).o
	$(CC) $(CFLAGS) h-o $@ $<

clean:
	$(RM) $(PROG).lst $(PROG).o $(PROG)

gdb: $(PROG)
	$(GDB) $(GDBFLAGS) $(PROG)
