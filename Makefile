#############################
# ffmpeg-install (Makefile) #
#############################

PREFIX=/usr

install:
	cp -rfv src/ffmpeg-install $(PREFIX)/bin
	chmod +x $(PREFIX)/bin/ffmpeg-install
	
uninstall:
	rm $(PREFIX)/bin/ffmpeg-install

