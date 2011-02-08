CXXFLAGS=
CXX=g++

PROJECT_NAME=file-picker

SRC=main.cc
OBJ:=$(SRC:cc=o)
DEPS:=$(SRC:cc=d)

$(PROJECT_NAME): $(OBJ)
	$(CXX) $(OBJ) -o $@

all: $(PROJECT_NAME)

.PHONY: all clean

%.d: %.cc
	@set -e ; rm -f $@ ; \
    $(CXX) -MM $(CXXFLAGS) $< > $@.$$$$ ; \
    sed 's,\($*\)\.o[ :]*,\1.o $@ : ,g' < $@.$$$$ > $@ ; \
    rm -f $@.$$$$

include $(DEPS)

clean:
	rm -f $(OBJ) $(DEPS) $(PROJECT_NAME)
