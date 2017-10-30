
#   https://pypi.python.org/pypi/xml2rfc
xml2rfc ?= xml2rfc
#   https://github.com/cabo/kramdown-rfc2629
kramdown-rfc2629 ?= kramdown-rfc2629
#  mmark (https://github.com/miekg/mmark)
mmark ?= mmark

DRAFT = draft-nandakumar-suit-secfu-solution-arch
VERSION = 00

.PHONY: all clean diff
.PRECIOUS: %.xml

all: $(DRAFT)-$(VERSION).txt $(DRAFT)-$(VERSION).html 

diff: $(DRAFT).diff.html

clean:
	-rm -f $(DRAFT)-$(VERSION).{txt,html,xml,pdf} $(DRAFT).diff.html

%.txt: %.xml
	$(xml2rfc) $< -o $@ --text

%.html: %.xml
	$(xml2rfc) $< -o $@ --html

$(DRAFT)-$(VERSION).xml: $(DRAFT).md 
	mmark -xml2 -page $^ $@ 

$(DRAFT).diff.html: $(DRAFT)-$(VERSION).txt $(DRAFT)-old.txt 
	htmlwdiff   $(DRAFT)-old.txt   $(DRAFT)-$(VERSION).txt >   $(DRAFT).diff.html


