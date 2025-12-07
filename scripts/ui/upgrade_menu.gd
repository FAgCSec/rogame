extends CanvasLayer

@onready var upgrade_container = $Panel/VBoxContainer/UpgradeContainer
@onready var title_label = $Panel/VBoxContainer/TitleLabel

var upgrade_button_scene = preload("res://scenes/ui/upgrade_button.tscn")
var game_manager: Node

func _ready():
	game_manager = get_node("/root/GameManager")
	visible = false

func show_upgrades():
	# Limpiar upgrades anteriores
	for child in upgrade_container.get_children():
		child.queue_free()
	
	# Obtener upgrades aleatorios
	var upgrades = game_manager.get_random_upgrades(3)
	
	# Crear botones
	for upgrade in upgrades:
		var button = upgrade_button_scene.instantiate()
		upgrade_container.add_child(button)
		button.setup_upgrade(upgrade)
		button.pressed.connect(_on_upgrade_selected.bind(upgrade))
	
	# Mostrar menú PRIMERO
	visible = true
	show()
	
	# Forzar actualización visual
	await get_tree().process_frame
	
	# AHORA sí pausar
	get_tree().paused = true

func _on_upgrade_selected(upgrade: Dictionary):
	game_manager.apply_upgrade(upgrade.id)
	visible = false
	game_manager.is_paused = false
	get_tree().paused = false
	
	# Actualizar stats del jugador si existe
	var player = get_tree().get_first_node_in_group("player")
	if player and player.has_method("update_pickup_range"):
		player.update_pickup_range()
	if player and player.has_method("update_attack_speed"):
		player.update_attack_speed()
	
	print("Mejora aplicada: ", upgrade.name)
