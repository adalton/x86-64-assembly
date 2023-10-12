AS=yasm
GDB=gdb
CFLAGS=-no-pie -z noexecstack
GDBFLAGS=-ex "break main"
ASFLAGS=-f elf64 -g dwarf2
PROG=ex

%.o : %.s ; $(AS) $(ASFLAGS) -l $*.lst $< -o $@

all: $(PROG)

c_ex:	ex.c
	$(CC) -o $@ $<

$(PROG).o: $(PROG).s

$(PROG): $(PROG).o
	$(CC) $(CFLAGS) -o $@ $<

clean:
	$(RM) $(PROG).lst $(PROG).o $(PROG) c_ex

gdb: $(PROG)
	$(GDB) $(GDBFLAGS) $(PROG)
