# standard sphinx image als basis
FROM sphinxdoc/sphinx:latest

RUN pip install --upgrade pip

RUN python3 -m pip install sphinx-rtd-theme myst-parser

RUN apt-get update

RUN apt-get install -f --no-upgrade wget curl xvfb -y

RUN curl -s https://api.github.com/repos/jgraph/drawio-desktop/releases/latest | grep browser_download_url | grep amd64 | cut -d '"' -f 4 | wget -i -

RUN apt-get install -f --no-upgrade ./drawio-amd64-*.deb -y
