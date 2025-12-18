extends CharacterBody2D

# Enemigo balanceado - stats medias
@export var speed: float = 80.0
@export var health: float = 40.0
@export var damage: float = 12.0
@export var xp_value: int = 2
@export var damage_cooldown: float = 1.0
@export var knockback_speed: float = 200.0
@export var knockback_duration: float = 0.2

@onready var hitbox = $Hitbox
@onready var health_bar = $HealthBar

var player: Node2D
var xp_gem_scene = preload("res://scenes/entities/xp_gem.tscn")
var damage_timer: float = 0.0
var knockback_timer: float = 0.0
var knockback_direction: Vector2 = Vector2.ZERO

func _ready():
	add_to_group("enemies")
	player = get_tree().get_first_node_in_group("player")
	
	if health_bar:
		health_bar.max_value = health
		health_bar.value = health

func _physics_process(delta):
	if not player or get_node("/root/GameManager").is_paused:
		return
	
	# Actualizar timer de daño
	if damage_timer > 0:
		damage_timer -= delta
	
	# Actualizar knockback
	if knockback_timer > 0:
		knockback_timer -= delta
		velocity = knockback_direction * knockback_speed
		move_and_slide()
		return
	
	var distance = global_position.distance_to(player.global_position)
	var direction = (player.global_position - global_position).normalized()
	
	# Si está muy cerca del jugador, hacer daño
	if distance < 50 and damage_timer <= 0:
		get_node("/root/GameManager").take_damage(int(damage))
		damage_timer = damage_cooldown
		# Aplicar knockback al enemigo
		apply_knockback(direction)
	
	# Movimiento normal: acercarse
	velocity = direction * speed
	move_and_slide()

func apply_knockback(attack_direction: Vector2):
	# El knockback es en dirección opuesta al ataque
	knockback_direction = -attack_direction
	knockback_timer = knockback_duration

func take_damage(amount: float):
	health -= amount
	
	if health_bar:
		health_bar.value = health
	
	modulate = Color(1, 0.5, 0.5)
	await get_tree().create_timer(0.1).timeout
	modulate = Color(1, 1, 1)
	
	if health <= 0:
		die()

func die():
	drop_xp()
	get_node("/root/GameManager").add_kill()
	queue_free()

func drop_xp():
	var xp_gem = xp_gem_scene.instantiate()
	xp_gem.global_position = global_position
	xp_gem.xp_value = xp_value
	get_parent().call_deferred("add_child", xp_gem)
