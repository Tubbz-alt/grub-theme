Version=0.1

PREFIX = /usr/local

CFG = $(wildcard cfg/*.cfg)

THEME = \
	$(wildcard cromnix/*.png) \
	cromnix/theme.txt \
	cromnix/u_vga16_16.pf2

ICONS= $(wildcard cromnix/icons/*.png)

TZ = $(wildcard tz/*)

LOCALES = $(wildcard locales/*)

install_common:
	install -dm0755 $(DESTDIR)$(PREFIX)/share/grub/cfg
	install -m0644 ${CFG} $(DESTDIR)$(PREFIX)/share/grub/cfg

	install -dm0755 $(DESTDIR)$(PREFIX)/share/grub/tz
	install -m0644 ${TZ} $(DESTDIR)$(PREFIX)/share/grub/tz

	install -dm0755 $(DESTDIR)$(PREFIX)/share/grub/locales
	install -m0644 ${LOCALES} $(DESTDIR)$(PREFIX)/share/grub/locales

uninstall_common:
	for f in ${CFG}; do rm -f $(DESTDIR)$(PREFIX)/share/grub/cfg/$$f; done
	for f in ${TZ}; do rm -f $(DESTDIR)$(PREFIX)/share/grub/tz/$$f; done
	for f in ${LOCALES}; do rm -f $(DESTDIR)$(PREFIX)/share/grub/locales/$$f; done

install_cromnix:
	install -dm0755 $(DESTDIR)$(PREFIX)/share/grub/themes/cromnix
	install -m0644 ${THEME} $(DESTDIR)$(PREFIX)/share/grub/themes/cromnix

	install -dm0755 $(DESTDIR)$(PREFIX)/share/grub/themes/cromnix/icons
	install -m0644 ${ICONS} $(DESTDIR)$(PREFIX)/share/grub/themes/cromnix/icons

uninstall_cromnix:
	for f in ${THEME}; do rm -f $(DESTDIR)$(PREFIX)/share/grub/theme/cromnix/$$f; done
	for f in ${ICONS}; do rm -f $(DESTDIR)$(PREFIX)/share/grub/theme/cromnix/icons/$$f; done

install: install_common install_cromnix

uninstall: uninstall_common uninstall_cromnix

dist:
	git archive --format=tar --prefix=grub-theme-$(Version)/ $(Version) | gzip -9 > grub-theme-$(Version).tar.gz
	gpg --detach-sign --use-agent grub-theme-$(Version).tar.gz

.PHONY: install uninstall dist
