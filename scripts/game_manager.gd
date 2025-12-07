extends Node

# Señales
signal xp_gained(amount: int)
signal level_up(new_level: int)
signal player_died
signal enemy_killed(enemy_type: String)
signal upgrade_selected(upgrade: Dictionary)

# Estado del juego
var current_level: int = 1
var current_xp: int = 0
var xp_to_next_level: int = 10
var kills: int = 0
var time_survived: float = 0.0
var is_paused: bool = false
var upgrades_applied: int = 0  # Contador de mejoras aplicadas

# Stats del jugador
var player_stats = {
	"max_health": 100,
	"current_health": 100,
	"move_speed": 200,
	"damage_multiplier": 1.0,
	"attack_speed_multiplier": 1.0,
	"pickup_range": 1.0,
	"armor": 0
}

# Upgrades disponibles
var available_upgrades = [
	{
		"id": "health_boost",
		"name": "Vida Extra",
		"description": "+20 de vida máxima",
		"icon": "res://assets/icons/health.png"
	},
	{
		"id": "speed_boost",
		"name": "Velocidad",
		"description": "+15% velocidad de movimiento",
		"icon": "res://assets/icons/speed.png"
	},
	{
		"id": "damage_boost",
		"name": "Más Daño",
		"description": "+25% daño",
		"icon": "res://assets/icons/damage.png"
	},
	{
		"id": "attack_speed",
		"name": "Ataque Rápido",
		"description": "+20% velocidad de ataque",
		"icon": "res://assets/icons/attack_speed.png"
	},
	{
		"id": "pickup_range",
		"name": "Imán de XP",
		"description": "+30% rango de recolección",
		"icon": "res://assets/icons/magnet.png"
	},
	{
		"id": "armor",
		"name": "Armadura",
		"description": "+5 de armadura",
		"icon": "res://assets/icons/armor.png"
	}
]

func _ready():
	pass

func reset_game():
	current_level = 0
	current_xp = 0
	xp_to_next_level = 10
	kills = 0
	time_survived = 0.0
	is_paused = false
	upgrades_applied = 0  # Resetear contador de upgrades
	
	player_stats = {
		"max_health": 100,
		"current_health": 100,
		"move_speed": 200,
		"damage_multiplier": 1.0,
		"attack_speed_multiplier": 1.0,
		"pickup_range": 1.0,
		"armor": 0
	}
	
	# Actualizar el rango de recolección del jugador
	var player = get_tree().get_first_node_in_group("player")
	if player and player.has_method("update_pickup_range"):
		player.update_pickup_range()

func add_xp(amount: int):
	current_xp += amount
	xp_gained.emit(amount)
	print("XP añadido: ", amount, " | Total: ", current_xp, "/", xp_to_next_level)
	
	# Verificar si sube de nivel
	if current_xp >= xp_to_next_level:
		print("¡SUBIENDO DE NIVEL!")
		level_up_player()

func level_up_player():
	current_xp -= xp_to_next_level
	current_level += 1
	xp_to_next_level += 2  # Aumenta +2 cada nivel
	print("Nivel actual: ", current_level, " | Próximo nivel: ", xp_to_next_level, " XP")
	level_up.emit(current_level)

func add_kill():
	kills += 1
	enemy_killed.emit("")

func apply_upgrade(upgrade_id: String):
	var upgrade = null
	for u in available_upgrades:
		if u.id == upgrade_id:
			upgrade = u
			break
	
	if upgrade == null:
		return
	
	upgrades_applied += 1  # Incrementar contador
	
	# Aplicar el efecto del upgrade
	match upgrade_id:
		"health_boost":
			player_stats.max_health += 20
			player_stats.current_health = player_stats.max_health
		"speed_boost":
			player_stats.move_speed *= 1.15
		"damage_boost":
			player_stats.damage_multiplier *= 1.25
		"attack_speed":
			player_stats.attack_speed_multiplier *= 1.20
			var player = get_tree().get_first_node_in_group("player")
			if player and player.has_method("update_attack_speed"):
				player.update_attack_speed()
		"pickup_range":
			player_stats.pickup_range *= 1.30
			var player = get_tree().get_first_node_in_group("player")
			if player and player.has_method("update_pickup_range"):
				player.update_pickup_range()
		"armor":
			player_stats.armor += 5
	
	upgrade_selected.emit(upgrade)

func get_random_upgrades(count: int = 3) -> Array:
	var shuffled = available_upgrades.duplicate()
	shuffled.shuffle()
	return shuffled.slice(0, min(count, shuffled.size()))

func take_damage(amount: int) -> int:
	var damage_after_armor = max(1, amount - player_stats.armor)
	player_stats.current_health -= damage_after_armor
	
	if player_stats.current_health <= 0:
		player_stats.current_health = 0
		player_died.emit()
	
	return damage_after_armor

func heal(amount: int):
	player_stats.current_health = min(player_stats.current_health + amount, player_stats.max_health)

func toggle_pause():
	is_paused = !is_paused
	get_tree().paused = is_paused
