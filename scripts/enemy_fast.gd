extends CharacterBody2D

# Enemigo rápido pero débil
@export var speed: float = 120.0
@export var health: float = 20.0
@export var damage: float = 8.0
@export var xp_value: int = 1
@export var damage_cooldown: float = 1.0
@export var knockback_speed: float = 200.0
@export var knockback_duration: float = 0.2

@onready var hitbox = $Hitbox
@onready var health_bar = $HealthBar
@onready var visual_effects = $VisualEffects if has_node("VisualEffects") else null
@onready var speed_trail = $SpeedTrail if has_node("SpeedTrail") else null

var player: Node2D
var xp_gem_scene = preload("res://scenes/entities/xp_gem.tscn")
var damage_timer: float = 0.0
var knockback_timer: float = 0.0
var knockback_direction: Vector2 = Vector2.ZERO
var rotation_speed: float = 3.0

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
	
	# Rotación suave hacia el jugador
	if visual_effects:
		var target_rotation = direction.angle() + PI/2
		visual_effects.rotation = lerp_angle(visual_effects.rotation, target_rotation, rotation_speed * delta)
	
	# Activar partículas según la velocidad
	if speed_trail:
		speed_trail.emitting = velocity.length() > 50
	
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
	
	# Efecto de daño mejorado
	if visual_effects:
		var tween = create_tween()
		tween.set_parallel(true)
		# Flash blanco
		tween.tween_property(visual_effects, "modulate", Color(2, 2, 2, 1), 0.05)
		tween.tween_property(visual_effects, "scale", Vector2(1.2, 1.2), 0.05)
		tween.chain().set_parallel(true)
		tween.tween_property(visual_effects, "modulate", Color.WHITE, 0.15)
		tween.tween_property(visual_effects, "scale", Vector2.ONE, 0.15)
		
		# Shake
		var shake_offset = Vector2(randf_range(-2, 2), randf_range(-2, 2))
		visual_effects.position = shake_offset
		tween.tween_property(visual_effects, "position", Vector2.ZERO, 0.1)
	
	if health <= 0:
		die()

func die():
	drop_xp()
	get_node("/root/GameManager").add_kill()
	
	# Animación de muerte
	if visual_effects:
		var tween = create_tween()
		tween.set_parallel(true)
		tween.tween_property(visual_effects, "modulate:a", 0.0, 0.3)
		tween.tween_property(visual_effects, "scale", Vector2(1.5, 1.5), 0.3)
		tween.tween_property(visual_effects, "rotation", visual_effects.rotation + PI * 2, 0.3)
		await tween.finished
	
	queue_free()

func drop_xp():
	var xp_gem = xp_gem_scene.instantiate()
	xp_gem.global_position = global_position
	xp_gem.xp_value = xp_value
	get_parent().call_deferred("add_child", xp_gem)
