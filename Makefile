CYTHON_SRC = $(shell find av -name "*.pyx")
C_SRC = $(CYTHON_SRC:%.pyx=build/%.c)
MOD_SOS = $(CYTHON_SRC:%.pyx=%.so)

TEST_MOV = sandbox/640x360.mp4

.PHONY: default build cythonize clean clean-all info test

default: build

info:
	@ echo Cython sources: $(CYTHON_SRC)

cythonize: $(C_SRC)

build/%.c: %.pyx
	@ mkdir -p $(shell dirname $@)
	cython -I. -Iheaders -o $@ $<

build: configure cythonize
	python setup.py build_ext --inplace

configure:
	autoconf

test: build
	python -m examples.decode $(TEST_MOV)
test-fail: build
	python -m examples.decode dne-$(TEST_MOV)

debug: build
	gdb python --args python -m examples.tutorial $(TEST_MOV)

clean:
	- rm -rf build
	- find av -name '*.so' -delete

clean-all: clean
	- rm configure config.py