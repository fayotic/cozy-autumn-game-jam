extends Node2D

#Journal node variable
@onready var journal = $"."
#Sprite node for opened journal
@onready var opened_journal = $journalopen
#Animation node
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

@onready var door_sig = "InteractableObjects/Vase"

func _ready() -> void:
	journal_data_array.append_array(journal_data.get_children())
	
	
#Cycles through the journal data node and shows based on index
func cycle_data(i: int):
	for page in journal_data_array:
		page.visible = false
	journal_data_array[i].visible = true

#If button is pressed, goes to next index of journal data array
func _on_next_button_pressed() -> void:
	if con_index < 2:
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
