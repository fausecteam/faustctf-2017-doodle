#!/usr/bin/make -f

USER    ?= doodle
HOME    ?= /srv/doodle

DEBS	= files/gnu-smalltalk_3.2.5-1_amd64.deb files/gnu-smalltalk-common_3.2.5-1_all.deb files/libgst7_3.2.5-1_amd64.deb

build: dpkg
	$(MAKE) -C src build

%.deb:
	(cd files; wget -q https://ctf00.informatik.uni-erlangen.de/dl/doodle/$@)

dpkg: $(DEBS)
	sha256sum -c files/SHA256SUM
	dpkg -i $^

install: build dpkg
	install -m 700 -o $(USER) -d $(HOME)/seaside.im.SandstoneDb
	install -m 755 -o root src/keygen $(HOME)/
	install -m 755 -o root src/seaside.im $(HOME)/
	install -m 644 -o root src/*.st src/Makefile $(HOME)/
	install -m 755 -o root -d $(HOME)/nettle/
	install -m 644 -o root src/nettle/*.st src/nettle/Makefile $(HOME)/
	install -m 644 -o root doodle.service /etc/systemd/system/
	install -m 644 -o root nginx/doodle /etc/nginx/sites-enabled/
	install -m 755 -o root -d $(HOME)/wwwroot/css
	install -m 644 -o root src/css/doodle.css $(HOME)/wwwroot/css/
	install -m 644 -o root src/css/font-awesome.min.css $(HOME)/wwwroot/css/
	install -m 644 -o root src/css/pure-min.css $(HOME)/wwwroot/css/
	install -m 755 -o root -d $(HOME)/wwwroot/fonts
	install -m 644 -o root src/fonts/fontawesome-webfont.eot $(HOME)/wwwroot/fonts/
	install -m 644 -o root src/fonts/fontawesome-webfont.svg $(HOME)/wwwroot/fonts/
	install -m 644 -o root src/fonts/fontawesome-webfont.ttf $(HOME)/wwwroot/fonts/
	install -m 644 -o root src/fonts/fontawesome-webfont.woff $(HOME)/wwwroot/fonts/
	install -m 644 -o root src/fonts/fontawesome-webfont.woff2 $(HOME)/wwwroot/fonts/
	systemctl enable doodle.service
