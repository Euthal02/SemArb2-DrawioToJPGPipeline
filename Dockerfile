# standard sphinx image als basis
FROM sphinxdoc/sphinx:latest

RUN pip install --upgrade pip

RUN python3 -m pip install sphinx-rtd-theme myst-parser
