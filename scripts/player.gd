extends CharacterBody2D

@export var speed: float = 200.0

@onready var weapon_pivot = $WeaponPivot
@onready var attack_timer = $AttackTimer
@onready var hurtbox = $Hurtbox
@onready var pickup_area = $PickupArea
@onready var shoot_sound = $ShootSound
@onready var hurt_sound = $HurtSound
@onready var visual_effects = $VisualEffects
@onready var trail_particles = $TrailParticles

var projectile_scene = preload("res://scenes/entities/projectile.tscn")
var game_manager: Node
var sound_generator: Node
var is_hurt: bool = false
var hurt_timer: float = 0.0

# DASH
@export var dash_speed_multiplier: float = 3.0
@export var dash_duration: float = 0.2
@export var dash_cooldown: float = 0.8
var can_dash: bool = true
var is_dashing: bool = false
var dash_direction: Vector2 = Vector2.ZERO

func _ready():
	add_to_group("player")
	game_manager = get_node("/root/GameManager")
	sound_generator = get_node("/root/SoundGenerator")
	attack_timer.timeout.connect(_on_attack_timer_timeout)
	hurtbox.area_entered.connect(_on_hurtbox_area_entered)
	pickup_area.area_entered.connect(_on_pickup_area_entered)
	
	# Configurar el rango de recolección
	update_pickup_range()
	
	# Pre-generar sonidos
	shoot_sound.stream = sound_generator.create_shoot_sound()
	hurt_sound.stream = sound_generator.create_hurt_sound()
	
	# Aplicar volúmenes desde configuración
	update_audio_volumes()

func _physics_process(_delta):
	if game_manager.is_paused:
		return

	# DASH
	if Input.is_action_just_pressed("dash") and can_dash:
		start_dash()
	
	if is_dashing:
		velocity = dash_direction * game_manager.player_stats.move_speed * dash_speed_multiplier
		move_and_slide()
		return

	# Actualizar efecto de daño
	if is_hurt:
		hurt_timer -= _delta
		if hurt_timer <= 0:
			is_hurt = false
			if visual_effects:
				visual_effects.modulate = Color.WHITE
	
	# Movimiento
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	input_vector = input_vector.normalized()
	
	velocity = input_vector * game_manager.player_stats.move_speed
	move_and_slide()
	
	# Activar/desactivar partículas según el movimiento
	if trail_particles:
		trail_particles.emitting = velocity.length() > 50
	
	# Animación de movimiento (escala pulsante)
	if visual_effects and velocity.length() > 0:
		var pulse = 1.0 + sin(Time.get_ticks_msec() * 0.01) * 0.05
		visual_effects.scale = Vector2(pulse, pulse)
	
	# Rotar arma hacia el enemigo más cercano
	var nearest_enemy = find_nearest_enemy()
	if nearest_enemy:
		weapon_pivot.look_at(nearest_enemy.global_position)

func _on_attack_timer_timeout():
	var nearest_enemy = find_nearest_enemy()
	if nearest_enemy:
		shoot_projectile(nearest_enemy.global_position)

func shoot_projectile(target_position: Vector2):
	var projectile = projectile_scene.instantiate()
	get_parent().add_child(projectile)
	projectile.global_position = weapon_pivot.global_position
	
	var direction = (target_position - global_position).normalized()
	projectile.setup(direction, game_manager.player_stats.damage_multiplier)
	
	# Reproducir sonido de disparo
	if shoot_sound:
		shoot_sound.play()

func find_nearest_enemy() -> Node2D:
	var enemies = get_tree().get_nodes_in_group("enemies")
	var nearest: Node2D = null
	var min_distance = INF
	
	for enemy in enemies:
		var distance = global_position.distance_to(enemy.global_position)
		if distance < min_distance:
			min_distance = distance
			nearest = enemy
	
	return nearest

func _on_hurtbox_area_entered(area: Area2D):
	# El daño es manejado principalmente en enemy_base.gd mediante distancia
	# pero esta función puede usarse para validar colisiones de enemigos
	if area.is_in_group("enemy_hitbox"):
		pass  # El daño por tiempo ya está siendo manejado en enemy_base.gd

func _on_pickup_area_entered(area):
	if area.is_in_group("xp_gem"):
		var xp_amount = area.xp_value if area.has_meta("xp_value") or "xp_value" in area else 1
		game_manager.add_xp(xp_amount)
		
		# Activar animación de atracción en lugar de eliminar inmediatamente
		if area.has_method("attract"):
			area.attract()
		else:
			area.queue_free()

func update_pickup_range():
	if pickup_area:
		var collision_shape = pickup_area.get_node("CollisionShape2D")
		if collision_shape and collision_shape.shape is CircleShape2D:
			collision_shape.shape.radius = 120 * game_manager.player_stats.pickup_range

func update_attack_speed():
	attack_timer.wait_time = 1.0 / game_manager.player_stats.attack_speed_multiplier

func play_hurt_sound():
	if hurt_sound:
		hurt_sound.play()
	
	# Efecto visual de daño
	apply_damage_effect()

func apply_damage_effect():
	is_hurt = true
	hurt_timer = 0.2
	
	if visual_effects:
		# Flash rojo
		visual_effects.modulate = Color(1.5, 0.5, 0.5, 1.0)
		
		# Shake visual
		var tween = create_tween()
		tween.set_parallel(true)
		tween.tween_property(visual_effects, "position:x", randf_range(-3, 3), 0.05)
		tween.tween_property(visual_effects, "position:y", randf_range(-3, 3), 0.05)
		tween.chain().tween_property(visual_effects, "position", Vector2.ZERO, 0.1)

func update_audio_volumes():
	var audio_settings = get_node("/root/AudioSettings")
	if shoot_sound:
		shoot_sound.volume_db = audio_settings.get_volume_db("shoot")
	if hurt_sound:
		hurt_sound.volume_db = audio_settings.get_volume_db("hurt")

# DASH
func start_dash():
	if not can_dash:
		return
	
	if velocity != Vector2.ZERO:
		dash_direction = velocity.normalized()
	else:
		dash_direction = (get_global_mouse_position() - global_position).normalized()
	
	is_dashing = true
	can_dash = false
	
	modulate.a = 0.5 
	if trail_particles:
		trail_particles.emitting = true
	
	await get_tree().create_timer(dash_duration).timeout
	end_dash()

func end_dash():
	is_dashing = false
	velocity = Vector2.ZERO
	modulate.a = 1.0
	
	await get_tree().create_timer(dash_cooldown).timeout
	can_dash = true