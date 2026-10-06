extends Node

##Handles the saving, loading and altering of settings
##All Settings get saved to a settings config when calling save_settings()

var fullscreen: bool = false

##TODO: Setup settings to save and pull from settings config, for now this is just a stub

func _ready() -> void:
	pass


##Loads settings from config and applies them
func load_settings() -> void:
	pass


##Saves current settings setup and applies them to the config
func save_settings() -> void:
	pass
