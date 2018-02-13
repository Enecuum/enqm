.PHONY: default gitignore quickdevCommitAndPush history

default: gitignore quickdevCommitAndPush

gitignore:
	./.gitignore

quickdevCommitAndPush:
	git branch | grep -q '^\* quickdev.*' && git add -Av && git commit -a --allow-empty-message --no-edit && git push --all > /dev/null 2> /dev/null && echo pushed || echo not pushed

history:
	git log | awk '{ print $$0 } /^commit /{ print "==============================================="; commit = $$2 } /^Date: /{ print ""; system("git diff --color " commit); }' | less -R

