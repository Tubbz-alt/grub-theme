VERSION=0.3

PKG = grub-theme
PREFIX = /usr/local
FMODE = -m0644
DMODE = -dm0755
RM = rm -f

CFG = $(wildcard cfg/*.cfg)

THEME = \
	$(wildcard artix/*.png) \
	artix/theme.txt \
	artix/u_vga16_16.pf2

ICONS= $(wildcard artix/icons/*.png)

TZ = $(wildcard tz/*)

LOCALES = $(wildcard locales/*)

install_common:
	install $(DMODE) $(DESTDIR)$(PREFIX)/share/grub/cfg
	install $(FMODE) $(CFG) $(DESTDIR)$(PREFIX)/share/grub/cfg

	install $(DMODE) $(DESTDIR)$(PREFIX)/share/grub/tz
	install $(FMODE) $(TZ) $(DESTDIR)$(PREFIX)/share/grub/tz

	install $(DMODE) $(DESTDIR)$(PREFIX)/share/grub/locales
	install $(FMODE) $(LOCALES) $(DESTDIR)$(PREFIX)/share/grub/locales

uninstall_common:
	for f in $(notdir $(CFG)); do $(RM) $(DESTDIR)$(PREFIX)/share/grub/cfg/$$f; done
	for f in $(notdir $(TZ)); do $(RM) $(DESTDIR)$(PREFIX)/share/grub/tz/$$f; done
	for f in $(notdir $(LOCALES)); do $(RM) $(DESTDIR)$(PREFIX)/share/grub/locales/$$f; done

install_theme:
	install $(DMODE) $(DESTDIR)$(PREFIX)/share/grub/themes/artix
	install $(FMODE) $(THEME) $(DESTDIR)$(PREFIX)/share/grub/themes/artix

	install $(DMODE) $(DESTDIR)$(PREFIX)/share/grub/themes/artix/icons
	install $(FMODE) $(ICONS) $(DESTDIR)$(PREFIX)/share/grub/themes/artix/icons

uninstall_theme:
	for f in $(notdir $(THEME)); do $(RM) $(DESTDIR)$(PREFIX)/share/grub/theme/artix/$$f; done
	for f in $(notdir $(ICONS)); do $(RM) $(DESTDIR)$(PREFIX)/share/grub/theme/artix/icons/$$f; done

install: install_common install_theme

uninstall: uninstall_common uninstall_theme

dist:
	git archive --format=tar --prefix=$(PKG)-$(VERSION)/ $(VERSION) | gzip -9 > $(PKG)-$(VERSION).tar.gz
	gpg --detach-sign --use-agent $(PKG)-$(VERSION).tar.gz

.PHONY: install uninstall dist
