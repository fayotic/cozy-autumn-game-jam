extends InteractableObject
class_name Door

@export var scene_to_request: PackedScene


func interact() -> void:
	super()
	if scene_to_request:
		LoadManager.load_scene(scene_to_request)
