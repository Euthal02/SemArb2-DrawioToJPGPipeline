# standard sphinx image als basis
FROM sphinxdoc/sphinx:latest

WORKDIR /docs

RUN pip install sphinx-rtd-theme myst-parser
