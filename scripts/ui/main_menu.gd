extends Control

@onready var start_button = $VBoxContainer/StartButton
@onready var quit_button = $VBoxContainer/QuitButton
@onready var title_label = $VBoxContainer/TitleLabel

func _ready():
	start_button.pressed.connect(_on_start_button_pressed)
	quit_button.pressed.connect(_on_quit_button_pressed)

func _on_start_button_pressed():
	get_node("/root/GameManager").reset_game()
	get_tree().change_scene_to_file("res://scenes/game_world.tscn")

func _on_quit_button_pressed():
	get_tree().quit()
