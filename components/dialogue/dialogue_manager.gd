extends CanvasLayer

#Character's name variable
@onready var char_name: RichTextLabel = $Name
#Dialogue variable
@onready var dialogue: Label = $Dialogue
#Animation player variable: will be used to fade out dialogue
@onready var anim_player: AnimationPlayer = $AnimationPlayer
#Dialogue queue variable that is used to hold character name and dialogue;
#Used dictionary to keep the name and dialogue together
var dialogue_queue: Array[Dictionary] = []
#Typing speed variable (per character)
var typing_speed: float = 0.03
#Tween variable to check for current tweens running
var current_tween: Tween = null
#Bool variable to see if dialogue is still playing
var is_playing: bool = false
#Bool variable to see if dialogue is finished
var is_finished: bool = false

#Player uses left mouse button to continue the dialogue; wants to figure out the pause/skip mechanic
func _input(event: InputEvent) -> void:
	if $Dialogue.visible == true and event.is_action_pressed("dialogue"):
		if current_tween and current_tween.is_running():
			current_tween.kill()
			dialogue.visible_characters = -1
		if is_finished == false:
			set_char_name_and_dialogue()

#You can queue the lines from the script into the dictionary so they can be read sequentially.
func queue_dialogue(name: String, dialogue_string: String):
	dialogue_queue.append({
		"name": name,
		"dialogue": dialogue_string
	})
	
#This function can be called for dialogue purposes, just set the character name 
#and their dialogue and it will show up!
func set_char_name_and_dialogue():	
	if dialogue_queue.is_empty():
		is_finished = true
		fade_dialogue()
		return
		
	is_playing = true
	var current_dialogue = dialogue_queue.pop_front()
	char_name.text = current_dialogue["name"]
	dialogue.text = current_dialogue["dialogue"]
		
	dialogue.visible_characters = 0
	if current_tween:
		current_tween.kill()
		
	var total_chars = dialogue.get_total_character_count()
	var duration = total_chars * typing_speed
	var tween = create_tween()
	tween.tween_property(dialogue, "visible_characters", total_chars, duration)
	await tween.finished


#Call this function to pop up the dialogue	
func show_dialogue_box():
	$Dialogue.visible = true

#Once the dialogue scene/interactable is done, fade away and hide the dialogue
func fade_dialogue():
	if is_finished == true:
		anim_player.play("fade_out")
		await anim_player.animation_finished
		$Dialogue.visible = false
