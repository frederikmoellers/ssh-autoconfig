#!/usr/bin/make -f

# makefile for easy install/uninstall

# install binary
INSTALL ?= /usr/bin/install
# link binary
LINK ?= /bin/ln
# target directories
PREFIX ?= /usr/local
BINDIR = $(DESTDIR)$(PREFIX)/sbin
# WARNING: This path doesn't work with PREFIX=/usr! (TODO: Use setuptools?)
LIBDIR = $(DESTDIR)$(PREFIX)/lib/python3.5/dist-packages/ssh_autoconfig
PARTSDIR ?= /etc/ssh/ssh_config_parts
# links to the execuatble
LINKS = /etc/network/if-up.d/ssh-autoconfig /etc/network/if-post-down.d/ssh-autoconfig

BIN = ssh-autoconfig
LIBS = __init__.py zones.py zones_user.py
PARTS = $(shell find ssh_config_parts -type f)

.PHONY: all install uninstall

all:
	$(info Nothing to compile. Type 'make install' to install or 'make uninstall' to uninstall.)

install:
	$(INSTALL) -m 0755 -D -t $(BINDIR) $(BIN)
	$(INSTALL) -m 0644 -D -t $(LIBDIR) $(LIBS)
	$(INSTALL) -m 0644 -D -t $(PARTSDIR) $(PARTS)
	# create links
	$(foreach linkloc, $(LINKS), $(LINK) -fs $(BINDIR)/$(BIN) $(linkloc);)

uninstall:
	rm -rf $(BINDIR)/$(BIN)
	rm -rf $(LIBDIR)
	rm -rf $(PARTSDIR)
	rm -rf $(LINKS)