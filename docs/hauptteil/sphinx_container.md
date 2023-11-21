---
layout: default
title: 3.2 Sphinx in einem Container installieren
parent: 3. Haupteil
nav_order: 302
---

# 3.2 Sphinx in einem Container installieren

Der erste Schritt ist es, unseren jetztigen 

## Was ist Sphinx?

Die Entwickler der Software beschreiben Sphinx folgendermassen:

```
Sphinx is a documentation generator or a tool that translates a set of plain text source files into various output formats, 
automatically producing cross-references, indices, etc. That is, if you have a directory containing a bunch of reStructuredText 
or Markdown documents, Sphinx can generate a series of HTML files, a PDF file (via LaTeX), man pages and much more.
```
[Quelle Text - Was ist Sphinx?](../anhang/quellen.html#522-was-ist-sphinx)

Im alltäglichen Gebrauch resultiert dies also in einer einfach zu bearbeitbaren Dokumentation mit Markdown in einem GIT Repo, zusätzlich aber auch eine benutzerfreundliche Weboberfläche.

Genau in diesem Zusammenhang nutzen wir also Sphinx bereits in meiner Firma.

Dies bedeutet also, dass Sphinx ein nicht auswechselbarer Component ist, wenn ich nicht direkt den ganzen Prozess anpassen möchte.

Da dies den Rahmen sprengen würde, habe ich mich darauf beschränkt, den Sphinx "Translateprozess" innerhalb Sphinx, mit der Möglichkeit zu erweitern DrawIO Files zu verstehen und umzuwandeln.

## Umsetzung in Dockerfile

Am Anfang möchte ich mit einem Dockerfile starten, welche mir sozusagen immer den gleichen Installationsstandard gibt, wie jetzt in der bisherigen festen Installation.

Dies erreiche im mit dem abgelegten Dockerfile.

[Link zum File](../../Dockerfile)

Als Erstes definiere ich die Base Installation, dies ist in meinem Fall Ubuntu um die jetzige Situation abzubilden:

```
# standard ubuntu image als basis
FROM ubuntu:latest
```

Mit diesem Command kopiere ich anschliessend die benötigen Files auf den Container:

```
# kopieren von prework dateien
COPY prework/* /app/
```

Anschliessend definiere ich das Working Directory, welches genutzt wird um innerhalb des Containers einen Folder zu haben, auf welchem Files geschrieben werden können.

```
# arbeitsverzeichnis als /app setzen
WORKDIR /app
```

Sobald der Container läuft, installiere ich die Abhängigkeiten für Sphinx:

```
# abhängigkeiten installieren - apt
RUN apt-get install -y \
    python3 \
    python3-pip \
    python3-sphinx \
    python3-sphinx-rtd-theme \
    python3-myst-parser \
    texlive
```

Das Theme wird dann korrekt verlinkt:

```
# theme korrekt verlinken
RUN ln -s /usr/share/sphinx_rtd_theme /usr/share/sphinx/themes/
```

Execute the precreated build.sh File:

```
# html generator starten
CMD ["./build.sh"]
```


