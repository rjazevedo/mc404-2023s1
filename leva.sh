#!/bin/bash

(cd docs/slides ; marp-pdf.sh *.md; cp *.pdf ~/Dropbox/mc404) &
(cd docs/slides ; marp-html.sh *.md) &
export ENABLE_PDF_EXPORT=1
mkdocs build
rsync -vrlu --copy-unsafe-links --rsh=ssh site/* manaus:public_html/Cursos/mc404/2023s1
