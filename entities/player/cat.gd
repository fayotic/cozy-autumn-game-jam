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
var nearby_interactables: Array[InteractableObject] = []
var active_interactable: InteractableObject

@onready var interaction_area: Area3D = $InteractionArea


func _ready() -> void:
	interaction_area.area_entered.connect(_on_interaction_area_entered)
	interaction_area.area_exited.connect(_on_interaction_area_exited)


func _physics_process(delta: float) -> void:
	if !MenuManager.is_menu_open():
		_handle_movement(delta)

	_update_active_interactable()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if !MenuManager.is_menu_open():
			MenuManager.load_menu(MenuManager.PAUSE_MENU)
		else:
			MenuManager.close_active_menu()

	if event.is_action_pressed("interact"):
		_try_interact()


func _on_interaction_area_entered(area: Area3D) -> void:
	if area is InteractableObject:
		nearby_interactables.append(area)


func _on_interaction_area_exited(area: Area3D) -> void:
	if area is InteractableObject:
		nearby_interactables.erase(area)


func _update_active_interactable() -> void:
	var nearest: InteractableObject = null
	var nearest_distance: float = INF

	if can_interact && !MenuManager.is_menu_open():
		for interactable in nearby_interactables:
			if !is_instance_valid(interactable):
				continue

			var distance = global_position.distance_squared_to(interactable.global_position)
			if distance < nearest_distance:
				nearest_distance = distance
				nearest = interactable

	if nearest == active_interactable:
		return

	if is_instance_valid(active_interactable):
		active_interactable.set_prompt_visible(false)

	active_interactable = nearest

	if is_instance_valid(active_interactable):
		active_interactable.set_prompt_visible(true)


func _try_interact() -> void:
	if !can_interact || MenuManager.is_menu_open():
		return

	if is_instance_valid(active_interactable):
		active_interactable.interact()


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
