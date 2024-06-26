#!/usr/bin/env bash

preset="$1"
version_suffix="$2"

# do some black magic to get the project name and version
project=$(awk -F'=' '/\[application\]/ { in_section = 1; next } /\[.*\]/ { in_section = 0 } in_section && /config\/name/ {gsub(/"/, "", $2); print $2}' ./src/project.godot)
project="${project// /-}"
version=$(awk -F'=' '/\[application\]/ { in_section = 1; next } /\[.*\]/ { in_section = 0 } in_section && /config\/version/ {gsub(/"/, "", $2); print $2}' ./src/project.godot)
rev=$(git rev-parse --short HEAD)

declare -A file_names=(
	["windows"]="$project.exe"
	["linux"]="$project.x86_64"
	["web"]="index.html"
)


if [[ -z $preset ]]; then
	echo "error: no preset given, exiting."
	exit
fi

if [[ -z ${file_names[$preset]} ]]; then
	echo "error: preset $preset not recognized, exiting."
	exit
fi


echo "building $project version $version$version_suffix at revision $rev"
echo "building preset $platform"

name="$project-v$version$version_suffix-$rev-$preset"
path="build/$name"

mkdir -p "$path"

echo "building project..."
godot4 --path ./src --headless --export-release "$preset" "../$path/${file_names[$preset]}"
echo

echo "creating build archive..."
cd "$path"
zip "../$name.zip" *