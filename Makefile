TEST_MODULE_REPO := https://github.com/munificent/craftinginterpreters.git
TEST_MODULE := test/craftinginterpreters
TEST_TOOL := $(TEST_MODULE)/tool/bin/test.dart

test: $(TEST_TOOL)
	: || dart $(TEST_TOOL)

$(TEST_TOOL):
	git submodule init
	git clone --depth=1 --filter=blob:none --sparse $(TEST_MODULE_REPO) $(TEST_MODULE)
	git submodule absorbgitdirs
	git -C test/craftinginterpreters sparse-checkout set test/ tool/
