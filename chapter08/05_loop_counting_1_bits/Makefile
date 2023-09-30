AS=yasm
GDB=gdb
CFLAGS=-no-pie -z noexecstack
GDBFLAGS=-ex "break main"
ASFLAGS=-f elf64 -g dwarf2
PROG=ex
SAMPLE=c_example

%.o : %.s ; $(AS) $(ASFLAGS) -l $*.lst $< -o $@

all: $(PROG) $(SAMPLE).s

$(PROG).o: $(PROG).s

$(SAMPLE).s: $(SAMPLE).c
	$(CC) -O3 -S -masm=intel -o $@ $<

$(PROG): $(PROG).o
	$(CC) $(CFLAGS) -o $@ $<

clean:
	$(RM) $(PROG).lst $(PROG).o $(PROG) $(SAMPLE).s

gdb: $(PROG)
	$(GDB) $(GDBFLAGS) $(PROG)
