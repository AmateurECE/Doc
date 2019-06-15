###############################################################################
# NAME:		    Makefile
#
# AUTHOR:	    Ethan D. Twardy <edtwardy@mtu.edu>
#
# DESCRIPTION:	    Makefile for homework in this directory. This is just a
#		    convenience wrapper for a slightly unpleasant latex call.
#
# CREATED:	    02/03/2019
#
# LAST EDITED:	    06/15/2019
###

flags=-shell-escape
dep=

srcs=$(shell find . | grep '\.tex')
pdfs=$(patsubst %.tex,%.pdf,$(srcs))

export PDF_ERRORS=

# Force pipenv to put the package cache here
export PIPENV_CACHE_DIR=$(PWD)
# Force pipenv to put the venv in the project directory
export PIPENV_VENV_IN_PROJECT=1

.PHONY: pipenv

build:
	pipenv run pdflatex $(flags) $(TGT) $(dep)

all: $(pdfs)
	@printf 'Could not convert files: %s\n' $$PDF_ERRORS

%.pdf: %.tex
	-pipenv run pdflatex $(flags) $< $(dep) \
		|| export PDF_ERRORS="${PDF_ERRORS}, $<"

pipenv:
	pipenv install

##############################################################################
