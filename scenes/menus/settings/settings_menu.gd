extends Control

@onready var back_btn: BaseButton = $BackBtn

func _ready() -> void:
	_check_signals()


func _check_signals() -> void:
	if !back_btn:
		push_error("Missing back button, please check tree and inspector.")
	else:
		back_btn.pressed.connect(_save_and_exit)


func _save_and_exit() -> void:
	print_debug("Settings saved to SettingsManager, closing menu after save.")
	#TODO: SettingsManager Setup and save configuration
