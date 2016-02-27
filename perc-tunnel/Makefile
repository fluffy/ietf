

draft := draft-jones-perc-dtls-tunnel-01

all: $(draft).txt $(draft).html 

clean:
	-rm -f $(draft).txt $(draft).html $(draft).xml

%.xml: %.md
	mmark -xml2 -page  $< > $@

%.txt: %.xml
	xml2rfc --text $< 

%.html: %.xml
	xml2rfc --html $< 

