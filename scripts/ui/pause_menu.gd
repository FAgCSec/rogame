extends CanvasLayer

@onready var panel = $Panel
@onready var resume_button = $Panel/VBoxContainer/ResumeButton
@onready var menu_button = $Panel/VBoxContainer/MenuButton

var game_manager: Node

func _ready():
	game_manager = get_node("/root/GameManager")
	resume_button.pressed.connect(_on_resume_pressed)
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

func _on_menu_pressed():
	hide_pause()
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")
