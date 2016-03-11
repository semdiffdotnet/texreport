BIN          = /usr/local/apps/tex_live/current/bin/x86_64-linux
export PATH := $(BIN):$(PATH)
SRC	        := $(shell egrep -l '^[^%]*\\begin\{document\}' *.tex)
PDF          = $(SRC:%.tex=%.pdf)

pdf: $(PDF)

$(PDF): %.pdf: %.tex
	latexmk -pdf $>

all: pdf

clean:
	latexmk -C
	rm -f *.pdf *.ps *.dvi *.out *.log *.aux *.bbl *.blg *.pyg

.PHONY: all show clean ps pdf showps

