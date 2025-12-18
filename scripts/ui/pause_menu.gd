extends CanvasLayer

@onready var panel = $Panel
@onready var overlay = $Overlay
@onready var resume_button = $Panel/VBoxContainer/ResumeButton
@onready var settings_button = $Panel/VBoxContainer/SettingsButton
@onready var restart_button = $Panel/VBoxContainer/RestartButton
@onready var menu_button = $Panel/VBoxContainer/MenuButton

var game_manager: Node
var settings_menu_scene = preload("res://scenes/ui/settings_menu.tscn")
var settings_menu_instance = null
var is_animating: bool = false

func _ready():
	game_manager = get_node("/root/GameManager")
	resume_button.pressed.connect(_on_resume_pressed)
	settings_button.pressed.connect(_on_settings_pressed)
	restart_button.pressed.connect(_on_restart_pressed)
	menu_button.pressed.connect(_on_menu_pressed)
	
	# Conectar efectos hover a los botones
	setup_button_effects(resume_button)
	setup_button_effects(settings_button)
	setup_button_effects(restart_button)
	setup_button_effects(menu_button)
	
	visible = false
	
	# Configuración inicial para animaciones
	panel.modulate.a = 0.0
	panel.scale = Vector2(0.8, 0.8)
	overlay.modulate.a = 0.0

func setup_button_effects(button: Button):
	button.mouse_entered.connect(func(): _on_button_hover(button))
	button.mouse_exited.connect(func(): _on_button_unhover(button))

func _on_button_hover(button: Button):
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_BACK)
	tween.tween_property(button, "scale", Vector2(1.05, 1.05), 0.2)

func _on_button_unhover(button: Button):
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_BACK)
	tween.tween_property(button, "scale", Vector2(1.0, 1.0), 0.2)

func _input(event):
	if event.is_action_pressed("pause") and not is_animating:
		toggle_pause()

func toggle_pause():
	if visible:
		hide_pause()
	else:
		show_pause()

func show_pause():
	if is_animating:
		return
	
	is_animating = true
	visible = true
	get_tree().paused = true
	game_manager.is_paused = true
	
	# Animación de entrada
	var tween = create_tween()
	tween.set_parallel(true)
	
	# Fade in del overlay
	tween.tween_property(overlay, "modulate:a", 1.0, 0.3)
	
	# Panel aparece con escala y fade
	tween.tween_property(panel, "modulate:a", 1.0, 0.3)
	tween.tween_property(panel, "scale", Vector2(1.0, 1.0), 0.4).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	
	await tween.finished
	is_animating = false

func hide_pause():
	if is_animating:
		return
	
	is_animating = true
	
	# Animación de salida
	var tween = create_tween()
	tween.set_parallel(true)
	
	# Fade out del overlay
	tween.tween_property(overlay, "modulate:a", 0.0, 0.2)
	
	# Panel desaparece con escala y fade
	tween.tween_property(panel, "modulate:a", 0.0, 0.2)
	tween.tween_property(panel, "scale", Vector2(0.8, 0.8), 0.3).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_BACK)
	
	await tween.finished
	
	visible = false
	get_tree().paused = false
	game_manager.is_paused = false
	is_animating = false

func _on_resume_pressed():
	hide_pause()

func _on_settings_pressed():
	if not settings_menu_instance:
		settings_menu_instance = settings_menu_scene.instantiate()
		get_parent().add_child(settings_menu_instance)
	settings_menu_instance.show_settings()

func _on_restart_pressed():
	hide_pause()
	game_manager.reset_game()
	get_tree().reload_current_scene()

func _on_menu_pressed():
	hide_pause()
	game_manager.reset_game()
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")
