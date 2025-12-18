extends Button

@onready var upgrade_name = $CardBorder/CardInner/VBoxContainer/UpgradeName
@onready var upgrade_description = $CardBorder/CardInner/VBoxContainer/UpgradeDescription
@onready var icon_label = $CardBorder/CardInner/VBoxContainer/IconContainer/IconLabel

var upgrade_data: Dictionary

# Mapeo de iconos por tipo de upgrade
var upgrade_icons = {
	"health_boost": "♥",
	"speed_boost": "⚡",
	"damage_boost": "⚔",
	"attack_speed": "※",
	"pickup_range": "⊕",
	"armor": "⛨"
}

func _ready():
	print("UpgradeButton ready, has nodes: ", has_node("CardBorder/CardInner/VBoxContainer/UpgradeName"))

func setup_upgrade(upgrade: Dictionary):
	print("Setup upgrade called: ", upgrade.get("name", "UNKNOWN"))
	upgrade_data = upgrade
	
	if upgrade_name:
		upgrade_name.text = upgrade.name
	
	if upgrade_description:
		upgrade_description.text = upgrade.description
	
	# Asignar icono según el tipo de upgrade
	if icon_label and upgrade.has("id"):
		var icon = upgrade_icons.get(upgrade.id, "✦")
		icon_label.text = icon
	
	print("Button text set to: ", upgrade.name)
