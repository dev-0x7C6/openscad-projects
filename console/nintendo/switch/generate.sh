#!/usr/bin/env bash

set -x

PROJECT_NAME="cartridge_game_stand"
PROJECT_FILE="cartridge_game_stand.scad"

if [ ! -f "${PROJECT_FILE}" ]; then
	echo "no project file: $PROJECT_FILE"
	exit
fi

export PROJECT_NAME
export PROJECT_FILE
export -f job

for ((h = 0; h <= 10; ++h)); do
	for ((x = 1; x <= 12; ++x)); do
		for ((y = 1; y <= 12; ++y)); do
			path="switch_cartridge_stand_multivariant/height_${h}mm/grid_${x}x${y}mm"
			mkdir -p $path
			openscad -o "$path/switch_cartridge_stand.stl" -D "grid=[${x}, ${y}]" -D "additional_height_for_next_row=${h}" "${PROJECT_FILE}" &
		done
		wait
	done
done

