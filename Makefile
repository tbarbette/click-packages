# Warning: this file must be usable by regular make
# (unlike the Makefiles in subdirectories).

SHELL = /bin/sh


PACKAGE = click-packages
VERSION = 1.4pre1

srcdir = .


CLICKDIR = $(HOME)/click
SUBDIRS = ip6_natpt models


distdir = $(PACKAGE)-$(VERSION)

dist: distdir
	tar czf $(distdir).tar.gz $(distdir)
distdir:
	for d in $(SUBDIRS); do \
	  cp $(CLICKDIR)/acclick.m4 $(CLICKDIR)/aclocal.m4 $$d; done
	-rm -rf $(distdir)
	mkdir $(distdir)
	chmod 777 $(distdir)
	for file in `cat $(srcdir)/DISTFILES | grep .`; do \
	  if expr "$$file" : '.*:$$' >/dev/null 2>&1; then \
	    d=`echo $$file | sed 's/:$$//;s/^\.\///'`; \
	  elif test -d "$(srcdir)/$$d/$$file"; then \
	    mkdir $(distdir)/$$d/$$file; \
	    chmod 777 $(distdir)/$$d/$$file; \
	  else \
	    for f in `cd $(srcdir)/$$d && echo $$file`; do \
	      test -f "$(distdir)/$$d/$$f" \
	      || ln $(srcdir)/$$d/$$f $(distdir)/$$d/$$f 2> /dev/null \
	      || cp -p $(srcdir)/$$d/$$f $(distdir)/$$d/$$f \
	      || echo "Could not copy $$d/$$f!" 1>&2; \
	  done; fi; \
	done


.PHONY: all always elemlist elemlists \
	bsdmodule exopc linuxmodule ns tools userlevel \
	clean distclean dist distdir \
	install install-doc install-man install-local install-include install-local-include \
	uninstall uninstall-local uninstall-local-include