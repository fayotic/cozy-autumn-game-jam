extends Control
##Shows the pages and the entries the player has found in their journal.

const JOURNAL_DATA = preload("res://components/journal/journal_data.tscn")
#Size of the journal art, used to keep the pages lined up at any window size
const CANVAS_SIZE := Vector2(1920, 1080)

@onready var canvas: Control = $Canvas
@onready var pages: Control = $Canvas/Pages
#Button nodes for cycling through journal
@onready var next_button: Button = $"Canvas/NextButton"
@onready var prev_button: Button = $"Canvas/PreviousButton"
@onready var items_label: Label = $Canvas/ItemsFound

#Array of child nodes from JournalData node; starts with Randy
var journal_data_array: Array[JournalData] = []
#Bool variable to see if journal is open
var is_opened: bool = false
#Index for journal data- allows data on inde to pop up
var con_index = 0


func _ready() -> void:
	is_opened = true
	resized.connect(_fit_canvas)
	_fit_canvas()
	set_up_journal_data()
	cycle_data(con_index)
	update_items_label()


##fit the canvas on opening it basedo n screen resolution.
func _fit_canvas() -> void:
	var fit = minf(size.x / CANVAS_SIZE.x, size.y / CANVAS_SIZE.y)
	canvas.scale = Vector2(fit, fit)
	canvas.position = (size - CANVAS_SIZE * fit) * 0.5


##puts the data into the journal
func set_up_journal_data() -> void:
	for page_data in JournalManager.PAGES:
		var page: JournalData = JOURNAL_DATA.instantiate()
		page.name = page_data["name"]
		pages.add_child(page)
		page.setup(page_data)

		for entry in JournalManager.get_collected_entries(page_data["id"]):
			page.add_entry(entry)

		journal_data_array.append(page)


##Cycles through the journal data node and shows based on index
func cycle_data(i: int):
	for page in journal_data_array:
		page.visible = false

	if journal_data_array.size() > 0:
		journal_data_array[i].visible = true


##Shows how many of the photos the player has found
func update_items_label() -> void:
	items_label.text = "Items Found: " + JournalManager.get_progress()


#If button is pressed, goes to next index of journal data array
func _on_next_button_pressed() -> void:
	if con_index < journal_data_array.size() - 1:
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
