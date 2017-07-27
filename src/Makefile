#!/usr/bin/make -f

SOURCE = token.st core.st login.st poll.st webapp.st
LOAD = $(SOURCE:.st=.load)

build: seaside.im webapp.st
	$(MAKE) stopserver
	$(MAKE) runserver
	sleep 5
	$(MAKE) -C nettle GSTREMOTE="gst-remote 127.0.0.1"
	$(MAKE) $(LOAD)
	gst-remote --snapshot 127.0.0.1
	$(MAKE) stopserver

%.load: %.st
	gst-remote --file $< 127.0.0.1

devimage:
	gst-load -iI seaside.im Seaside Seaside-Development SandstoneDb

seaside.im:
	gst-load -iI seaside.im Seaside SandstoneDb

runserver:
	gst-remote -I seaside.im --daemon --start=Seaside 127.0.0.1

stopserver:
	-gst-remote --kill 127.0.0.1
