# Makefile for Homebrew Formula update automation

REPO     = gajeroll/homebrew-gajevids       # GitHub repository
FORMULA  = Formula/gajevids.rb              # Formula location

# --- 次のタグを自動計算 (パッチ番号+1) -----------------------------
ifeq ($(strip $(TAG)),)
# VERSION 行の "v0.1.7" → 0.1.7 → 配列 → パッチ+1 → v0.1.8
TAG := $(shell awk -F'"' '/VERSION *= *"/ {sub(/^v/,"",$${2}); split($${2},v,"."); v[3]++; print "v"v[1]"."v[2]"."v[3]}' $(FORMULA))
endif
# ------------------------------------------------------------------

.PHONY: tag update-formula release

tag:
	git tag "$(TAG)"
	git push origin "$(TAG)"

update-formula:
	@echo "Fetching tarball for $(TAG) from GitHub ..."
	curl -sL -o /tmp/"$(TAG)".tar.gz \
		https://github.com/"$(REPO)"/archive/refs/tags/"$(TAG)".tar.gz
	@echo "Calculating sha256 ..."
	SHA=$$(shasum -a 256 /tmp/"$(TAG)".tar.gz | awk '{print $$1}'); \
	echo "SHA256: $$SHA"; \
	\
	# ---- VERSION を更新 ----
	#   ・行頭の空白数は可変対応
	#   ・v の有無を許容 (v0.1.7 / 0.1.7)
	#   ・バックアップ (.bak) を残さず削除
	sed -Ei.bak \
		"s/^([[:space:]]*VERSION[[:space:]]*=[[:space:]]*\")v?[0-9]+\.[0-9]+\.[0-9]+(\".*)/\1$(TAG)\2/" \
		$(FORMULA) && rm -f $(FORMULA).bak; \
	\
	# ---- sha256 を更新 ----
	sed -Ei.bak \
		"s/^([[:space:]]*sha256[[:space:]]*\")[0-9a-f]{64}(\".*)/\1$$SHA\2/" \
		$(FORMULA) && rm -f $(FORMULA).bak; \
	\
	echo "Updated $(FORMULA) → VERSION=$(TAG), sha256=$$SHA"

release: tag update-formula
	@echo "Tag $(TAG) created, pushed, and formula updated."
