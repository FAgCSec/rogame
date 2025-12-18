extends CanvasLayer

@onready var music_slider = $Panel/VBoxContainer/ScrollContainer/SoundControls/MusicSlider
@onready var music_value = $Panel/VBoxContainer/ScrollContainer/SoundControls/MusicValue
@onready var shoot_slider = $Panel/VBoxContainer/ScrollContainer/SoundControls/ShootSlider
@onready var shoot_value = $Panel/VBoxContainer/ScrollContainer/SoundControls/ShootValue
@onready var hurt_slider = $Panel/VBoxContainer/ScrollContainer/SoundControls/HurtSlider
@onready var hurt_value = $Panel/VBoxContainer/ScrollContainer/SoundControls/HurtValue
@onready var enemy_death_slider = $Panel/VBoxContainer/ScrollContainer/SoundControls/EnemyDeathSlider
@onready var enemy_death_value = $Panel/VBoxContainer/ScrollContainer/SoundControls/EnemyDeathValue
@onready var back_button = $Panel/VBoxContainer/ButtonsContainer/BackButton

func _ready():
	# Conectar señales de sliders
	music_slider.value_changed.connect(_on_music_slider_changed)
	shoot_slider.value_changed.connect(_on_shoot_slider_changed)
	hurt_slider.value_changed.connect(_on_hurt_slider_changed)
	enemy_death_slider.value_changed.connect(_on_enemy_death_slider_changed)
	back_button.pressed.connect(_on_back_pressed)
	
	# Cargar configuraciones guardadas
	apply_settings()

func show_settings():
	visible = true
	get_tree().paused = true

func hide_settings():
	visible = false
	get_tree().paused = false

func _on_music_slider_changed(value: float):
	get_node("/root/AudioSettings").set_volume("music", value)
	music_value.text = "%d%%" % (value * 100)
	apply_music_volume()

func _on_shoot_slider_changed(value: float):
	get_node("/root/AudioSettings").set_volume("shoot", value)
	shoot_value.text = "%d%%" % (value * 100)

func _on_hurt_slider_changed(value: float):
	get_node("/root/AudioSettings").set_volume("hurt", value)
	hurt_value.text = "%d%%" % (value * 100)

func _on_enemy_death_slider_changed(value: float):
	get_node("/root/AudioSettings").set_volume("enemy_death", value)
	enemy_death_value.text = "%d%%" % (value * 100)

func _on_back_pressed():
	hide_settings()

func apply_settings():
	var audio_settings = get_node("/root/AudioSettings")
	
	# Aplicar valores a los sliders
	music_slider.value = audio_settings.get_volume("music")
	shoot_slider.value = audio_settings.get_volume("shoot")
	hurt_slider.value = audio_settings.get_volume("hurt")
	enemy_death_slider.value = audio_settings.get_volume("enemy_death")
	
	# Actualizar labels
	music_value.text = "%d%%" % (music_slider.value * 100)
	shoot_value.text = "%d%%" % (shoot_slider.value * 100)
	hurt_value.text = "%d%%" % (hurt_slider.value * 100)
	enemy_death_value.text = "%d%%" % (enemy_death_slider.value * 100)
	
	# Aplicar volúmenes
	apply_music_volume()

func apply_music_volume():
	var music_gen = get_node_or_null("/root/MusicGenerator")
	if music_gen:
		var volume_db = get_node("/root/AudioSettings").get_volume_db("music")
		music_gen.set_volume(volume_db)
