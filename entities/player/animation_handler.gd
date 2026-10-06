extends Node3D
##Handles animation for the player based on characterbody velocity.
class_name AnimationHandler

@export_category("Settings")
@export var animations_enabled: bool = true

var last_direction: Vector2 = Vector2.RIGHT

@onready var sprite: AnimatedSprite3D = $"../CatSprite3D"


func _process(delta: float) -> void:
	if animations_enabled:
		_handle_animations()


func _handle_animations() -> void:
	var dir = get_parent().move_direction
	if dir == Vector2.ZERO:
		_play_idle()
		return
	last_direction = dir
	_play_walk(dir)


func _play_walk(dir: Vector2) -> void:
	if dir.y < 0.0:
		sprite.play("walk_back_right")
	else:
		sprite.play("walk_right")
	sprite.flip_h = dir.x < 0.0


func _play_idle() -> void:
	if last_direction.y < 0.0:
		sprite.play("idle_back_right")
	else:
		sprite.play("idle")
	sprite.flip_h = last_direction.x < 0.0
