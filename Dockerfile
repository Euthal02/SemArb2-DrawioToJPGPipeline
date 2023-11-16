# standard ubuntu image als basis
FROM ubuntu:latest

# arbeitsverzeichnis als /app setzen
WORKDIR /app

# abhängigkeiten installieren - apt
RUN apt-get update && \
    apt-get install -y \
    python3 \
    python3-pip \
    texlive

# abhängigkeiten installieren - python libs
RUN pip3 install --no-cache-dir \
    sphinx \
    sphinx-rtd-theme \
    myst-parser

# theme korrekt verlinken
RUN ln -s /usr/share/sphinx_rtd_theme /usr/share/sphinx/themes/

# html generator starten
CMD ["sphinx-build", "-b", "html", "source", "build"]