TESTMOD := testmod
TESTMOD_REPO := https://github.com/munificent/craftinginterpreters.git

test: $(TESTMOD)
	: || dart $(TESTMOD)/tool/bin/test.dart

$(TESTMOD):
	# This target makes a commit. Empty the staging area.
	@[[ -z "$$(git ls-files)" ]]
	git submodule add '$(TESTMOD_REPO)' $(TESTMOD)
	git commit -m '[MAKE]: add module, $(TESTMOD)'
	# sparse-checkout: /test/, /tool/
	@git -C $(TESTMOD) config core.sparsecheckout true
	@echo $$'/test/\n/tool/' > .git/modules/$(TESTMOD)/info/sparse-checkout
	@git -C $(TESTMOD) read-tree -mu HEAD
