#Inspired by https://drewsilcock.co.uk/using-make-and-latexmk/
BIN          = /usr/local/apps/tex_live/current/bin/x86_64-linux
export PATH := $(BIN):$(PATH)
SRC	        := $(shell egrep -l '^[^%]*\\begin\{document\}' *.tex)
PDF          = $(SRC:%.tex=%.pdf)

# If you want to reduce the output and/or 
# dont want it to stop processing if error 
# change the uncommented
#
# Very Loud, Stoping, Easier to find errors
#OUTPUTMODE   =
# Very Loud, No Stoping, Easier to find errors
OUTPUTMODE   =-halt-on-error
# Very Quiet, No Stoping, Hard to find errors
#OUTPUTMODE   =-quiet

pdf: $(PDF)

$(PDF): %.pdf: %.tex
	latexmk $(OUTPUTMODE) -pdf $>

all: pdf

rebuild: clean all

clean:
	latexmk -C
	rm -f *.pdf *.ps *.dvi *.out *.log *.aux *.bbl *.blg *.pyg

.PHONY: all clean pdf

