extends Area2D

@export var speed: float = 300.0
@export var damage: float = 10.0
@export var lifetime: float = 2.0
@export var rotation_speed: float = 5.0

@onready var visual_effects = $VisualEffects if has_node("VisualEffects") else null
@onready var trail_particles = $TrailParticles if has_node("TrailParticles") else null

var direction: Vector2 = Vector2.RIGHT
var damage_multiplier: float = 1.0

func setup(dir: Vector2, dmg_mult: float):
	direction = dir.normalized()
	damage_multiplier = dmg_mult
	rotation = direction.angle()

func _ready():
	body_entered.connect(_on_body_entered)
	area_entered.connect(_on_area_entered)
	
	# Activar partículas
	if trail_particles:
		trail_particles.emitting = true
	
	# Auto-destruir después del tiempo de vida
	await get_tree().create_timer(lifetime).timeout
	queue_free()

func _physics_process(delta):
	position += direction * speed * delta
	
	# Rotación visual del proyectil
	if visual_effects:
		visual_effects.rotation += rotation_speed * delta
		
		# Efecto de pulso de escala
		var pulse = 1.0 + sin(Time.get_ticks_msec() * 0.02) * 0.1
		visual_effects.scale = Vector2(pulse, pulse)

func _on_body_entered(body):
	if body.is_in_group("enemies"):
		body.take_damage(damage * damage_multiplier)
		create_impact_effect()
		queue_free()

func _on_area_entered(area):
	if area.is_in_group("enemy_hitbox"):
		if area.get_parent().has_method("take_damage"):
			area.get_parent().take_damage(damage * damage_multiplier)
		create_impact_effect()
		queue_free()

func create_impact_effect():
	if visual_effects:
		# Animación de impacto rápida
		var tween = create_tween()
		tween.set_parallel(true)
		tween.tween_property(visual_effects, "modulate:a", 0.0, 0.1)
		tween.tween_property(visual_effects, "scale", Vector2(2.0, 2.0), 0.1)
