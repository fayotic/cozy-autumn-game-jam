extends InteractableObject
class_name TouchTrigger

@export var signal_id: int = 0


func _ready() -> void:
	super()
	monitorable = false
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		Eventbus.signal_recieved.emit(signal_id)
