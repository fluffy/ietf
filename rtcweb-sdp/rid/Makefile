xml2rfc ?= xml2rfc -v
kramdown-rfc2629 ?= kramdown-rfc2629
idnits ?= idnits

all: draft-mmusic-rtp-format-identifier.txt draft-mmusic-rtp-format-identifier.html

clean:
	-rm -f draft-mmusic-rtp-format-identifier.txt draft-mmusic-rtp-format-identifier.html draft-mmusic-rtp-format-identifier.xml

%.xml: %.md
	$(kramdown-rfc2629) $< > $@

%.txt: %.xml
	$(xml2rfc) $< --text --out $@

%.html: %.xml
	$(xml2rfc) $< --html --out $@

