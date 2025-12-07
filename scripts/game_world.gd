extends Node2D

@export var enemy_fast_scene: PackedScene
@export var enemy_normal_scene: PackedScene
@export var enemy_tank_scene: PackedScene

@onready var spawn_timer = $SpawnTimer
@onready var player = $Player

var spawn_distance = 700.0
var difficulty_timer = 0.0
var enemies_per_spawn = 1

func _ready():
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	get_node("/root/GameManager").level_up.connect(_on_level_up)
	get_node("/root/GameManager").player_died.connect(_on_player_died)

func _process(delta):
	if not get_node("/root/GameManager").is_paused:
		get_node("/root/GameManager").time_survived += delta
		difficulty_timer += delta
		
		# Aumentar dificultad con el tiempo
		if difficulty_timer >= 30.0:
			difficulty_timer = 0.0
			enemies_per_spawn += 1
			spawn_timer.wait_time = max(0.5, spawn_timer.wait_time * 0.9)

func _on_spawn_timer_timeout():
	for i in enemies_per_spawn:
		spawn_random_enemy()

func spawn_random_enemy():
	var enemy_scene: PackedScene
	var game_manager = get_node("/root/GameManager")
	var upgrades_count = game_manager.upgrades_applied
	var rand = randf()
	
	# Sistema de dificultad progresiva basado en upgrades
	if upgrades_count < 5:
		# Primeras 5 mejoras: solo enemigos débiles (fast)
		enemy_scene = enemy_fast_scene
	elif upgrades_count < 10:
		# Mejoras 6-10: enemigos débiles y normales
		# 40% normal, 60% fast
		if rand < 0.6:
			enemy_scene = enemy_fast_scene
		else:
			enemy_scene = enemy_normal_scene
	else:
		# Mejoras 11+: todos los tipos
		# 40% normal, 30% fast, 30% tank
		if rand < 0.4:
			enemy_scene = enemy_normal_scene
		elif rand < 0.7:
			enemy_scene = enemy_fast_scene
		else:
			enemy_scene = enemy_tank_scene
	
	if enemy_scene:
		var enemy = enemy_scene.instantiate()
		add_child(enemy)
		
		# Posición aleatoria fuera de la pantalla
		var angle = randf() * TAU
		var spawn_pos = player.global_position + Vector2(cos(angle), sin(angle)) * spawn_distance
		enemy.global_position = spawn_pos

func _on_level_up(_new_level: int):
	# NO pausar aquí, dejar que upgrade_menu lo haga
	var upgrade_menu = $UI/UpgradeMenu
	if upgrade_menu and upgrade_menu.has_method("show_upgrades"):
		# Llamar de forma diferida para que se procese después del frame actual
		upgrade_menu.call_deferred("show_upgrades")
	else:
		# Si no hay menú, aplicar upgrade aleatorio
		var upgrades = get_node("/root/GameManager").get_random_upgrades(1)
		if upgrades.size() > 0:
			get_node("/root/GameManager").apply_upgrade(upgrades[0].id)

func _on_player_died():
	# Mostrar pantalla de game over
	var game_over_menu = get_node("../UI/GameOverMenu")
	if game_over_menu:
		game_over_menu.show_game_over()
