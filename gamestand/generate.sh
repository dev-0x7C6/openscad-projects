#!/bin/bash

set -x

PROJECT_NAME="signboard"
PROJECT_FILE="signboard.scad"

if [ ! -d "${PWD}/resources" ]; then
	echo "no directory: resources"
	exit 1
fi

if [ ! -f "${PROJECT_FILE}" ]; then
	echo "no project file: $PROJECT_FILE"
	exit
fi


job() {
	local resource="${1}"
	local path="results/${resource}"
	local name="${resource##*/}"
	name="${path}/${PROJECT_NAME}-${name%%.*}"
	[ -d ${path} ] || mkdir -p ${path}

	openscad -o "${name}-logo.stl" -D "generate_logo=true" -D "generate_panel=false" -D "resource=\"${resource}\"" "${PROJECT_FILE}"
	openscad -o "${name}-panel-13mm.stl" -D "handle_space=13.00" -D "generate_logo=false" -D "generate_panel=true" -D "resource=\"${resource}\"" "${PROJECT_FILE}"
	openscad -o "${name}-panel-19mm.stl" -D "handle_space=19.00" -D "generate_logo=false" -D "generate_panel=true" -D "resource=\"${resource}\"" "${PROJECT_FILE}"
}

export PROJECT_NAME
export PROJECT_FILE
export -f job

find resources/ -iname '*.svg' | parallel -j $(nproc) job {}
