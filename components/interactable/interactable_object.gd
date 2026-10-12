extends Area3D
##Majority of things extend from this class if tey need to be interacted with.
class_name InteractableObject

signal interacted

@export var interact_text: String = "Interact"

@onready var prompt: Label3D = $Label3D


func _ready() -> void:
	if !prompt:
		prompt = Label3D.new()

	prompt.text = interact_text
	set_prompt_visible(false)


func interact() -> void:
	interacted.emit()


func set_prompt_visible(value: bool) -> void:
	prompt.visible = value
