### Makefile incompplete: No header file dependencies. 
###                       Fix SRC definition
MF = Makefile  # Makefile filename, defined to be used as a dependency target
EXE = indexBQIfam  # Executable filename

CC = gcc
CFLAGS = -Wall -Wextra -std=c99 -O3 -mtune=native
LFLAGS = -lm

OUTFILES= Output/bqiFamNonMatched.txt

#CC = icc
#CFLAGS = -wn=3 -std=c99 -Ofast -ipo -openmp #-mtune=corei7-avx -combine
#LFLAGS = -lm
################################################################################
# No need to edit below this line
################################################################################
#		 place any sources in src folder and everything should be taken care of 
SRC := $(wildcard Src/*.c)
OBJ := $(subst Src,Obj,$(subst .c,.o,$(SRC)))

.SUFFIXES: .c

$(EXE):	 $(MF) $(OBJ)
	$(CC) $(CFLAGS) $(OBJ) -o $@ $(LFLAGS)

Obj/%.o: Src/%.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(OBJ) $(EXE) $(OUTFILES)
