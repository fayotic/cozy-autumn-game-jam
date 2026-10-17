extends InteractableObject
##An item in the world the player can interact with, mainly for adding it to the journal atm.
class_name CollectibleItem

@export var entry_id: StringName = &""

var is_collected: bool = false


func _ready() -> void:
	super()
	is_collected = JournalManager.is_collected(entry_id)


func interact() -> void:
	super()
	if is_collected || entry_id.is_empty():
		return

	is_collected = true
	JournalManager.collect_entry(entry_id)
	set_prompt_visible(false)


func set_prompt_visible(value: bool) -> void:
	if is_collected:
		value = false

	super(value)
