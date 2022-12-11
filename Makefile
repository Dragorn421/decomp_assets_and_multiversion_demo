ifeq ($(VERSION),)
$(error VERSION is not set)
endif

BASEROM := baseroms/baserom_v$(VERSION).bin

C_FILES := $(shell find assets/ src/ -name '*.c' -not -name '*.inc.c')
O_FILES := $(foreach f,$(C_FILES),build/$(f:.c=.o))
PNG_FILES := $(shell find assets/ -name '*.png')
INC_C_FILES := $(foreach f,$(PNG_FILES),build/$f.inc.c)

DEPS := $(foreach f,$(C_FILES),build/$f.d)

INCLUDE := -I . -I include

$(shell mkdir --parents $(dir $(O_FILES) $(INC_C_FILES)))

default: rom.bin compare

.PHONY: default setup clean assetclean versionclean distclean o_files compare

-include $(DEPS)

setup:
	mkdir -p ./baserom_files/
	./tools/extract_baserom.py $(BASEROM) ./baserom_files/ $(VERSION)
	find assets -name '*.xml' -exec sh -c 'cpp -P -DVERSION=$(VERSION) {} | ./tools/extract_assets.py ./baserom_files/ ./assets/_extracted/ {}' \;

rom.bin: build/rom.elf
	objcopy -O binary $< $@

compare: | rom.bin
	diff rom.bin $(BASEROM) -s

build/rom.elf: $(O_FILES) $(INC_C_FILES) script.ld
	ld $(O_FILES) -T script.ld -o $@ -Map=$@.map.txt

o_files: $(foreach f,$(INC_C_FILES),$(if $(wildcard f),,$f))
$(O_FILES): | o_files

build/%.o: %.c
	gcc -DVERSION=$(VERSION) $(INCLUDE) -MMD -MF build/$<.d -c $< -o $@

build/%.png.inc.c: %.png
	./tools/bin_to_u8.py $< $@

clean:
	rm -rf build

assetclean:
	rm -rf assets/_extracted/

versionclean: clean assetclean
	rm -rf baserom_files

distclean: versionclean
