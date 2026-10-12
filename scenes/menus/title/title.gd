extends Control


func _on_playbtn_pressed() -> void:
	LoadManager.load_scene(LoadManager.ONE)


func _on_optionsbtn_pressed() -> void:
	MenuManager.load_menu(MenuManager.SETTINGS_MENU)


func _on_quitbtn_pressed() -> void:
	get_tree().quit()
