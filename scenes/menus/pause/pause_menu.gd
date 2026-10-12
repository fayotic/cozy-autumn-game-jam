extends Control
class_name PauseMenu


func _on_resumebtn_pressed() -> void:
	MenuManager.close_active_menu()


func _on_journalbtn_pressed() -> void:
	MenuManager.load_menu(MenuManager.JOURNAL)


func _on_settingsbtn_pressed() -> void:
	MenuManager.load_menu(MenuManager.SETTINGS_MENU)


func _on_exit_pressed() -> void:
	MenuManager.close_active_menu()
	LoadManager.load_scene(LoadManager.TITLE)
