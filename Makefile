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
LIBDIR = $(DESTDIR)$(PREFIX)/lib/python3.7/dist-packages/ssh_autoconfig
PARTSDIR ?= /etc/ssh/ssh_config_parts
# links to the execuatble
LINKS = /etc/network/if-up.d/ssh-autoconfig /etc/network/if-post-down.d/ssh-autoconfig

BIN = bin/ssh-autoconfig
LIBS = $(shell find ssh_autoconfig -type f)
PARTS = $(shell find ssh_config_parts -type f)

.PHONY: all install install-links install-parts install-program install-nolinks uninstall

checkroot:
	@# check if run as root
	@runner=`whoami` ; \
	if test "$$runner" != "root" -a "$(PREFIX)" = "/usr/local" ; \
	then \
		echo "You need to be root to install this program." ; \
		exit 1 ; \
	fi

all:
	$(info Nothing to compile. Type 'make install' to install or 'make uninstall' to uninstall.)

install: install-links install-nolinks

install-links: checkroot
	$(foreach linkloc, $(LINKS), $(LINK) -fs $(BINDIR)/$(notdir $(BIN)) $(linkloc);)

install-parts: checkroot
	$(INSTALL) -m 0644 -D -t $(PARTSDIR) $(PARTS)

install-program: checkroot
	$(INSTALL) -m 0755 -D -t $(BINDIR) $(BIN)
	$(INSTALL) -m 0644 -D -t $(LIBDIR) $(LIBS)

install-nolinks: install-parts install-program

uninstall: checkroot
	rm -rf $(BINDIR)/$(BIN)
	rm -rf $(LIBDIR)
	rm -rf $(PARTSDIR)
	rm -rf $(LINKS)
