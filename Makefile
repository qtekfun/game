###########################################
### MACROS
###########################################

# $(1) : Compiler
# $(2) : Object file to generate
# $(3) : Source file
# $(4) : Aditional dependencies
# $(5) : Compiler flags
define COMPILE
$(2) : $(3) $(4)
	$(1) -c -o $(2) $(3) $(5)
endef

# $(1) : Source file
define C2O
$(patsubst %.c,%.o,$(patsubst %.cpp,%.o,$(patsubst $(SRC)%,$(OBJ)%,$(1))))
endef

# $(1) : Source file
define C2H
$(patsubst %.c,%.h,$(patsubst %.cpp,%.hpp,$(1)))
endef

###########################################
### CONFIG
###########################################
APP     := game
CCFLAGS := -Wall -pedantic -std=c++17
CFLAGS  := -Wall -pedantic
CC      := g++
CC      := g++
C       := gcc
MKDIR   := mkdir -p
SRC     := src
OBJ     := obj
BIN     := bin
RMF     := rm -rf
RM      := rm
CLEAN   := clean
CLEANALL:= cleanall
LIBS    := lib/picoPNG.ua/bin/libpicopng.a lib/tinyPTC/bin/libtinyptc.a -lX11
LIBDIR  := lib
INCDIRS := -I$(SRC) -I$(LIBDIR)

#LIBS := -L. -lX11 L = path and -l lib to use

# make CC=clang++ C=clang -> to use clang once instead of gcc

# make DEBUG=1
ifdef DEBUG
	CCFLAGS += -g
	CFLAGS += -g
else
	CCFLAGS += -O3
	CFLAGS += -O3
endif

#iname = case insensitive
#subst substituye texto plano. patsubst substituye con un patron.
ALLCPPS    := $(shell find src -type f -iname *.cpp)
ALLCS      := $(shell find src -type f -iname *.c)
#ALLCPPSOBJ := $(patsubst %.cpp,%.o,$(ALLCPPS))
ALLOBJ := $(foreach F,$(ALLCPPS) $(ALLCS),$(call C2O,$(F)))
#ALLCSOBJ   := $(patsubst %.c,%.o,$(ALLCS))
SUBDIRS    := $(shell find $(SRC) -type d)
OBJSUBDIRS := $(patsubst $(SRC)%,$(OBJ)%,$(SUBDIRS)) $(BIN)

.PHONY  := info libs libs-clean libs-cleanall

$(BIN)/$(APP) : $(OBJSUBDIRS) $(ALLOBJ)
	$(CC) -o $(BIN)/$(APP) $(ALLOBJ) $(LIBS)

# Generate rules for all objects
$(foreach F,$(ALLCPPS),$(eval $(call COMPILE,$(CC),$(call C2O,$(F)),$(F),$(call C2H,$(F)),$(CCFLAGS) $(INCDIRS))))
$(foreach F,$(ALLCS),$(eval $(call COMPILE,$(C),$(call C2O,$(F)),$(F),$(call C2H,$(F)),$(CFLAGS) $(INCDIRS))))

# $(OBJ)%.o : $(SRC)%.c
# 	$(C) -o $(patsubst $(SRC)%, $(OBJ)%, $@) -c $^ $(CFLAGS)

# $(OBJ)%.o : $(SRC)%.cpp
# 	$(CC) -o $(patsubst $(SRC)%, $(OBJ)%, $@) -c $^ $(CCFLAGS)

info :
	$(info $(SUBDIRS))
	$(info $(OBJSUBDIRS))
	$(info $(ALLCPPS))
	$(info $(ALLCS))
	$(info $(ALLCSOBJ))

$(OBJSUBDIRS) : 
	$(MKDIR) $(OBJSUBDIRS)

# $(CLEAN) :
# 	$(RMF) $(OBJSUBDIRS)

## CLEAN rules
clean:
	$(RM) -r "./$(OBJ)"

cleanall: clean
	$(RM) -r "./$(BIN)/$(APP)"

## LIB rules
libs:
	$(MAKE) -C $(LIBDIR)

libs-clean:
	$(MAKE) -C $(LIBDIR) clean

libs-cleanall:
	$(MAKE) -C $(LIBDIR) cleanall

