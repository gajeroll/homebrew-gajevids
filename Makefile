# Makefile for Homebrew Formula update automation

TAG ?= v0.1.3
REPO = gajeroll/homebrew-gajevids
FORMULA = Formula/gajevids.rb


.PHONY: tag update-formula release

tag:
	git tag $(TAG)
	git push origin $(TAG)

update-formula:
	@echo "Fetching tarball for $(TAG) from GitHub..."
	curl -sL -o /tmp/$(TAG).tar.gz https://github.com/$(REPO)/archive/refs/tags/$(TAG).tar.gz
	@echo "Calculating sha256..."
	SHA=$$(shasum -a 256 /tmp/$(TAG).tar.gz | awk '{print $$1}'); \
	echo "SHA256: $$SHA"; \
	sed -i '' -e "s|url \"https://github.com/.*/archive/refs/tags/v[0-9.]*.tar.gz\"|url \"https://github.com/$(REPO)/archive/refs/tags/$(TAG).tar.gz\"|" $(FORMULA); \
	sed -i '' -e "s|sha256 \"[a-f0-9]*\"|sha256 \"$$SHA\"|" $(FORMULA); \
	sed -i '' -e "s|assert_match \"gajevids v[0-9.]*\"|assert_match \"gajevids $(TAG)\"|" $(FORMULA); \
	echo "Updated $(FORMULA) to $(TAG) with sha256=$$SHA and test version."

release: tag update-formula
	@echo "Tag $(TAG) created, pushed, and formula updated."
