extends CharacterBody2D

@export var speed: float = 200.0

@onready var weapon_pivot = $WeaponPivot
@onready var attack_timer = $AttackTimer
@onready var hurtbox = $Hurtbox
@onready var pickup_area = $PickupArea

var projectile_scene = preload("res://scenes/entities/projectile.tscn")
var game_manager: Node

func _ready():
	add_to_group("player")
	game_manager = get_node("/root/GameManager")
	attack_timer.timeout.connect(_on_attack_timer_timeout)
	hurtbox.area_entered.connect(_on_hurtbox_area_entered)
	pickup_area.area_entered.connect(_on_pickup_area_entered)
	
	# Configurar el rango de recolección
	update_pickup_range()

func _physics_process(_delta):
	if game_manager.is_paused:
		return
	
	# Movimiento
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	input_vector = input_vector.normalized()
	
	velocity = input_vector * game_manager.player_stats.move_speed
	move_and_slide()
	
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
	# El daño ahora es manejado por enemy_base.gd
	pass

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
