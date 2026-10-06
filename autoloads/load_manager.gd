extends Node

func load_scene(scene: PackedScene) -> void:
	if !scene:
		push_error("No valid scene recieved, try again.")
		return
