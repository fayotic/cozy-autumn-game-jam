extends Node2D

@onready var dialogue = $Dialogue
var is_done = false

func _ready() -> void:
	dialogue.dialogue_finished.connect(_on_dialogue_ended)
	dialogue.queue_dialogue("MC", "Huh, is this strange.")
	dialogue.queue_dialogue("MC", "Been out of the hospital for a while now...")
	dialogue.queue_dialogue("MC", "I try to sit with myself and understand where things went wrong.. ")
	dialogue.queue_dialogue("MC", "...")
	dialogue.queue_dialogue("MC", "I miss my mom.")
	dialogue.queue_dialogue("MC", "She would help me get through all of this.")
	dialogue.queue_dialogue("MC", "Sometimes I see her in my dreams, waiting for me to come back. Setting up the dinner table, hanging out in the garden. Just there wishing for a better life for all of us.")
	dialogue.queue_dialogue("MC", "I want to go back. But I'm told I can't. The townsfolk urge everyone to stay away. The company blocking off the area for renovations.")
	dialogue.queue_dialogue("MC", "...")
	dialogue.queue_dialogue("MC", "I can't seem to remember my time there. Just faded visions of childhood and feverish dreams of pieces of the past.")
	dialogue.queue_dialogue("MC", "But I do know that there's something there that I need to find. Mom tells me all the time I left behind something important...")

func _on_dialogue_ended():
	get_tree().change_scene_to_file("res://scenes/levels/outside.tscn")
