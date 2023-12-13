#!/bin/bash

echo "make html using docker image"
docker run --rm -v .:/docs/ waeldi/drawio_converter:latest sphinx-build -M html . _build

[ "${USER}" = "jenkins" ] && {
	rm -rf _build/doctrees
	mv _build/html/* _build/
	rm -rf _build/html

	echo "Base name : ${JOB_BASE_NAME}"
	echo "Branch name : ${BRANCH_NAME}"
}
