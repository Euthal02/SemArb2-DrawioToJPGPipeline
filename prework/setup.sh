#!/bin/bash

PROBLEM=0

dpkg -l texlive >/dev/null 2>&1 || {
	echo "You must install texlive"
	echo "sudo apt install texlive"
	echo
	PROBLEM=1
	}

dpkg -l python3-sphinx >/dev/null 2>&1 || {
	echo "You must install python3-sphinx"
	echo "sudo apt install python3-sphinx"
	echo
	PROBLEM=1
	}

dpkg -l python3-sphinx-rtd-theme >/dev/null 2>&1 || {
	echo "You must install read the docs sphinx theme"
	echo "sudo apt install python3-sphinx-rtd-theme"
	echo
	PROBLEM=1
	}

[ -e "/usr/share/sphinx/themes/sphinx_rtd_theme" ] || {
	echo "You must link the read the docs scheme into your sphinx installation"
	echo "sudo ln -s /usr/share/sphinx_rtd_theme /usr/share/sphinx/themes/"
	echo
	PROBLEM=1
	}

[ "${PROBLEM}" -gt 0 ] && exit 1

#[ -e "../sphinx_rtd_theme" ] || {
#	pushd .. >/dev/null
#	git clone https://github.com/readthedocs/sphinx_rtd_theme
#	popd >/dev/null
#	}

#ln -s ../../../sphinx_rtd_theme docs/_themes/

pip install --upgrade myst-parser

echo "All done."

