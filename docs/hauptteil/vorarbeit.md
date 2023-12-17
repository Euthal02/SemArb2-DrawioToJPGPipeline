---
layout: default
title: 3.1 Vorarbeit
parent: 3. Hauptteil
nav_order: 301
---

# 3.1 Vorarbeit

Um die Arbeit schlussendlich gut in die bestehende Prozesse zu integrieren, nutze ich einige Vorarbeit von meinen Vorgängern.

Diese Vorarbeit ist unter dem Ordner "prework" zu finden.

Dies sind Files welche innerhalb der Pipeline genutzt werden, um den jetzigen Prozess auszuführen:
* Jenkinsfile, definiert die Jenkins Pipeline.
* build.sh, Abhängigkeit der Pipeline, startet make Prozess.
* Makefile, startet Kompilierung der Markdown Files zu HTML Files.
* conf.py, Sphinx Config.

Dies sind Scripts welche zum Vorbereiten der Umgebung genutzt werden:
* setup.sh, Installationen notwendig für den Make Prozess, muss ins Dockerfile gewechselt werden.
* techdocs_deploy.sh, Script welches genutzt wird, um die kompilierten Files auf den Webserver zu transferieren.

[Quelle Vorarbeit - Jenkinsfile, Bash Scripts & Makefile](../anhang/quellen.html#531-jenkinsfile-bash-scripts--makefile)

[Prework Ordner](https://github.com/Euthal02/SemArb2-DrawioToJPGPipeline/tree/main/prework)

## Wie werden die Scripts genutzt?

Zuerst kommt das Jenkinsfile, welches die Pipeline definiert. Dieses File wird im Top-Level Ordner des Git Repos verwendet.

Wenn wir dieses Git Repo in Jenkins als Source verwenden, wird dieses Jenkinsfile automatisch eingelesen und der weitere Verlauf der Pipeline bestimmt dieses File.

```bash
stage('Build') {
    steps {
        sh './build.sh'
    }
}
```

In unserem Fall wird das Build Script aufgerufen. Das Build Script ruft dann einen Make Command auf.

`make SPHINXOPTS=-j${PROCS} html`

Der Make Command führt das Catch-All Case aus. (Das File hierzu findet sich auch im [Prework Ordner](https://github.com/Euthal02/SemArb2-DrawioToJPGPipeline/tree/main/prework)):

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

Mit diesem Make Command wird der Sphinx Prozess gestartet. Dieser Sphinx Prozess wird mit dem Sphinx Config File bearbeitet.
In dieser Config wird unter anderem das DrawIO Plugin installiert.
