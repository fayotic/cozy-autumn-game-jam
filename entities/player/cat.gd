extends CharacterBody3D
##The main player character.
class_name Player


@export_category("Controls")
@export var movement_speed: float = 3.0
@export var can_interact: bool = false
@export var movement_enabled: bool = true

@export_category("Physics")
@export var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass


func _physics_process(delta: float) -> void: #TODO: Separate movement into it's own module (can do when done work)

	if !is_on_floor():
		velocity.y -= gravity * delta
	else:
		velocity.y = 0.0

	if !movement_enabled:
		return

	var dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")

##The movement is relative to the camera, so if we rotate the camera, the movement direction also changes
##If we want fixed directions later on we can fix it up

	var camera = get_viewport().get_camera_3d()
	var moving_direction = Vector3.ZERO
	if camera:
		var forward_relative = -camera.global_transform.basis.z
		var right_relative = camera.global_transform.basis.x
		forward_relative.y = 0.0
		right_relative.y = 0.0
		forward_relative = forward_relative.normalized()
		right_relative = right_relative.normalized()
		moving_direction = (forward_relative * -dir.y + right_relative * dir.x).normalized()
	else:
		moving_direction = Vector3(dir.x, 0.0, dir.y).normalized()

	velocity.x = moving_direction.x * movement_speed
	velocity.z = moving_direction.z * movement_speed

	move_and_slide()
