---
layout: default
title: 3.3 Konvertierung der Files
parent: 3. Haupteil
nav_order: 303
---

# 3.3 Konvertierung der Files

Mit dem vorerstellten Image von Sphinx direkt und der Möglichkeiten dieser Variante, hat sich das ganze um einiges erleichtert.

Ich kann nun direkt die Konvertierung starten, ohne einen Container erstellen zu müssen.

Sollte ein Sphinx Folder bereits vorhanden sein, kann ich diesen direkt dem Image übergeben und zu HTML Files umschreiben.

## Was ist ein Sphinx Folder?

Ein Sphinx Folder beinhaltet:

* die Source Files, welche umgewandelt werden sollen.
* die Build Destination, wo die umgewandelten Files abgelegt werden.
* Makefile, mit welchem der Sphinx Prozess angestossen wird.

![Ordnersturktur](../ressources/images/sphinx/ordnerstruktur.PNG)

Quelle Ordnersturktur - Selbstkreation

Da dies in meinem Fall sensitive Daten meiner Firma enthalten würde, kann ich diese Daten nicht direkt auf Github teilen.

Falls Einsicht in diese Daten gewünscht werden, kann ich diese bereitstellen.

Diese Ordnerstruktur kann anschliessend direkt dem Container Image übergeben werden.

```
$ docker run --rm -v "C:/Users/marco/TBZ/IT_ITCNE23_2_SemArbeit - Marco Kälin (CI-CD Pipeline) - Marco Kälin (CI-CD Pipeline)/Source Code/SemArb2-DrawioToJPGPipeline/sphinx_files":/docs/ sphinxdoc/sphinx make html

Running Sphinx v7.1.2
loading pickled environment... done
building [mo]: targets for 0 po files that are out of date
writing output...
building [html]: targets for 0 source files that are out of date
updating environment: 0 added, 0 changed, 0 removed
reading sources...
looking for now-outdated files... none found
no targets are out of date.
build succeeded.

The HTML pages are in build/html.
```

Der Make Command führt den Catch-All Case aus. (Das File hierzu findet sich auch im [Prework Ordner](https://github.com/Euthal02/SemArb2-DrawioToJPGPipeline/tree/main/prework)):

```
# You can set these variables from the command line, and also
SPHINXOPTS    =
SPHINXBUILD   = sphinx-build
SPHINXPROJ    = Backbone
SOURCEDIR     = source
BUILDDIR      = build

# Put it first so that "make" without argument is like "make help".
help:
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

.PHONY: help Makefile

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
%: Makefile
	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)
```
