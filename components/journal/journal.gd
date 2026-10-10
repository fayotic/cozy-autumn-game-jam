extends Node2D

#Journal node variable
@onready var journal = $"."
#Sprite node for opened journal
@onready var opened_journal = $journalopen
#Animation node
@onready var anim_player = $AnimationPlayer
#Button nodes for cycling through journal
@onready var next_button = $"NextButton"
@onready var prev_button = $"PreviousButton"
#Journal data node that can be cycled through
@onready var journal_data = $"JournalData"
@onready var items_label = $ItemsFound

#Array of child nodes from JournalData node; starts with Randy
var journal_data_array: Array[Node2D]
#Bool variable to see if journal is open
var is_opened: bool = false
#Index for journal data- allows data on inde to pop up
var con_index = 0

var item_count: Array = []
var items_found: Array = []
var percentage: Array = []

func _ready() -> void:
	journal_data_array.append_array(journal_data.get_children())
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("open journal") and journal.visible == false:
		open_journal()
	elif event.is_action_pressed("open journal") and journal.visible == true:
		close_journal()

#Opens the journal and shows data and buttons
func open_journal():
	is_opened = true
	journal.visible = true
	anim_player.play("opening_journal")
	await anim_player.animation_finished
	journal_data.visible = true
	next_button.visible = true
	prev_button.visible = true
	items_label.visible = true

#Closes and hides the journal	
func close_journal():
	is_opened = false
	next_button.visible = false
	prev_button.visible = false
	journal_data.visible = false
	items_label.visible = false
	anim_player.play("closing_journal_")
	await anim_player.animation_finished
	journal.visible = false
	
#Cycles through the journal data node and shows based on index
func cycle_data(i: int):
	for page in journal_data_array:
		page.visible = false
	journal_data_array[i].visible = true

#In progress: but this will calculate the percentage of found objects. This function will not work until I add child objects for journal data.
func calculate_progress(i: int):
		item_count[i] = journal_data_array[i].get_child_count()
		percentage[i] = items_found[i]/item_count[i] - 1
		items_label.text = "Items Found: " + str(percentage[i])

#If button is pressed, goes to next index of journal data array
func _on_next_button_pressed() -> void:
	if con_index < 3:
		con_index += 1
		cycle_data(con_index)
	else:
		con_index = 0
		cycle_data(con_index)
#If button is pressed, goes back on journal data array
func _on_previous_button_pressed() -> void:
	if con_index > 0:
		con_index -= 1
		cycle_data(con_index)
	else:
		cycle_data(con_index)
