extends Control

@onready var start_button = $VBoxContainer/StartButton
@onready var settings_button = $VBoxContainer/SettingsButton
@onready var quit_button = $VBoxContainer/QuitButton
@onready var title_label = $VBoxContainer/TitleLabel

var settings_menu_scene = preload("res://scenes/ui/settings_menu.tscn")
var settings_menu_instance = null

func _ready():
	start_button.pressed.connect(_on_start_button_pressed)
	settings_button.pressed.connect(_on_settings_button_pressed)
	quit_button.pressed.connect(_on_quit_button_pressed)
	
	# Reproducir música ambiente en el menú
	get_node("/root/MusicGenerator").play_ambient_music()

func _on_start_button_pressed():
	get_node("/root/GameManager").reset_game()
	get_tree().change_scene_to_file("res://scenes/game_world.tscn")

func _on_settings_button_pressed():
	if not settings_menu_instance:
		settings_menu_instance = settings_menu_scene.instantiate()
		add_child(settings_menu_instance)
	settings_menu_instance.show_settings()

func _on_quit_button_pressed():
	get_tree().quit()
