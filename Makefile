# Directories
BUILD_DIR = build
SRC_DIR = src

# Tools
CC = tools/ido_recomp/linux/5.3/cc
LD = mips-linux-gnu-ld
OBJDUMP = mips-linux-gnu-objdump

# Compiler flags
CC_FLAGS  = -G 0 -mips2 -non_shared -Xfullwarn -Xcpluscomm -Wab,-r4300_mul -Iinclude -O2 -g3

# Ensure build directories exists 
$(foreach dir,$(shell find $(SRC_DIR)/ -type d | sed 's/$(SRC_DIR)/$(BUILD_DIR)/g'),$(shell mkdir -p $(dir)))

# Disassemble linked object file
$(FILE): $(BUILD_DIR)/$(FILE).bin
	@$(OBJDUMP) -d --visualize-jumps=extended-color $(BUILD_DIR)/$(FILE).bin

# Link object file
$(BUILD_DIR)/%.bin: $(BUILD_DIR)/%.o
	@$(LD) --entry 0x0 -o $@ $<

# Compile C source file
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
	@$(CC) -c $(CC_FLAGS) -o $@ $<

# Help text
default:
	@echo "Usage:"
	@echo "  Show disassembly of C source file:"
	@echo "    make FILE=<C file name>"
	@echo
	@echo "  Remove build directory:"
	@echo "    make clean"
	@echo

# Clean helper
clean:
	rm -r $(BUILD_DIR)

# Keep object files
.PRECIOUS: $(BUILD_DIR)/%.o
