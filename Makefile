# ------------------------------------------------------------
# Makefile — Homebrew Formula bump & release (dist/ layout)
# ------------------------------------------------------------
# Requirements
#   • macOS or Linux (BSD or GNU sed supported)
#   • git, awk, shasum
# Usage
#   $ make release            # bump version, commit, tag, push
#   $ TAG=v1.2.3 make release # use an explicit tag
# License: MIT
# ------------------------------------------------------------

REPO        := gajeroll/homebrew-gajevids        # GitHub tap repository
FORMULA     := Formula/gajevids.rb               # Formula path

# ------------------------------------------------------------
# Auto-increment patch version (vX.Y.Z → vX.Y.(Z+1))
# ------------------------------------------------------------
ifeq ($(strip $(TAG)),)
TAG := $(shell \
  awk -F'"' '/VERSION *=/ {sub(/^v/, "", $$2); split($$2,v,"."); v[3]++; \
            printf "v%s.%s.%s\n", v[1], v[2], v[3] }' $(FORMULA))
endif

TMP_TAR     := /tmp/$(TAG).tar.gz
# GitHub’s automatic tarball prefix is "<repo>-<tag>/" — keep it identical
TAR_PREFIX  := homebrew-gajevids-$(TAG)/

.PHONY: bump commit tag release clean

# ------------------------------------------------------------
# 1) bump
#    • create a tarball of HEAD
#    • calculate its sha256
#    • patch VERSION and sha256 in the Formula
# ------------------------------------------------------------
bump:
	@echo "→ Archiving current tree to $(TMP_TAR)"
	@git archive --format=tar.gz --prefix=$(TAR_PREFIX) -o $(TMP_TAR) HEAD
	@echo "→ Calculating sha256 ..."
	@SHA=$$(shasum -a 256 $(TMP_TAR) | awk '{print $$1}'); \
	 echo "   SHA256 = $$SHA"; \
	 \
	 # --- update VERSION ---
	 sed -Ei.bak \
	     "s/^([[:space:]]*VERSION[[:space:]]*=[[:space:]]*\")v?[0-9]+\.[0-9]+\.[0-9]+/\1$(TAG)/" \
	     $(FORMULA) && rm -f $(FORMULA).bak; \
	 \
	 # --- update sha256 ---
	 sed -Ei.bak \
	     "s/^([[:space:]]*sha256[[:space:]]*\")[0-9a-f]{64}/\1$$SHA/" \
	     $(FORMULA) && rm -f $(FORMULA).bak; \
	 \
	 echo "✓ Patched $(FORMULA) → VERSION=$(TAG), sha256=$$SHA"

# ------------------------------------------------------------
# 2) commit : stage dist/ binaries and Formula, then commit
# ------------------------------------------------------------
commit: bump
	git add dist/gajevids dist/gajevids-go $(FORMULA)
	git commit -m "gajevids $(TAG) (dist layout)"

# ------------------------------------------------------------
# 3) tag : create an annotated tag and push with code
# ------------------------------------------------------------
tag: commit
	git tag -a $(TAG) -m "Release $(TAG)"
	git push origin main --tags

# ------------------------------------------------------------
# 4) release : convenience target (bump → commit → tag)
# ------------------------------------------------------------
release: tag
	@echo "🎉  Release $(TAG) pushed."
	@echo "    Homebrew tarball URL:"
	@echo "    https://github.com/$(REPO)/archive/refs/tags/$(TAG).tar.gz"

# ------------------------------------------------------------
# clean : remove temporary archive
# ------------------------------------------------------------
clean:
	@rm -f $(TMP_TAR)
