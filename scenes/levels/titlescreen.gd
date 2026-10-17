extends Control

@onready var buttons: Array[Node] = $VBoxContainer.get_children()
@onready var arrow_l: Sprite2D = $ArrowL
@onready var arrow_r: Sprite2D = $ArrowR

var arrow_space: float = 29.0

func _ready() -> void:
	for button in buttons:
		button.mouse_entered.connect(move_arrows.bind(button))

	await get_tree().process_frame
	move_arrows(buttons[0])


func move_arrows(button: Button) -> void:
	var rect = button.get_global_rect()

	arrow_l.position = Vector2(rect.position.x - arrow_space, rect.get_center().y)
	arrow_r.position = Vector2(rect.end.x + arrow_space, rect.get_center().y)


func _on_playbtn_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/cutscene_1.tscn")


func _on_optionsbtn_pressed() -> void:
	MenuManager.load_menu(MenuManager.SETTINGS_MENU)


func _on_quitbtn_pressed() -> void:
	get_tree().quit()
