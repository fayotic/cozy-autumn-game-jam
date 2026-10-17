extends Control
##Data on characters on a page by page basis.
class_name JournalData

const JOURNAL_ENTRY = preload("res://components/journal/journal_entry.tscn")

@onready var player_card: TextureRect = $PlayerCard
@onready var name_label: Label = $NameLabel
@onready var entry_grid: GridContainer = $EntryGrid


func setup(page_data: Dictionary) -> void:
	name_label.text = page_data["name"]

	if page_data["player_card"]:
		player_card.texture = page_data["player_card"]


##adds a photo or other things to the journal page
func add_entry(entry: Dictionary) -> void:
	var entry_node: JournalEntry = JOURNAL_ENTRY.instantiate()
	entry_grid.add_child(entry_node)
	entry_node.setup(entry)
