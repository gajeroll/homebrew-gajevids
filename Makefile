# ------------------------------------------------------------
# Makefile — Homebrew Formula bump & release  (dist/ layout)
# ------------------------------------------------------------
# Requirements
#   • macOS or Linux (BSD/GNU sed supported)
#   • git, awk, shasum
# Usage
#   $ make release             # bump, commit, tag, push
#   $ TAG=v1.2.3 make release  # use an explicit tag
# License: MIT
# ------------------------------------------------------------

# GitHub tap repository (owner/repo)
REPO   := gajeroll/homebrew-gajevids
# Path to the formula
FORMULA := Formula/gajevids.rb

# ------------------------------------------------------------
# Auto-increment patch version if TAG is not supplied
# ------------------------------------------------------------
ifeq ($(strip $(TAG)),)
TAG := $(shell \
	awk -F'"' '/VERSION *=/ {sub(/^v/, "", $$2); split($$2,v,"."); v[3]++; \
						printf "v%s.%s.%s\n", v[1], v[2], v[3] }' $(FORMULA))
endif

TMP_TAR    := /tmp/$(TAG).tar.gz
TAR_PREFIX := homebrew-gajevids-$(TAG)/   # must match GitHub prefix

.PHONY: bump commit tag release clean

# ------------------------------------------------------------
# 1) bump:
#    • stage dist/ binaries
#    • archive ONLY dist/ directory to tar.gz
#    • calculate sha256
#    • patch VERSION & sha256 in Formula, then stage Formula
# ------------------------------------------------------------
bump:
	@echo "→ Staging dist/ binaries"
	@git add dist/gajevids dist/gajevids-go

	@echo "→ Creating tarball (dist/ only)"
	@TREE=$$(git write-tree); \
		git archive $$TREE dist --prefix=$(TAR_PREFIX) \
								--format=tar.gz -o $(TMP_TAR)

	@echo "→ Calculating sha256 ..."
	@SHA=$$(shasum -a 256 $(TMP_TAR) | awk '{print $$1}'); \
		echo "   SHA256 = $$SHA"; \
		\
		sed -Ei.bak \
			's/^([[:space:]]*VERSION[[:space:]]*=[[:space:]]*")v?[0-9]+\.[0-9]+\.[0-9]+(".*)/\1$(TAG)\2/' \
			$(FORMULA) && rm -f "$(FORMULA).bak"; \
		sed -Ei.bak \
			's/^([[:space:]]*sha256[[:space:]]*")[0-9a-f]{64}(".*)/\1'"$$SHA"'\2/' \
			$(FORMULA) && rm -f "$(FORMULA).bak"; \
		\
		echo "✓ Patched $(FORMULA) → VERSION=$(TAG), sha256=$$SHA"; \
		echo "→ Staging patched Formula"; \
		git add $(FORMULA)

# ------------------------------------------------------------
# 2) commit : commit the staged changes
# ------------------------------------------------------------
commit: bump
	git commit -m "gajevids $(TAG) (dist layout)"

# ------------------------------------------------------------
# 3) tag : create annotated tag and push
# ------------------------------------------------------------
tag: commit
	git tag -a $(TAG) -m "Release $(TAG)"
	git push origin main --tags

# ------------------------------------------------------------
# 4) release : bump → commit → tag
# ------------------------------------------------------------
release: tag
	@echo "🎉  Release $(TAG) pushed."
	@echo "    Tarball URL:"
	@echo "    https://github.com/$(REPO)/archive/refs/tags/$(TAG).tar.gz"

# ------------------------------------------------------------
# clean : delete temporary tarball
# ------------------------------------------------------------
clean:
	@rm -f $(TMP_TAR)
