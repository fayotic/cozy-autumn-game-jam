extends Node
#handles loading menus
#load manager handles loading other scenes

const PAUSE_MENU = preload("uid://dva246xp2gwyw")
const SETTINGS_MENU = preload("uid://b01epfmdlhwnq")
const JOURNAL = preload("uid://lfn154n0k540")

var current_menu: Node = null
var current_menu_scene: PackedScene = null


##Removes old menus and laods new ones. Later i'll change it to call a menu close
##function incase we have animations that need to play first.
func load_menu(menu: PackedScene) -> void:
	if current_menu:
		current_menu.queue_free()

	current_menu_scene = menu
	current_menu = menu.instantiate()
	get_tree().root.add_child(current_menu)


##Refreshes stale menus or updates them when called. Incase something gets stuck
func refresh_menu() -> void:
	if !current_menu_scene:
		return

	load_menu(current_menu_scene)


##Closes the currently opened menu.
func close_active_menu() -> void:
	if !current_menu:
		return

	current_menu.queue_free()


func is_menu_open() -> bool:
	if current_menu:
		return true
	else:
		return false
