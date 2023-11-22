# standard ubuntu image als basis
FROM ubuntu:latest

# kopieren von prework dateien
COPY prework/* /app/prework/

# kopieren der source files auf den container
COPY source/* /app/source/

# arbeitsverzeichnis als /app setzen
WORKDIR /app

# abhängigkeiten installieren - apt
RUN apt-get update

RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC \
    apt-get install --no-upgrade -y \
    python3 \
    python3-pip \
    python3-sphinx \
    python3-sphinx-rtd-theme \
    python3-myst-parser \
    texlive

# theme korrekt verlinken
RUN ln -s /usr/share/sphinx_rtd_theme /usr/share/sphinx/themes/

# html generator starten
RUN ./build.sh
