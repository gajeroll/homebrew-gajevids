# ------------------------------------------------------------
# Makefile — Homebrew Formula bump & release automation
# ------------------------------------------------------------
#
# Usage
#   $ make release              # bump, commit, tag, push
#   $ TAG=v1.2.3 make release   # use an explicit tag
#
# Requirements
#   • macOS or Linux (BSD or GNU sed supported)
#   • curl, awk, shasum, git
#
# License: MIT
# ------------------------------------------------------------

# GitHub repository (owner/repo)
REPO    := gajeroll/homebrew-gajevids

# Path to the Homebrew formula file
FORMULA := Formula/gajevids.rb

# ------------------------------------------------------------------
# Derive the next tag if TAG is not supplied:
#   • Reads VERSION string in the formula (e.g. "v0.1.7")
#   • Increments the patch number → "v0.1.8"
# ------------------------------------------------------------------
ifeq ($(strip $(TAG)),)
TAG := $(shell \
  awk -F'"' '/VERSION *=/ {sub(/^v/,"",$$2); split($$2,v,"."); v[3]++; \
              printf "v%s.%s.%s\n", v[1], v[2], v[3] }' $(FORMULA))
endif

.PHONY: bump commit tag release

# 1) Download the tarball, compute sha256, and update the formula
bump:
	@echo "→ Bumping $(FORMULA) to $(TAG)"
	curl -sL -o /tmp/$(TAG).tar.gz \
		https://github.com/$(strip $(REPO))/archive/refs/tags/$(TAG).tar.gz
	SHA=$$(shasum -a 256 /tmp/$(TAG).tar.gz | awk '{print $$1}'); \
	\
	# Update VERSION (handles optional leading "v" and varying indent)
	sed -Ei.bak \
		"s/^([[:space:]]*VERSION[[:space:]]*=[[:space:]]*\")v?[0-9]+\.[0-9]+\.[0-9]+/\1$(TAG)/" \
		$(FORMULA) && rm -f $(FORMULA).bak; \
	\
	# Update sha256 (64-char hex)
	sed -Ei.bak \
		"s/^([[:space:]]*sha256[[:space:]]*\")[0-9a-f]{64}/\1$$SHA/" \
		$(FORMULA) && rm -f $(FORMULA).bak; \
	echo "✓ Formula updated (VERSION=$(TAG), sha256=$$SHA)"

# 2) Commit the formula change
commit: bump
	git add $(FORMULA)
	git commit -m "Formula: bump to $(TAG)"

# 3) Tag the commit and push code plus tags
tag: commit
	git tag -a $(TAG) -m "Release $(TAG)"
	git push origin HEAD --tags

# Convenience target: execute the full workflow in one go
release: tag
	@echo "🎉  Release $(TAG) is ready!"
