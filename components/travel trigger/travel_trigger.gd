extends Area3D
##Upon walking into or interacting with this, calls a signal to change to another room or level
class_name TravelTrigger

@export_category("Setup")

##The scene that will be changed to / requested when interacting with this travel trigger
@export var scene_to_request: PackedScene
##If the TravelTrigger goes off by player touch or wait for interaction
@export var interact_on_touch: bool = true
##If this TravelTrigger emits a signal or not upon interaction 
@export var emit_signal_on_touch: bool = true
##The signal id the TravelTrigger will emit when interacted with
@export var signal_id: int = 0


func interact() -> void:

	if emit_signal_on_touch:
		Eventbus.signal_recieved.emit(signal_id)
		return

	if scene_to_request:
		LoadManager.load_scene(scene_to_request)

func _on_body_entered(body: Node3D) -> void:
	if body is Player and interact_on_touch:
		interact()
