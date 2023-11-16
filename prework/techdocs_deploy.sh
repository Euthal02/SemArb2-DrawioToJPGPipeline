#!/bin/bash

HOMEFOLDER="/var/www/vhosts/techdocs.backbone.ch"

PKGCHECK="$(sed 's%.*package=\([^;]*\);.*%\1%g' ${HOMEFOLDER}/about)"
[ "${PKGCHECK}" = "techdocs" ] && rm -rf ${HOMEFOLDER}

[ -e "${HOMEFOLDER}" ] || mkdir -p "${HOMEFOLDER}"

[ -d "${HOMEFOLDER}" ] || {
	echo "No folder at ${HOMEFOLDER}" >&2
	exit 1
}

DLD="${DLD:-/home/jenkins/pkgs}"
PKGFILE="${DLD}/prod/techdocs-latest.tbz"

umask 0027

pushd "${HOMEFOLDER}" >/dev/null || {
	echo "Failed to change directory to ${HOMEFOLDER}"
	exit 1
}

tar -xvjf "${PKGFILE}" >webupdate.log 2>&1

chown -R root:www-data "${HOMEFOLDER}"
find "${HOMEFOLDER}" -type d -exec chmod 0750 \{} \;
find "${HOMEFOLDER}" -type f -exec chmod 0640 \{} \;

popd >/dev/null

