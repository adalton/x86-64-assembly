AS=yasm
ASFLAGS=-f elf64 -g dwarf2
PROG=ex

%.o : %.s ; $(AS) $(ASFLAGS) -l $*.lst $< -o $@

all: $(PROG)

$(PROG).o: $(PROG).s
#$(PROG): $(PROG).o
#	$(LD) -o $@ $<
$(PROG): $(PROG).o
	$(CC) -no-pie -o $@ $<

clean:
	$(RM) $(PROG).lst $(PROG).o $(PROG)
