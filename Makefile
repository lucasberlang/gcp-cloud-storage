.PHONY: changelog release test

changelog:
	git-chglog -o CHANGELOG.md

release:
	semtag final -s minor

test:
	cd ./test/src && go test -timeout 90m
init:
	for d in ./*/*/ ; do (cd "$d" && terraform init -upgrade); done
