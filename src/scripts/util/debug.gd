extends Node


var start_scene: String


func _ready():
	# only run this in editor
	if !OS.has_feature("editor"):
		queue_free()

	process_mode = Node.PROCESS_MODE_ALWAYS
	start_scene = get_tree().current_scene.scene_file_path


func _unhandled_input(event):
	if !(event is InputEventKey and event.pressed):
		return

	match event.keycode:
		# quit
		KEY_F1:
			get_tree().quit(0)

		# reload scene
		KEY_F2:
			get_tree().reload_current_scene()

		# reload game
		KEY_F3:
			get_tree().change_scene_to_file(start_scene)
	