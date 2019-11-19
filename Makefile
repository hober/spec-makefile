# Makefile --- A simple Makefile for working on specs.

# This is a generic Makefile for generating HTML documents from Bikeshed
# and Markdown source files.

# Bikeshed (.bs) is a popular format for writing specifications in. This
# Makefile assumes you have a local install of bikeshed. Installation
# instructions can be found here:
#
#     https://tabatkins.github.io/bikeshed/#installing

# Markdown (.md) is commonly used for README files, explainers, and
# other documentation adjacent to specifications. This Makefile assumes
# you have a local install of the Python markdown2 module. You can
# install it like any other Python module, with pip:
#
#     pip install markdown2

# This Makefile also runs make in any immediate subdirectories, because
# documentation or other auxilliary materials are often in
# subdirectories.

docs    = $(patsubst %.md,%.html,$(wildcard *.md))
specs   = $(patsubst %.bs,%.html,$(wildcard *.bs))
subdirs = $(shell find -L . -type d -depth 1 -not -name \.\*)

.PHONY: all docs specs subdirs clean $(subdirs)
.SUFFIXES: .bs .md .html

all: docs specs subdirs
docs: $(docs)
specs: $(specs)
subdirs: $(subdirs)

clean:
	rm -f $(docs) $(specs) *~

.bs.html:
	bikeshed spec $< $@

.md.html:
	echo "<!doctype html>\n<meta charset=utf-8>\n" > $@
	markdown2 $< >> $@

$(subdirs):
	$(MAKE) -C $@

# Copyright © 2019 Theresa O'Connor <hober@me.com>
#
# All rights reserved.

# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:

# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.

# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the
#    distribution.

# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
# HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
