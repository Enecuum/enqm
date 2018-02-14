.PHONY: default gitignore quickdevCommitAndPush history quickdev make-quickdev README bin clean prepare compile

quickdev := $(shell mktemp -u "quickdev-`date '+%Y%m%d%H%M%S'`-XXXXX")
generated = $(shell find Enqm/API/UnixShell/Generated -name "*.hs" | sed 's,\.hs$$,,' | sed 's,Generated,Generated/bin,')

default: gitignore quickdevCommitAndPush bin
	./enqin

gitignore:
	@./.gitignore

quickdevCommitAndPush: README
	@git branch | grep -q '^\* quickdev.*' && git add -Av && (git commit -a --allow-empty-message --no-edit && echo commited || true) && git push --all > /dev/null 2> /dev/null && echo pushed || echo not pushed

history:
	@git log | awk '{ print $$0 } /^commit /{ print "==============================================="; commit = $$2 } /^Date: /{ print ""; system("git diff --summary --color " commit); print ""; system("git diff --color " commit); }' | less -R

quickdev: make-quickdev quickdevCommitAndPush

make-quickdev:
	git branch $(quickdev)
	git checkout $(quickdev)

list: gitignore
	@awk '/^#GENERATED/ { a = 1 } { if(a>0) { if (a>1) { print $0; }; a++; } }' < .gitignore | sed 's,^!,,' | awk '{ system("ls -dla --color=always " $$0); }' | column -t | less -R


README: gitignore
	@awk '/^\| Size \|    \| Date \|    \| Path \|/{ a = 1 } { if (!(a==1)) { print $0 } }' < README.md > /tmp/.$(quickdev)
	@cat /tmp/.$(quickdev) > README.md
	@echo "| Size |    | Date |    | Path |" >> README.md
	@echo "|----|----|----|----|-------|" >> README.md
	
	@awk '/^#GENERATED/ { a = 1 } { if(a>0) { if (a>1) { print $0; }; a++; } }' < .gitignore | sed 's,^!,,' | awk '{ system("ls -dla " $$0); }' | awk '{ for (i = 1; i < NF; i++) { if (i < 5) { $$i = "" } else { $$i = "``" $$i "``|" } } $$(NF) = ("[``" $$(NF) "``](" $$(NF) ")"); print("| " $$0 " |") }' >> README.md

bin: prepare
	make compile

prepare:
	@mkdir Enqm/API/UnixShell/Generated/bin 2> /dev/null || true
	@echo "generate" | ghci Enqm/API/UnixShell/Generated.hs > /dev/null 2> /dev/null

compile: enqin $(generated)
	@ln -sf ../../../../../enqin Enqm/API/UnixShell/Generated/bin/
	@ls -l Enqm/API/UnixShell/Generated/bin

enqin: enqin.hs
	ghc --make $< -o $@

Enqm/API/UnixShell/Generated/bin/%: Enqm/API/UnixShell/Generated/%.hs
	ghc --make $< -o $@

clean:
	find -name "*.o" -or -name "*.hi" -exec rm {} \;
	rm -Rf enqin Enqm/API/UnixShell/Generated/*



