
CC  = cc 
CXX = c++
LD  = c++
AR  = ar

CPPFLAGS += -DMPT_COMPILER_GENERIC
CXXFLAGS += -std=c++11 
CFLAGS   += -std=c99   
LDFLAGS  += 
LDLIBS   += 
ARFLAGS  := rcs

MPT_COMPILER_GENERIC=1
SHARED_LIB=0
DYNLINK=0

EXESUFFIX=
