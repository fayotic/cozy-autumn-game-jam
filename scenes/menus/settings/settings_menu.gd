extends Control

@export var back_btn: BaseButton
@export var volume_slider: HSlider
@export var music_slider: HSlider
@export var sfx_slider: HSlider
@export var resolution_box: OptionButton
@export var fullscreen_toggle: CheckBox
@export var vsync_toggle: CheckBox
@export var fps_box: OptionButton

func _ready() -> void:
	_check_signals()
	_setup_resolutions()
	_setup_fps_caps()
	_update_ui()


func _check_signals() -> void:
	if !back_btn or !volume_slider or !music_slider or !sfx_slider or !resolution_box or !fullscreen_toggle or !vsync_toggle or !fps_box:
		push_error("Missing settings controls, please check tree and inspector.")
		return

	back_btn.pressed.connect(_save_and_exit)
	volume_slider.value_changed.connect(_set_master_volume)
	music_slider.value_changed.connect(_set_music_volume)
	sfx_slider.value_changed.connect(_set_sfx_volume)
	resolution_box.item_selected.connect(_set_resolution)
	fullscreen_toggle.toggled.connect(_set_fullscreen)
	vsync_toggle.toggled.connect(_set_vsync)
	fps_box.item_selected.connect(_set_fps_cap)


func _setup_resolutions() -> void:
	if !resolution_box:
		return

	resolution_box.clear()
	for i in SettingsManager.RESOLUTIONS.size(): #if we need more resolutions, add them to the constant
		var res: Vector2i = SettingsManager.RESOLUTIONS[i]
		resolution_box.add_item("%dx%d" % [res.x, res.y])


func _setup_fps_caps() -> void:
	if !fps_box:
		return

	fps_box.clear()
	for cap in SettingsManager.FPS_CAPS:
		fps_box.add_item("Uncapped" if cap == 0 else str(cap))


func _update_ui() -> void:
	if volume_slider:
		volume_slider.value = SettingsManager.master_volume
	if music_slider:
		music_slider.value = SettingsManager.music_volume
	if sfx_slider:
		sfx_slider.value = SettingsManager.sfx_volume
	if fullscreen_toggle:
		fullscreen_toggle.button_pressed = SettingsManager.fullscreen
	if vsync_toggle:
		vsync_toggle.button_pressed = SettingsManager.vsync
	if resolution_box:
		_select_current_resolution()
	if fps_box:
		_select_current_fps_cap()


func _select_current_resolution() -> void:
	var index = SettingsManager.RESOLUTIONS.find(SettingsManager.resolution)

	if index == -1:
		return

	resolution_box.select(index)


func _select_current_fps_cap() -> void:
	var index = SettingsManager.FPS_CAPS.find(SettingsManager.fps_cap)

	if index == -1:
		return

	fps_box.select(index)


func _set_master_volume(volume: float) -> void:
	SettingsManager.master_volume = volume
	SettingsManager.apply_settings()


func _set_music_volume(volume: float) -> void:
	SettingsManager.music_volume = volume
	SettingsManager.apply_settings()


func _set_sfx_volume(volume: float) -> void:
	SettingsManager.sfx_volume = volume
	SettingsManager.apply_settings()


func _set_resolution(index: int) -> void:
	if index < 0 or index >= SettingsManager.RESOLUTIONS.size():
		return

	SettingsManager.resolution = SettingsManager.RESOLUTIONS[index]
	SettingsManager.apply_settings()


func _set_fullscreen(enabled: bool) -> void:
	SettingsManager.fullscreen = enabled
	SettingsManager.apply_settings()


func _set_vsync(enabled: bool) -> void:
	SettingsManager.vsync = enabled
	SettingsManager.apply_settings()


func _set_fps_cap(index: int) -> void:
	if index < 0 or index >= SettingsManager.FPS_CAPS.size():
		return

	SettingsManager.fps_cap = SettingsManager.FPS_CAPS[index]
	SettingsManager.apply_settings()


func _save_and_exit() -> void:
	SettingsManager.save_settings()
	print_debug("Settings saved to SettingsManager, closig menu after save.")
	queue_free()
