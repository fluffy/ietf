# Generic Makefile for Internet Drafts v1.5
#                      (c) 2015 Ari Keranen
# =========================================


# Settings

# You may override any of these by setting environment variables with the same
# name and using "make -e". For example: "PV=10 make -e showdiff"
# or to set value permanently (for the shell session) "export PV=10",
# or with make command line arguments: "make PV=10 showdiff"

# The default name of the Internet Draft XML file (without xml extension)
DRAFT = draft-ietf-mmusic-ice-sip-sdp

# The version control system in use “git” or “svn”
VCS = svn
# The default Previous Version against which a html diff is made
# for SVN it’s the SVN version number, for git it’s the <rev> parameter
PV = HEAD
# Should use web tools for XML2RFC and RFCDIFF instead of local tools? 1 = true, 0 = false.
WEB=1

# where to find/store the local references
REFS = ../bibxml
# command used to start xml2rfc
XML2RFC = xml2rfc
# command used to start rfcdiff
RFCDIFF = rfcdiff
# command used to start idnits
IDNITS = idnits

# programs used to show the resulting txt and html files and doing spellcheck
SHOWC = firefox
SPELLCHECKC = aspell --lang=en_US.iso88591 -p ./ok-words.txt -c
# program to use for editing the XML source
XMLEDITOR = xemacs
# command for running curl (for on-line tools)
CURLCMD = curl

# sed command for regular expression support
SEDRECMD = sed -re
WHICHCMD = which

# what to look for (grep) when making "todo" target
TODOMARK = TODO

# Mac OSX specific settings
ifeq ($(shell uname -s),Darwin)
  SEDRECMD = sed -E -e
  WHICHCMD = which -s
  SHOWC = open -a Safari
  XMLEDITOR = /Applications/Aquamacs.app/Contents/MacOS/Aquamacs
endif

# Stuff that you probably don't want to touch..
BIBURL = rsync1.xml.resource.org::xml2rfc.bibxml
# url for on-line XML2RFC converter
XML2RFCWEB = http://xml2rfc.ietf.org/cgi-bin/xml2rfc.cgi
# url for on-line rfcdiff
RFCDIFFWEB = http://tools.ietf.org/rfcdiff
DRAFTXML = $(DRAFT).xml
DRAFTTXT = $(DRAFT).txt
DRAFTHTML = $(DRAFT).html
OLDXML = $(DRAFT).r$(PV).xml
OLDTXT = $(OLDXML:.xml=.txt)
DIFFHTML = $(OLDXML)-diff.html
CURLTMP = curltempoutput.tmp

FINALTXT=$(shell grep -m 1 "docName=" $(DRAFTXML) | $(SEDRECMD) 's/^.*docName="([^\"\.]*).*/\1/').txt
THIS_YEAR=$(shell date +%Y)
PREV_YEAR=$(shell echo $$(($(THIS_YEAR) - 1)))

.PHONY = all txt html bib show showhtml clean check diff showdiff final coffee targets


# Make targets

all: txt

again: clean all

edit:
	$(XMLEDITOR) $(DRAFTXML) &

txt: $(DRAFTTXT)

html: $(DRAFTHTML)

bib:
	@if ! test -d $(REFS); then mkdir $(REFS); fi
	rsync -zr $(BIBURL)/bibxml/ $(REFS)
	rsync -zr $(BIBURL)/bibxml3/ $(REFS)

$(DRAFTXML):

%.txt: %.xml
	XML_LIBRARY=$(REFS) $(XML2RFC) $* $*.txt

%.html: %.xml 
	XML_LIBRARY=$(REFS) $(XML2RFC) $* $*.html	

$(DRAFTTXT): $(DRAFTXML)
	@if ! [ -e $(DRAFTXML) ];then echo "No $(DRAFTXML) found; rename your draft XML file to $(DRAFTXML) or define the file name with environment variable DRAFT and make with option -e";	exit 1; fi
ifeq ($(WEB),1)
	@if ! $(WHICHCMD) $(CURLCMD); then echo "Need curl ('$(CURLCMD)') for using the webtools"; exit 1; fi
	$(CURLCMD) -F checking=fast -F input=@$(DRAFTXML) -o $(CURLTMP) $(XML2RFCWEB)
	! grep "^\[Error\]" $(CURLTMP)
	mv $(CURLTMP) $(DRAFTTXT)
else
	@if ! test -d $(REFS); then make bib; fi
	XML_LIBRARY=$(REFS) $(XML2RFC) $(DRAFT) $(DRAFTTXT)
endif

show: txt
	$(SHOWC) $(DRAFTTXT)

showhtml: html
	$(SHOWC) $(DRAFTHTML)

clean:
	@if [ -e $(DRAFTTXT) ]; then rm $(DRAFTTXT); fi
	@if [ -e $(DRAFTHTML) ]; then rm $(DRAFTHTML); fi
	@if [ -e $(OLDXML) ]; then rm $(OLDXML); fi
	@if [ -e $(OLDTXT) ]; then rm $(OLDTXT); fi
	@if [ -e $(DIFFHTML) ]; then rm $(DIFFHTML); fi
	@if [ -e $(DRAFT).r*.* ]; then rm $(DRAFT).r*.*; fi

check: $(DRAFTTXT)
	$(SPELLCHECKC) $(DRAFTTXT)

diff: $(DRAFTTXT)
ifeq ($(strip $(PV)),)
	@echo "No PV environment variable defined; can't make a diff"
	@exit 1
endif
ifeq ($(VCS),svn)
	svn export -r $(PV) $(DRAFTXML) $(OLDXML)
else
	git show $(PV):./$(DRAFTXML) > $(OLDXML)
endif
# align years in the different versions (if needed)
	@sed -iyearfix -e 's/<date year="$(PREV_YEAR)"/<date year="$(THIS_YEAR)"/' $(OLDXML)
ifeq ($(WEB),1)
	$(CURLCMD) -F checking=fast -F input=@$(OLDXML) -o $(CURLTMP) $(XML2RFCWEB)
	! grep "^\[Error\]" $(CURLTMP)
	! grep "xml2rfc: error" $(CURLTMP)
	mv $(CURLTMP) $(OLDTXT)
	$(CURLCMD) -F filename1=@$(OLDTXT) -F filename2=@$(DRAFTTXT) -o $(DIFFHTML) $(RFCDIFFWEB)
else
	XML_LIBRARY=$(REFS) $(XML2RFC) $(OLDXML) $(OLDTXT)
	$(RFCDIFF) --stdout $(OLDTXT) $(DRAFTTXT) > $(DIFFHTML)
endif

showdiff: diff
	$(SHOWC) $(DIFFHTML)

todo:
	- ! grep $(TODOMARK) $(DRAFTXML)

final: $(DRAFTTXT) check todo
	@cp $(DRAFTTXT) $(FINALTXT)
	$(IDNITS) $(FINALTXT)
	@echo "Final version: $(FINALTXT)"

coffee:
	@echo "Don't know how to make coffee... yet!"

targets:
	@echo "all:       same as txt (default)"
	@echo "txt:       make text version of the draft"
	@echo "html:      make HTML version of the draft"
	@echo "edit:      open the XML source in $(XMLEDITOR) (defined with XMLEDITOR)"
	@echo "bib:       update/create XML bibliography (needed for making the draft locally)"
	@echo "todo:      grep all $(TODOMARK) markers from the source"
	@echo "final:     make txt, rename it to what ever is defined in docName and run checks"
	@echo "show:      make txt and show it using $(SHOWC) (program defined with SHOWC)"
	@echo "showdiff:  make txt and show differences against SVN version $(PV) (defined with PV)"
	@echo "check:     make txt and do a spellcheck on it"
