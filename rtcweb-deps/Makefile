
NAME=draft-jennings-rtcweb-deps
VERSION=10

MD=mmark --bib-rfc "/Users/fluffy/bibxml/" --bib-id "/Users/fluffy/bibxml/" 
X2R=xml2rfc
CF=cupsfilter

all: txt html

txt: $(NAME)-$(VERSION).txt
html: $(NAME)-$(VERSION).html
pdf: $(NAME)-$(VERSION).pdf

clean:
	rm -f $(NAME)-??.txt $(NAME)-??.xml $(NAME)-??.html $(NAME)-??.pdf


$(NAME)-$(VERSION).pdf: $(NAME)-$(VERSION).txt
	$(CF) $(NAME)-$(VERSION).txt >$(NAME)-$(VERSION).pdf

$(NAME)-$(VERSION).txt: $(NAME)-$(VERSION).xml
	$(X2R) $(NAME)-$(VERSION).xml --text 

$(NAME)-$(VERSION).html: $(NAME)-$(VERSION).xml
	$(X2R) $(NAME)-$(VERSION).xml --html

$(NAME)-$(VERSION).xml: $(NAME).md
	$(MD)  -xml2 -page $(NAME).md > $(NAME)-$(VERSION).xml

