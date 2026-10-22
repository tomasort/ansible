# Makefile — one-command vault plumbing for this repo.
# Detection is content-based (vault header on first line), so the file
# list can never go stale the way a manual manifest (old encrypted.txt) did.

# Any file named vault*.yml anywhere in this repo (excluding .git / .ansible
# which only hold vendored Galaxy artifacts), plus the vaulted SSH keys.
# .yml-only by design — vault.txt (the vault password itself) must never be
# wrapped.
CANDIDATES := $(shell find . -name 'vault*.yml' -not -path './.git/*' -not -path './.ansible/*' 2>/dev/null; ls roles/*/files/.ssh/* 2>/dev/null)

# Files still plaintext (would be touched by `make encrypt`)
PLAIN := $(shell for f in $(CANDIDATES); do \
	head -n1 "$$f" 2>/dev/null | grep -q '^\$$ANSIBLE_VAULT' || printf '%s ' "$$f"; \
done)

# Files already vault-encrypted (would be touched by `make decrypt`)
VAULTED := $(shell for f in $(CANDIDATES); do \
	head -n1 "$$f" 2>/dev/null | grep -q '^\$$ANSIBLE_VAULT' && printf '%s ' "$$f"; \
done)

.PHONY: encrypt decrypt list roles install

# ansible-vault's own output is uninformative; recipes run it quietly and
# report the per-file state themselves.

encrypt:
	@if [ -z "$(PLAIN)" ]; then \
		echo "encrypt: nothing to do — all secret files are already encrypted"; \
	else \
		for f in $(PLAIN); do echo "encrypting:  $$f"; done; \
		ansible-vault encrypt --quiet $(PLAIN); \
		for f in $(VAULTED); do echo "already ok:  $$f"; done; \
		echo "done: $(words $(PLAIN)) encrypted, $(words $(VAULTED)) already vaulted"; \
	fi

decrypt:
	@if [ -z "$(VAULTED)" ]; then \
		echo "decrypt: nothing to do — all secret files are already plaintext"; \
	else \
		for f in $(VAULTED); do echo "decrypting:  $$f"; done; \
		ansible-vault decrypt --quiet $(VAULTED); \
		for f in $(PLAIN); do echo "already ok:  $$f"; done; \
		echo "done: $(words $(VAULTED)) decrypted, $(words $(PLAIN)) already plaintext"; \
	fi

# Read-only status view — shows classification without touching anything.
list:
	@echo "plaintext secrets:"; for f in $(PLAIN); do echo "  $$f"; done
	@echo "vault-encrypted:";  for f in $(VAULTED); do echo "  $$f"; done
	@echo "(vault password and sudo password come from ansible.cfg via vault.txt/become.txt)"

# Galaxy role + collection install (same as ./install -r)
roles:
	./install -r

# Full first-run bootstrap (ansible itself + requirements) on top of
# ./install — the script stays the single source of OS/bootstrap logic
# on purpose: a fresh Mac has no `make` until it installs ansible.
install:
	./install
