---
layout: default
title: 3.2 Sphinx in einem Container installieren
parent: 3. Hauptteil
nav_order: 302
---

# 3.2 Sphinx in einem Container installieren

Der erste Schritt ist es, unsere jetzige feste Installation in einem Container abzubilden. 

Dazu muss ich die eigentliche Konvertierungssoftware Sphinx installieren, mit allen Abhängigkeiten.

Doch zuerst einmal eine bessere Beschreibung was Sphinx genau ist.

## Was ist Sphinx?

Die Entwickler der Software Sphinx beschreiben Sphinx folgendermassen:

```
Sphinx is a documentation generator or a tool that translates a set of plain text source files into various output formats, 
automatically producing cross-references, indices, etc. That is, if you have a directory containing a bunch of reStructuredText 
or Markdown documents, Sphinx can generate a series of HTML files, a PDF file (via LaTeX), man pages and much more.
```
[Quelle Text - Was ist Sphinx?](../anhang/quellen.html#522-was-ist-sphinx)

Im alltäglichen Gebrauch resultiert dies also in einer einfach zu bearbeitbaren Dokumentation mit Markdown in einem GIT Repo, zusätzlich aber auch eine benutzerfreundliche Weboberfläche. Dies wird erreicht mit der einfachen Konvertierung durch Sphinx.

Die Konvertierten Markdown Files zu HTML können dann von jedem Webserver genutzt werden um die Dokumentation als Webseite darzustellen.

Genau in diesem Zusammenhang nutzen wir also Sphinx bereits in meiner Firma. Dies bedeutet also, dass Sphinx ein nicht auswechselbarer Komponent ist, wenn ich nicht direkt den ganzen Prozess anpassen möchte.

Da dies den Rahmen sprengen würde, habe ich mich darauf beschränkt, den "Translateprozess" innerhalb Sphinx, mit der Möglichkeit zu erweitern DrawIO Files zu verstehen und umzuwandeln.

## Umsetzung in Dockerfile

Es gibt ein vorerstelltes Sphinx-Image, welches die Basissoftware bereits installiert hat. 

Die Abhängigkeiten können in einem eigenen Dockerfile ergänzt werden, welche das Sphinx Image als Basis hat.

Am Anfang möchte ich mit einem Dockerfile starten, welche mir sozusagen immer den gleichen Installationsstandard gibt, wie jetzt in der bisherigen festen Installation.

Mein erstelltes Dockerfile hat folgende Config:

[Link zum File](https://github.com/Euthal02/SemArb2-DrawioToJPGPipeline/blob/main/archive/Dockerfile)

Als Erstes definiere ich die Base Installation, dies ist in meinem Fall Sphinx um die jetzige Situation abzubilden:

```
# standard sphinx image als basis
FROM sphinxdoc/sphinx:latest
```

Zusätzlich installiere ich die Abhängigkeiten, welche wir benötigen (das sphinxcontrib-drawio Plugin wird [hier](drawio_integration.html) genauer erklärt).

Das Plugin **sphinx-rtd-theme** ist nur für das Design verantwortlich. [Quelle Theme - RTD Theme](../anhang/quellen.html#524-rtd-theme)

```
RUN pip install --upgrade pip

RUN python3 -m pip install sphinx-rtd-theme sphinxcontrib-drawio
```

Um nun das Image um die DrawIO Kompetenzen zu erweitern, muss ich auch diese Abhängigkeiten installieren:

```
RUN apt-get update

RUN apt-get install -f --no-upgrade wget curl xvfb libasound2 -y

RUN curl -s https://api.github.com/repos/jgraph/drawio-desktop/releases/latest | grep browser_download_url | grep amd64 | cut -d '"' -f 4 | wget -i -

RUN apt-get install -f --no-upgrade ./drawio-amd64-*.deb -y
```
