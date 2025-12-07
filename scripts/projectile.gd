extends Area2D

@export var speed: float = 300.0
@export var damage: float = 10.0
@export var lifetime: float = 2.0

var direction: Vector2 = Vector2.RIGHT
var damage_multiplier: float = 1.0

func setup(dir: Vector2, dmg_mult: float):
	direction = dir.normalized()
	damage_multiplier = dmg_mult
	rotation = direction.angle()

func _ready():
	body_entered.connect(_on_body_entered)
	area_entered.connect(_on_area_entered)
	
	# Auto-destruir después del tiempo de vida
	await get_tree().create_timer(lifetime).timeout
	queue_free()

func _physics_process(delta):
	position += direction * speed * delta

func _on_body_entered(body):
	if body.is_in_group("enemies"):
		body.take_damage(damage * damage_multiplier)
		queue_free()

func _on_area_entered(area):
	if area.is_in_group("enemy_hitbox"):
		if area.get_parent().has_method("take_damage"):
			area.get_parent().take_damage(damage * damage_multiplier)
		queue_free()
