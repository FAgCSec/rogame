extends CanvasLayer

@onready var game_over_label = $Panel/VBoxContainer/GameOverLabel
@onready var stats_label = $Panel/VBoxContainer/StatsLabel
@onready var restart_button = $Panel/VBoxContainer/RestartButton
@onready var menu_button = $Panel/VBoxContainer/MenuButton

var game_manager: Node

func _ready():
	game_manager = get_node("/root/GameManager")
	restart_button.pressed.connect(_on_restart_pressed)
	menu_button.pressed.connect(_on_menu_pressed)
	visible = false

func show_game_over():
	visible = true
	get_tree().paused = true
	
	var minutes = int(game_manager.time_survived) / 60
	var seconds = int(game_manager.time_survived) % 60
	
	stats_label.text = "Nivel Alcanzado: %d\nTiempo Sobrevivido: %02d:%02d\nEnemigos Eliminados: %d" % [
		game_manager.current_level,
		minutes,
		seconds,
		game_manager.kills
	]

func _on_restart_pressed():
	get_tree().paused = false
	visible = false
	get_node("/root/GameManager").reset_game()
	get_tree().reload_current_scene()

func _on_menu_pressed():
	get_tree().paused = false
	visible = false
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")
