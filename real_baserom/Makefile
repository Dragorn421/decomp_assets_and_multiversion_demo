# 0 or 1
VERSION := 0

DEFINES := -DVERSION=$(VERSION)

O_FILES := build/code.o build/math_consts.o build/art/art.o

$(shell mkdir --parents $(dir $(O_FILES)))

baserom.bin: build/baserom.elf
	objcopy -O binary $< $@

build/baserom.elf: $(O_FILES) build/script.ld
	ld $(O_FILES) -T build/script.ld -o $@ -Map=$@.map.txt

build/script.ld: script.ld
	cpp -P $(DEFINES) $< -o $@

build/%.o: src/%.c
	gcc -c $(DEFINES) $< -o $@

build/%.o: src/%.s
	cpp -P $(DEFINES) $< | as -o $@

clean:
	rm -rf build
