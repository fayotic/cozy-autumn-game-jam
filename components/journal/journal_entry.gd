extends Control
##A picture + label that gets added to the journal data
class_name JournalEntry

@onready var photo: TextureRect = $Photo
@onready var name_label: Label = $NameLabel


##sets the entry up with the photo and name from the journal manager autoload
func setup(entry: Dictionary) -> void:
	photo.texture = entry["photo"]
	name_label.text = entry["name"]
