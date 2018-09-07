AS=yasm
GDB=gdb
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
	$(CC) -no-pie -o $@ $<

clean:
	$(RM) $(PROG).lst $(PROG).o $(PROG) $(SAMPLE).s

gdb: $(PROG)
	$(GDB) $(GDBFLAGS) $(PROG)
