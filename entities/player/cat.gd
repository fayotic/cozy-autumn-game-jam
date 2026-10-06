extends CharacterBody3D
##The main player character.
class_name Player


@export_category("Controls")
@export var movement_speed: float = 3.0
@export var can_interact: bool = false
@export var movement_enabled: bool = true

@export_category("Physics")
@export var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

var move_direction: Vector2 = Vector2.ZERO


func _physics_process(delta: float) -> void:
	_handle_movement(delta)


func _handle_movement(delta: float) -> void:

	if !is_on_floor():
		velocity.y -= gravity * delta
	else:
		velocity.y = 0.0

	if !movement_enabled:
		move_direction = Vector2.ZERO
		return

	move_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	var camera = get_viewport().get_camera_3d()
	var moving_direction = Vector3.ZERO

	if camera:
		var forward_relative = -camera.global_transform.basis.z
		var right_relative = camera.global_transform.basis.x
		forward_relative.y = 0.0
		right_relative.y = 0.0
		forward_relative = forward_relative.normalized()
		right_relative = right_relative.normalized()
		moving_direction = (forward_relative * -move_direction.y + right_relative * move_direction.x).normalized()
	else:
		moving_direction = Vector3(move_direction.x, 0.0, move_direction.y).normalized()

	velocity.x = moving_direction.x * movement_speed
	velocity.z = moving_direction.z * movement_speed

	move_and_slide()
