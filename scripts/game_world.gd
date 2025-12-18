extends Node2D

@export var enemy_fast_scene: PackedScene
@export var enemy_normal_scene: PackedScene
@export var enemy_tank_scene: PackedScene
@export var pillar_scene: PackedScene

@onready var spawn_timer = $SpawnTimer
@onready var player = $Player

var spawn_distance = 700.0
var difficulty_timer = 0.0
var enemies_per_spawn = 1

func _ready():
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	get_node("/root/GameManager").level_up.connect(_on_level_up)
	get_node("/root/GameManager").player_died.connect(_on_player_died)
	
	# Iniciar música de fondo
	get_node("/root/MusicGenerator").play_ambient_music()
	
	# Generar pilares en el mapa
	generate_pillars()

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
	var time_elapsed = game_manager.time_survived
	var rand = randf()
	
	# Sistema de dificultad progresiva basado en tiempo
	if time_elapsed < 60.0:
		# Primer minuto: solo enemigos rápidos (fast)
		enemy_scene = enemy_fast_scene
	elif time_elapsed < 120.0:
		# Segundo minuto: enemigos rápidos y normales
		# 40% normal, 60% fast
		if rand < 0.6:
			enemy_scene = enemy_fast_scene
		else:
			enemy_scene = enemy_normal_scene
	else:
		# Después del segundo minuto: todos los tipos
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
	var game_over_menu = $UI/GameOverMenu
	if game_over_menu:
		game_over_menu.show_game_over()

func generate_pillars():
	if not pillar_scene:
		return
	
	# Generar pilares distribuidos en un área de 2000x2000
	var area_size = 2000.0
	var num_pillars = 30
	var min_distance = 200.0  # Distancia mínima entre pilares
	var player_safe_zone = 300.0  # Zona segura alrededor del jugador
	
	var pillar_positions = []
	var attempts = 0
	var max_attempts = 100
	
	for i in num_pillars:
		var valid_position = false
		var new_pos = Vector2.ZERO
		attempts = 0
		
		while not valid_position and attempts < max_attempts:
			# Generar posición aleatoria
			new_pos = Vector2(
				randf_range(-area_size/2, area_size/2),
				randf_range(-area_size/2, area_size/2)
			)
			
			# Verificar que no esté en la zona del jugador
			if new_pos.length() < player_safe_zone:
				attempts += 1
				continue
			
			# Verificar distancia con otros pilares
			valid_position = true
			for pos in pillar_positions:
				if new_pos.distance_to(pos) < min_distance:
					valid_position = false
					break
			
			attempts += 1
		
		if valid_position:
			pillar_positions.append(new_pos)
			var pillar = pillar_scene.instantiate()
			add_child(pillar)
			pillar.global_position = new_pos
