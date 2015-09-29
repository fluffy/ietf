xml2rfc ?= xml2rfc -v
kramdown-rfc2629 ?= kramdown-rfc2629
idnits ?= idnits

all:  draft-pthatcher-mmusic-rtp-stream-identifier-00.txt draft-pthatcher-mmusic-rtp-stream-identifier-00.html

clean:
	-rm -f draft-pthatcher-mmusic-rtp-stream-identifier-00.txt draft-pthatcher-mmusic-rtp-stream-identifier-00.html draft-pthatcher-mmusic-rtp-stream-identifier-00.xml

%.xml: %.md
	$(kramdown-rfc2629) $< > $@

%.txt: %.xml
	$(xml2rfc) $< --text --out $@

%.html: %.xml
	$(xml2rfc) $< --html --out $@

