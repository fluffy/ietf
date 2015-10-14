MD      := $(wildcard *.md)
XML     := $(patsubst %.md,%.xml,$(MD))
HTML    := $(patsubst %.md,%.html,$(MD))
TXT     := $(patsubst %.md,%.txt,$(MD))

xml2rfc ?= xml2rfc -v
kramdown-rfc2629 ?= kramdown-rfc2629
idnits ?= idnits

all:  $(TXT) $(HTML)

clean:
	-rm -f $(TXT) $(HTML) $(XML)

%.xml: %.md
	$(kramdown-rfc2629) $< > $@

%.txt: %.xml
	$(xml2rfc) $< --text --out $@

%.html: %.xml
	$(xml2rfc) $< --html --out $@

