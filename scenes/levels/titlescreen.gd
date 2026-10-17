extends Node2D



func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/cutscene_1.tscn")
