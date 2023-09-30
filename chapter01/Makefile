AS=yasm
GDB=gdb
CFLAGS=-nostdlib -no-pie -z noexecstack
GDBFLAGS1=-ex "break _start"
GDBFLAGS2=-ex "break main"
ASFLAGS=-f elf64 -g dwarf2
EXECRISE1=exercise_1
EXECRISE2=exercise_2
PROGS=$(EXECRISE1) $(EXECRISE2)

%.o : %.s ; $(AS) $(ASFLAGS) -l $*.lst $< -o $@

all: $(PROGS)

$(EXECRISE1).o: $(EXECRISE1).s
$(EXECRISE2).o: $(EXECRISE2).s

$(EXECRISE1): $(EXECRISE1).o
	$(LD) -o $@ $<

$(EXECRISE2): $(EXECRISE2).o
	$(CC) $(CFLAGS) -o $@ $<

clean:
	$(RM) *.lst *.o *.bak $(PROGS)

gdb1: $(EXECRISE1)
	$(GDB) $(GDBFLAGS1) $(EXECRISE1)

gdb2: $(EXECRISE2)
	$(GDB) $(GDBFLAGS2) $(EXECRISE2)
