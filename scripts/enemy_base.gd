extends CharacterBody2D

@export var speed: float = 80.0
@export var health: float = 30.0
@export var damage: float = 10.0
@export var xp_value: int = 1
@export var damage_cooldown: float = 1.0  # Hacer daño máximo 1 vez por segundo

@onready var hitbox = $Hitbox
@onready var health_bar = $HealthBar

var player: Node2D
var xp_gem_scene = preload("res://scenes/entities/xp_gem.tscn")
var damage_timer: float = 0.0
var death_sound_player: AudioStreamPlayer
var sound_generator: Node

func _ready():
	add_to_group("enemies")
	player = get_tree().get_first_node_in_group("player")
	sound_generator = get_node("/root/SoundGenerator")
	
	# Crear AudioStreamPlayer para sonido de muerte
	death_sound_player = AudioStreamPlayer.new()
	var audio_settings = get_node("/root/AudioSettings")
	death_sound_player.volume_db = audio_settings.get_volume_db("enemy_death")
	add_child(death_sound_player)
	
	if health_bar:
		health_bar.max_value = health
		health_bar.value = health

func _physics_process(delta):
	if not player:
		return
	
	if get_node("/root/GameManager").is_paused:
		return
	
	# Actualizar timer de daño
	if damage_timer > 0:
		damage_timer -= delta
	
	var distance = global_position.distance_to(player.global_position)
	
	# Si está muy cerca del jugador, hacer daño
	if distance < 50 and damage_timer <= 0:
		get_node("/root/GameManager").take_damage(int(damage))
		damage_timer = damage_cooldown
	
	# Moverse hacia el jugador
	var direction = (player.global_position - global_position).normalized()
	
	# Si está tocando al jugador, empujarse hacia atrás para no pegarse
	if distance < 35:
		velocity = -direction * speed  # Moverse en dirección opuesta
	else:
		velocity = direction * speed  # Moverse hacia el jugador
	
	move_and_slide()

func take_damage(amount: float):
	health -= amount
	
	if health_bar:
		health_bar.value = health
	
	# Feedback visual de daño
	# TODO: Agregar feedback visual
	
	if health <= 0:
		die()

func die():
	# Reproducir sonido de muerte
	if sound_generator and death_sound_player:
		death_sound_player.stream = sound_generator.create_enemy_death_sound()
		death_sound_player.play()
		# Esperar a que termine el sonido antes de eliminar
		await death_sound_player.finished
	
	# Soltar gema de XP
	drop_xp()
	
	# Notificar al game manager
	get_node("/root/GameManager").add_kill()
	
	queue_free()

func drop_xp():
	var xp_gem = xp_gem_scene.instantiate()
	get_parent().add_child(xp_gem)
	xp_gem.global_position = global_position
	xp_gem.xp_value = xp_value
