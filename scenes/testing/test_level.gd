extends Node3D

@export var expected_id: int = 0

var room_changed: bool = false
var can_change: bool = true

func _ready() -> void:
	Eventbus.signal_recieved.connect(run)


func run(id: int) -> void:
	if expected_id == id:
		if !can_change:
			return

		if !room_changed:
			$Build/AnimationPlayer.play("change_room_ex_1")
			room_changed = true
			can_change = false
			await get_tree().create_timer(1.3).timeout
			can_change = true
		else:
			$Build/AnimationPlayer.play_backwards("change_room_ex_1")
			print("e")
			room_changed = false
			can_change = false
			await get_tree().create_timer(1.3).timeout
			can_change = true
