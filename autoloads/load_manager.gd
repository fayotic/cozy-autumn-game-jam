extends Node
#handles loading different scenes.
#menu manager handles loading menus

var ONE = preload("res://scenes/levels/One.tscn")
var TITLE = preload("res://scenes/levels/titlescreen.tscn")

func load_scene(scene: PackedScene) -> void:
	if !scene:
		push_error("No valid scene recieved, try again.")
		return

	get_tree().call_deferred("change_scene_to_packed", scene)
