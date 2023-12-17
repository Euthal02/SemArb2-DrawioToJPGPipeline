---
layout: default
title: 3.2 Sphinx in einem Container installieren
parent: 3. Hauptteil
nav_order: 302
---

# 3.2 Sphinx in einem Container installieren

Der erste Schritt ist es, unsere jetzige feste Installation in einem Container abzubilden. 

Dazu muss ich die eigentliche Konvertierungssoftware Sphinx installieren, mit allen Abhängigkeiten.

Dazu kann ich das Setup Script nutzen, welches bereits in der Vorarbeit erstellt wurde.

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

Genau in diesem Zusammenhang nutzen wir also Sphinx bereits in meiner Firma. Dies bedeutet also, dass Sphinx ein nicht auswechselbarer Component ist, wenn ich nicht direkt den ganzen Prozess anpassen möchte.

Da dies den Rahmen sprengen würde, habe ich mich darauf beschränkt, den "Translateprozess" innerhalb Sphinx, mit der Möglichkeit zu erweitern DrawIO Files zu verstehen und umzuwandeln.

## Umsetzung in Dockerfile

Es gibt ein vor erstelltes Sphinx-Image, welches die Basissoftware bereits installiert hat. 

Die Abhängigkeiten können in einem eigenen Dockerfile ergänzt werden, welche das Sphinx-Image als Basis hat.

Am Anfang möchte ich mit einem Dockerfile starten, welche mir sozusagen immer den gleichen Installationsstandard gibt, wie jetzt in der bisherigen festen Installation.

Mein erstelltes Dockerfile hat folgende Config:

[Link zum File](https://github.com/Euthal02/SemArb2-DrawioToJPGPipeline/blob/main/archive/Dockerfile)

Als Erstes definiere ich die Base Installation, dies ist in meinem Fall Sphinx um die jetzige Situation abzubilden:

```dockerfile
# standard sphinx image als basis
FROM sphinxdoc/sphinx:latest
```

Zusätzlich installiere ich die Abhängigkeiten, welche wir benötigen (das sphinxcontrib-drawio Plugin wird [hier](drawio_integration.html) genauer erklärt).

Das Plugin **sphinx-rtd-theme** ist nur für das Design verantwortlich. [Quelle Theme - RTD Theme](../anhang/quellen.html#524-rtd-theme)

```dockerfile
RUN pip install --upgrade pip

RUN python3 -m pip install sphinx-rtd-theme sphinxcontrib-drawio
```

Um nun das Image um die DrawIO Kompetenzen zu erweitern, muss ich auch diese Abhängigkeiten installieren:

```dockerfile
RUN apt-get update

RUN apt-get install -f --no-upgrade wget curl xvfb libasound2 -y

RUN curl -s https://api.github.com/repos/jgraph/drawio-desktop/releases/latest | grep browser_download_url | grep amd64 | cut -d '"' -f 4 | wget -i -

RUN apt-get install -f --no-upgrade ./drawio-amd64-*.deb -y
```

Dieses Dockerfile kann anschliessend genutzt werden, um ein Image zu erstellen.
Mit diesem Command wird das Dockerfile im jetzigen Working Directory ausgeführt und ein Image mit dem Namen "waeldi/sphinx_compiler" erstellt.

```bash
sudo docker build -t waeldi/sphinx_compiler .
```

## Wie nutzt man dieses Dockerfile?

Man nutzt dieses File folgendermassen, in einem Docker Command:

```bash
$ docker run --rm -v ./sphinx_files:/docs waeldi/sphinx_compiler:latest sphinx-build -M html . _build

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


Der Command ist folgendermassen aufgebaut:

`docker run --rm -v ./sphinx_files:/docs waeldi/sphinx_compiler:latest sphinx-build -M html . _build`

Mit `docker run` wird ein eigenständiger Container ausgeführt.

Das `--rm` Direktiv führt dazu, dass dieser Container nach der Ausführung wieder beendet und gelöscht wird.

Eine Verknüpfung zwischen einem lokalen Ordner und einem Ordner im Container wird mit diesem Volume Command erstellt: `-v ./sphinx_files:/docs`
Innerhalb des lokalen Ordners werden die Sphinx Files hinterlegt.

Hier wird definiert welches Image genutzt wird, um den temporären Container zu erstellen: `waeldi/sphinx_compiler:latest`

Dies `sphinx-build -M html . _build`, ist dann der eigentliche Command welcher im Container ausgeführt wird.

Dies entspricht dem make Command im Build Script, welcher im Abschnitt 3.1 besprochen wurde.
