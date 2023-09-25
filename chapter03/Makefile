AS=yasm
GDB=gdb
GDBFLAGS=-ex "break main"
ASFLAGS=-f elf64 -g dwarf2
EXECRISE1=exercise_1
PROGS=$(EXECRISE1)

%.o : %.s ; $(AS) $(ASFLAGS) -l $*.lst $< -o $@

all: $(PROGS)

$(EXECRISE1).o: $(EXECRISE1).s

$(EXECRISE1): $(EXECRISE1).o
	$(CC) -o $@ $<

clean:
	$(RM) *.lst *.o *.bak $(PROGS)

gdb1: $(EXECRISE1)
	$(GDB) $(GDBFLAGS) $(EXECRISE1)
