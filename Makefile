.PHONY: default gitignore quickdevCommitAndPush history quickdev make-quickdev README

quickdev := $(shell mktemp -u "quickdev-`date '+%Y%m%d%H%M%S'`-XXXXX")

default: gitignore quickdevCommitAndPush

gitignore:
	@./.gitignore

quickdevCommitAndPush:
	@git branch | grep -q '^\* quickdev.*' && git add -Av && git commit -a --allow-empty-message --no-edit && echo commited && git push --all > /dev/null 2> /dev/null && echo pushed || echo not pushed

history:
	@git log | awk '{ print $$0 } /^commit /{ print "==============================================="; commit = $$2 } /^Date: /{ print ""; system("git diff --summary --color " commit); print ""; system("git diff --color " commit); }' | less -R

quickdev: make-quickdev quickdevCommitAndPush

make-quickdev:
	git branch $(quickdev)
	git checkout $(quickdev)

list: gitignore
	@awk '/^#GENERATED/ { a = 1 } { if(a>0) { if (a>1) { print $0; }; a++; } }' < .gitignore | sed 's,^!,,' | awk '{ system("ls -dla --color=always " $$0); }' | column -t | less -R


README: gitignore
	@echo > README.md
	@awk '/^#GENERATED/ { a = 1 } { if(a>0) { if (a>1) { print $0; }; a++; } }' < .gitignore | sed 's,^!,,' | awk '{ system("ls -dla " $$0); }' | awk '{ for (i = 0; i < NF; i++) { $$(NF) = "``" $$(NF) "``" } $$(NF) = ("[``" $$(NF) "``](" $$(NF) ")"); printf("* %s\n",$$0) }' | column -t | expand | sed 's,  ,<space>,g' >> README.md


