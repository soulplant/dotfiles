CXXFLAGS=
CXX=g++

SRC=main.cc
OBJ:=$(SRC:cc=o)
DEPS:=$(SRC:cc=d)

file-picker: $(OBJ)
	$(CXX) $(OBJ) -o $@

all: file-picker

.PHONY: all clean

%.d: %.cc
	@set -e ; rm -f $@ ; \
    $(CXX) -MM $(CXXFLAGS) $< > $@.$$$$ ; \
    sed 's,\($*\)\.o[ :]*,\1.o $@ : ,g' < $@.$$$$ > $@ ; \
    rm -f $@.$$$$

include $(DEPS)

clean:
	rm -f $(OBJ) $(DEPS) file-picker
