extends Camera3D
##Camera each level loads with, rather than a static camera it has slight motion
##And a very slight random rotation for a lively feel.
class_name LevelCamera

@export_category("Camera Movement")
@export var sway_enabled: bool = true
@export var sway_amount: float = 0.05
@export var sway_speed: float = 1.0
@export var rotation_amount: float = 0.02
@export var max_distance_away: float = 10.0
@export var follow_speed: float = 2.0
@export var max_follow_shift: float = 2.0

@export_category("Node References")
@export var target: Node3D

var base_pos: Vector3
var base_rot: Vector3
var base_front: Vector3
var randomness: FastNoiseLite
var time: float = 0.0
var follow_shift: float = 0.0


func _ready() -> void:
	base_pos = position
	base_rot = rotation
	base_front = -global_transform.basis.z
	base_front.y = 0.0
	base_front = base_front.normalized()
	randomness = FastNoiseLite.new()
	randomness.seed = randi()
	randomness.frequency = 0.1


func _process(delta: float) -> void:
	if !sway_enabled:
		return

	time += delta * sway_speed
	_update_follow(delta)
	position = base_pos + _sway() + base_front * follow_shift
	rotation = base_rot + _rotate_cam()


func _update_follow(delta: float) -> void: #follow is a little rough, gonna rewrite everything later
	var target_shift = 0.0
	if target != null:
		var lent = (target.global_position - global_position).length()
		if lent > max_distance_away:
			target_shift = max_follow_shift
	follow_shift = lerp(follow_shift, target_shift, follow_speed * delta)


func _sway() -> Vector3:
	return Vector3(randomness.get_noise_1d(time), randomness.get_noise_1d(time + 100.0), randomness.get_randomness_1d(time + 200.0)) * sway_amount


func _rotate_cam() -> Vector3:
	return Vector3(randomness.get_noise_1d(time + 300.0), randomness.get_noise_1d(time + 400.0), randomness.get_randomness_1d(time + 500.0)) * rotation_amount
