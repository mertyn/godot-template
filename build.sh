#!/usr/bin/env bash

project="cyborg-cat-carnage"
version="1.1"
version_suffix="rc1"
rev=$(git rev-parse --short HEAD)
platform="web"


echo "building $project version $version$version_suffix at revision $rev"
echo "building platform $platform"

name="$project-v$version$version_suffix-$rev-$platform"
path="build/$name"

mkdir -p "$path"

echo "building project..."
godot4 --path ./src --headless --export-release "Web" "../$path/index.html"
echo

echo "creating build archive..."
cd "$path"
zip "../$name.zip" *