extends Node

##Handles the saving, loading and altering of settings.
##All settings get saved to a settings config when calling save_settings().

const SETTINGS_PATH: String = "user://settings.cfg"

#audio buses
const MASTER_BUS: String = "Master"
const SFX_BUS: String = "SFX"
const MUSIC_BUS: String = "Music"

#resolutions
const RESOLUTIONS: Array[Vector2i] = [
	Vector2i(1152, 648),
	Vector2i(1280, 720),
	Vector2i(1920, 1080),
]

#framerate (0 will uncap it)
const FPS_CAPS: Array[int] = [0, 30, 60, 120, 144]

#audio
var master_volume: float = 1.0
var sfx_volume: float = 1.0
var music_volume: float = 1.0

#vidoe
var fullscreen: bool = false
var vsync: bool = true
var resolution: Vector2i = Vector2i(1920, 1080)
var fps_cap: int = 0


func _ready() -> void:
	load_settings()


##Loads settings from the config file and applies them
func load_settings() -> void:
	var config = ConfigFile.new()
	var error = config.load(SETTINGS_PATH)

	if error != OK:
		apply_settings()
		return

	master_volume = config.get_value("audio", "master_volume", master_volume)
	sfx_volume = config.get_value("audio", "sfx_volume", sfx_volume)
	music_volume = config.get_value("audio", "music_volume", music_volume)
	fullscreen = config.get_value("video", "fullscreen", fullscreen)
	vsync = config.get_value("video", "vsync", vsync)
	resolution = config.get_value("video", "resolution", resolution)
	fps_cap = config.get_value("video", "fps_cap", fps_cap)

	apply_settings()


##Saves the current settings to the config file
func save_settings() -> void:
	var config = ConfigFile.new()

	config.set_value("audio", "master_volume", master_volume)
	config.set_value("audio", "sfx_volume", sfx_volume)
	config.set_value("audio", "music_volume", music_volume)
	config.set_value("video", "fullscreen", fullscreen)
	config.set_value("video", "vsync", vsync)
	config.set_value("video", "resolution", resolution)
	config.set_value("video", "fps_cap", fps_cap)

	var error = config.save(SETTINGS_PATH)

	if error != OK:
		push_error("Something failed to save :(")


func apply_settings() -> void:
	_apply_audio()
	_apply_video()


func _apply_audio() -> void:
	_set_bus_volume(MASTER_BUS, master_volume)
	_set_bus_volume(SFX_BUS, sfx_volume)
	_set_bus_volume(MUSIC_BUS, music_volume)

func _apply_video() -> void:
	if fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		DisplayServer.window_set_size(resolution)
	if vsync:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)

	Engine.max_fps = fps_cap


func _set_bus_volume(bus_name: String, volume: float) -> void:
	var bus_index = AudioServer.get_bus_index(bus_name)

	if bus_index == -1:
		return

	AudioServer.set_bus_volume_db(bus_index, linear_to_db(volume))
