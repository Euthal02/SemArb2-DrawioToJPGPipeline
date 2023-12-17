---
layout: default
title: 3.6 Build Script Anpassung
parent: 3. Hauptteil
nav_order: 306
---

# 3.6 Build Script Anpassung

Das Build Script welches in der Jenkins Pipeline aufgerufen wird, ist ein ganz einfaches Script.

Der erste Teil dient als Setup für das Script, der Shebang wird definiert und es wird abgefragt wie viele Cores unsere CPU hat.
In diesem Teil bleibt nur noch der Shebang bestehen. Der Rest kann bei Sphinx über Docker nicht mehr verwendet werden.

```bash
#!/bin/bash
CORES="$(lscpu -p=Core,Socket | grep -v '#' | uniq | wc -l)"
PROCS=$((CORES+1))
```

In diesem zweiten Abschnitt wird der Sphinx Prozess ausgeführt, mit einem Makefile, welches in unserem Dockerfile eins zu eins weitergenutzt wird.
Hier wird der eigentliche Sphinx Prozess mit dem Docker Command ersetzt.

```bash
echo "make html using ${PROCS} processes"
make SPHINXOPTS=-j${PROCS} html
```

Dies sieht folgendermassen aus:


```bash
echo "make html using docker image"
docker run --rm -v .:/docs/ waeldi/drawio_converter:latest sphinx-build -M html . _build
```

```bash
[ "${USER}" = "jenkins" ] && {
	rm -rf build/doctrees
	mv build/html/* build/
	rm -rf build/html

	echo "Base name : ${JOB_BASE_NAME}"
	echo "Branch name : ${BRANCH_NAME}"
	}



```