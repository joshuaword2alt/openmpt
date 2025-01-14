
CC  = contrib/fuzzing/afl/afl-clang-lto
CXX = contrib/fuzzing/afl/afl-clang-lto++
LD  = contrib/fuzzing/afl/afl-clang-lto++
AR  = ar 

ifneq ($(STDCXX),)
CXXFLAGS_STDCXX = -std=$(STDCXX) -fexceptions -frtti -pthread
# We do not enable C++20 for fuzzer builds, because it prevents detecting
# shifting of signed values which changed from undefined to defined behaviour
# in C++20. As we still support C+ü+17, we need to catch these problem cases.
#else ifeq ($(shell printf '\n' > bin/empty.cpp ; if $(CXX) -std=c++20 -c bin/empty.cpp -o bin/empty.out > /dev/null 2>&1 ; then echo 'c++20' ; fi ), c++20)
#CXXFLAGS_STDCXX = -std=c++20 -fexceptions -frtti -pthread
else ifeq ($(shell printf '\n' > bin/empty.cpp ; if $(CXX) -std=c++17 -c bin/empty.cpp -o bin/empty.out > /dev/null 2>&1 ; then echo 'c++17' ; fi ), c++17)
CXXFLAGS_STDCXX = -std=c++17 -fexceptions -frtti -pthread
endif
CFLAGS_STDC = -std=c99 -pthread
CXXFLAGS += $(CXXFLAGS_STDCXX)
CFLAGS += $(CFLAGS_STDC)
LDFLAGS  += -pthread

DYNLINK=0
SHARED_LIB=0
STATIC_LIB=1

CPPFLAGS +=
CXXFLAGS += -fPIC -fno-strict-aliasing
CFLAGS   += -fPIC -fno-strict-aliasing
LDFLAGS  += 
LDLIBS   += -lm
ARFLAGS  := rcs

CXXFLAGS_WARNINGS += -Wmissing-declarations
CFLAGS_WARNINGS   += -Wmissing-prototypes

ifeq ($(CHECKED_ADDRESS),1)
CXXFLAGS += -fsanitize=address
CFLAGS   += -fsanitize=address
endif

ifeq ($(CHECKED_UNDEFINED),1)
CXXFLAGS += -fsanitize=undefined
CFLAGS   += -fsanitize=undefined
endif

include build/make/warnings-clang.mk

EXESUFFIX=

FUZZ=1
CPPFLAGS += -DMPT_BUILD_FUZZER -DMPT_BUILD_FATAL_ASSERTS

