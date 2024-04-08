default: edit

edit:
	godot4 --editor --path ./src

build preset version_suffix="":
	./build.sh "{{preset}}" "{{version_suffix}}"

build-all version_suffix="":
	./build.sh windows "{{version_suffix}}"
	./build.sh linux "{{version_suffix}}"
	./build.sh web "{{version_suffix}}"
