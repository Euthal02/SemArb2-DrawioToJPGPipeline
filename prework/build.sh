#!/bin/bash

CORES="$(lscpu -p=Core,Socket | grep -v '#' | uniq | wc -l)"
PROCS=$((CORES+1))

echo "make html using ${PROCS} processes"
make SPHINXOPTS=-j${PROCS} html

[ "${USER}" = "jenkins" ] && {
	rm -rf build/doctrees
	mv build/html/* build/
	rm -rf build/html

	echo "Base name : ${JOB_BASE_NAME}"
	echo "Branch name : ${BRANCH_NAME}"
	}

