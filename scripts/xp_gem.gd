extends Area2D

@export var xp_value: int = 1
@export var attraction_speed: float = 500.0
@export var attraction_duration: float = 0.3

var player: Node2D
var is_attracted: bool = false
var attraction_progress: float = 0.0

func _ready():
	add_to_group("xp_gem")
	player = get_tree().get_first_node_in_group("player")

func _physics_process(delta):
	if is_attracted and player:
		attraction_progress += delta / attraction_duration
		
		if attraction_progress >= 1.0:
			# Animación completada, eliminar orbe
			queue_free()
			return
		
		# Interpolación suave hacia el jugador
		var direction = (player.global_position - global_position).normalized()
		global_position += direction * attraction_speed * delta
		
		# Hacer que se encoja mientras se mueve
		var scale_factor = 1.0 - (attraction_progress * 0.7)
		scale = Vector2(scale_factor, scale_factor)
		
		# Fade out (si hay alpha)
		if modulate.a > 0:
			modulate.a = 1.0 - attraction_progress

func attract():
	is_attracted = true
