extends CanvasLayer

@onready var health_bar = $MarginContainer/VBoxContainer/HealthBar
@onready var health_label = $MarginContainer/VBoxContainer/HealthBar/Label
@onready var xp_bar = $MarginContainer/VBoxContainer/XPBar
@onready var level_label = $MarginContainer/VBoxContainer/TopStats/LevelLabel
@onready var time_label = $MarginContainer/VBoxContainer/TopStats/TimeLabel
@onready var kills_label = $MarginContainer/VBoxContainer/TopStats/KillsLabel

var game_manager: Node

func _ready():
	game_manager = get_node("/root/GameManager")
	game_manager.xp_gained.connect(_on_xp_gained)
	game_manager.level_up.connect(_on_level_up)

func _process(_delta):
	update_hud()

func update_hud():
	# Salud
	health_bar.max_value = game_manager.player_stats.max_health
	health_bar.value = game_manager.player_stats.current_health
	health_label.text = "%d / %d" % [game_manager.player_stats.current_health, game_manager.player_stats.max_health]
	
	# XP
	xp_bar.max_value = game_manager.xp_to_next_level
	xp_bar.value = game_manager.current_xp
	
	# Nivel
	level_label.text = "Nivel: %d" % game_manager.current_level
	
	# Tiempo
	var minutes = int(game_manager.time_survived) / 60
	var seconds = int(game_manager.time_survived) % 60
	time_label.text = "Tiempo: %02d:%02d" % [minutes, seconds]
	
	# Kills
	kills_label.text = "Kills: %d" % game_manager.kills

func _on_xp_gained(_amount):
	# Animación o feedback
	pass

func _on_level_up(_new_level):
	# Animación de level up
	pass
