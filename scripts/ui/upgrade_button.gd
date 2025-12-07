extends Button

@onready var upgrade_name = $VBoxContainer/UpgradeName
@onready var upgrade_description = $VBoxContainer/UpgradeDescription

var upgrade_data: Dictionary

func _ready():
	print("UpgradeButton ready, has nodes: ", has_node("VBoxContainer/UpgradeName"))

func setup_upgrade(upgrade: Dictionary):
	print("Setup upgrade called: ", upgrade.get("name", "UNKNOWN"))
	upgrade_data = upgrade
	if upgrade_name:
		upgrade_name.text = upgrade.name
	if upgrade_description:
		upgrade_description.text = upgrade.description
	print("Button text set to: ", upgrade.name)
