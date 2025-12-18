extends CanvasLayer

@onready var panel = $Panel
@onready var resume_button = $Panel/VBoxContainer/ResumeButton
@onready var settings_button = $Panel/VBoxContainer/SettingsButton
@onready var restart_button = $Panel/VBoxContainer/RestartButton
@onready var menu_button = $Panel/VBoxContainer/MenuButton

var game_manager: Node
var settings_menu_scene = preload("res://scenes/ui/settings_menu.tscn")
var settings_menu_instance = null

func _ready():
	game_manager = get_node("/root/GameManager")
	resume_button.pressed.connect(_on_resume_pressed)
	settings_button.pressed.connect(_on_settings_pressed)
	restart_button.pressed.connect(_on_restart_pressed)
	menu_button.pressed.connect(_on_menu_pressed)
	visible = false

func _input(event):
	if event.is_action_pressed("pause"):
		toggle_pause()

func toggle_pause():
	if visible:
		hide_pause()
	else:
		show_pause()

func show_pause():
	visible = true
	get_tree().paused = true
	game_manager.is_paused = true

func hide_pause():
	visible = false
	get_tree().paused = false
	game_manager.is_paused = false

func _on_resume_pressed():
	hide_pause()

func _on_settings_pressed():
	if not settings_menu_instance:
		settings_menu_instance = settings_menu_scene.instantiate()
		get_parent().add_child(settings_menu_instance)
	settings_menu_instance.show_settings()

func _on_restart_pressed():
	hide_pause()
	game_manager.reset_game()
	get_tree().reload_current_scene()

func _on_menu_pressed():
	hide_pause()
	game_manager.reset_game()
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")
