extends Node

# Singleton para gestionar configuraciones de audio del juego

const SETTINGS_FILE = "user://settings.save"

var volumes = {
	"music": 0.5,
	"shoot": 0.5,
	"hurt": 0.5,
	"enemy_death": 0.5
}

func _ready():
	load_settings()

func get_volume(sound_type: String) -> float:
	return volumes.get(sound_type, 0.5)

func get_volume_db(sound_type: String) -> float:
	var linear = get_volume(sound_type)
	if linear <= 0:
		return -80.0
	return 20.0 * log(linear) / log(10.0)

func set_volume(sound_type: String, value: float):
	volumes[sound_type] = clamp(value, 0.0, 1.0)
	save_settings()

func save_settings():
	var file = FileAccess.open(SETTINGS_FILE, FileAccess.WRITE)
	if file:
		file.store_var(volumes)
		file.close()

func load_settings():
	if FileAccess.file_exists(SETTINGS_FILE):
		var file = FileAccess.open(SETTINGS_FILE, FileAccess.READ)
		if file:
			volumes = file.get_var()
			file.close()
