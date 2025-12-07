extends CharacterBody2D

# Enemigo tanque - lento pero resistente
@export var speed: float = 50.0
@export var health: float = 80.0
@export var damage: float = 15.0
@export var xp_value: int = 3

@onready var hitbox = $Hitbox
@onready var health_bar = $HealthBar

var player: Node2D
var xp_gem_scene = preload("res://scenes/entities/xp_gem.tscn")

func _ready():
	add_to_group("enemies")
	player = get_tree().get_first_node_in_group("player")
	
	if health_bar:
		health_bar.max_value = health
		health_bar.value = health

func _physics_process(_delta):
	if not player or get_node("/root/GameManager").is_paused:
		return
	
	var direction = (player.global_position - global_position).normalized()
	velocity = direction * speed
	move_and_slide()

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
	get_parent().add_child(xp_gem)
	xp_gem.global_position = global_position
	xp_gem.xp_value = xp_value
