extends Node

signal entry_collected(entry_id: StringName)

#changed the journal structure to a UI scene instead, just tends to work better
const PAGES: Array[Dictionary] = [
	{
		"id": &"randy",
		"name": "Randy",
		"player_card": preload("res://components/journal/Sprites/journal randy id.png"),
	},
	{
		"id": &"gregory",
		"name": "Gregory",
		"player_card": null, #when we have player cards put the preload here
	},
	{
		"id": &"steven",
		"name": "Steven",
		"player_card": null, #here too
	},
]

const ENTRIES: Dictionary = {
	&"vase": {
		"name": "Vase",
		"photo": preload("res://components/journal/Sprites/photo vace.png"),
		"page": &"randy",
	},
	&"gun": {
		"name": "Gun",
		"photo": preload("res://components/journal/Sprites/photo gun.png"),
		"page": &"randy",
	},
	&"table": {
		"name": "Broken Table",
		"photo": preload("res://components/journal/Sprites/photo table.png"),
		"page": &"randy",
	},
	&"lamp": {
		"name": "Lamp",
		"photo": preload("res://components/journal/Sprites/photo lamp.png"),
		"page": &"randy",
	},
}

var collected_entries: Array[StringName] = []


##add an entry based on it's ids, assign id's in the constants then in the collectibleItem entryID set which one it
##calls.
func collect_entry(entry_id: StringName) -> void:
	if !ENTRIES.has(entry_id):
		push_error("No journal entry found for id '%s', try again." % entry_id)
		return

	if is_collected(entry_id):
		return

	collected_entries.append(entry_id)
	entry_collected.emit(entry_id)


func is_collected(entry_id: StringName) -> bool:
	return collected_entries.has(entry_id)


func get_collected_entries(page_id: StringName) -> Array[Dictionary]:
	var entries: Array[Dictionary] = []

	for entry_id in collected_entries:
		var entry: Dictionary = ENTRIES[entry_id]
		if entry["page"] == page_id:
			entries.append(entry)

	return entries


##show total evidenec all together
func get_progress() -> String:
	return "%d/%d" % [collected_entries.size(), ENTRIES.size()]


func reset() -> void:
	collected_entries.clear()
