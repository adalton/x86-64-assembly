AS=yasm
ASFLAGS=-f elf64 -g dwarf2
CFLAGS=-no-pie -z noexecstack
PROG=ex

%.o : %.s ; $(AS) $(ASFLAGS) -l $*.lst $< -o $@

all: $(PROG)

$(PROG).o: $(PROG).s

$(PROG): $(PROG).o
	$(CC) $(CFLAGS) -o $@ $<

clean:
	$(RM) $(PROG).lst $(PROG).o $(PROG)
