BIN     = /usr/local/apps/tex_live/current/bin/x86_64-linux/
LATEX	= $(BIN)latex -shell-escape
DVIPS	= $(BIN)dvips
DVIPDF  = $(BIN)dvipdft
XDVI	= $(BIN)xdvi -gamma 4
GH		= $(BIN)gv

SRC	:= $(shell egrep -l '^[^%]*\\begin\{document\}' *.tex)
TRG	= $(SRC:%.tex=%.dvi)
PSF	= $(SRC:%.tex=%.ps)
PDF	= $(SRC:%.tex=%.pdf)

pdf: $(PDF)

ps: $(PSF)

$(TRG): %.dvi: %.tex
	$(LATEX) $<
	$(LATEX) $<
	$(LATEX) $<

$(PSF):%.ps: %.dvi
	$(DVIPS) -R -Poutline -t letter $< -o $@

$(PDF): %.pdf: %.ps
#	$(DVIPDF) -o $@ $<
	ps2pdf $<

show: $(TRG)
	@for i in $(TRG) ; do $(XDVI) $$i & done

showps: $(PSF)
	@for i in $(PSF) ; do $(GH) $$i & done

all: pdf

clean:
	rm -f *.pdf *.ps *.dvi *.out *.log *.aux *.bbl *.blg *.pyg

.PHONY: all show clean ps pdf showps

