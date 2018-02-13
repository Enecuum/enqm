PHONY: default gitignore quickdevCommitAndPush

default: gitignore quickdevCommitAndPush

gitignore:
	./.gitignore

quickdevCommitAndPush:
	git branch | grep -q '^\* quickdev.*' && git add -Av && git commit -a --allow-empty-message --no-edit && git push --all > /dev/null 2> /dev/null && echo pushed || echo not pushed

