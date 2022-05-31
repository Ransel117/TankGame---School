extends Control

export(ButtonGroup) var group
export(int) var Eweapon = 1
export(bool) var Eshoot = false

onready var b1 = $WeaponPanel/Button
onready var b2 = $WeaponPanel/Button2
onready var b3 = $WeaponPanel/Button3
onready var b4 = $WeaponPanel/Button4
onready var b5 = $WeaponPanel/Button5
onready var b6 = $WeaponPanel/Button6

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in group.get_buttons():
		i.connect("pressed", self, "button_pressed")

func button_pressed():
	if group.get_pressed_button() == b1:
		print("weapon 1")
		Eweapon = 1
	elif group.get_pressed_button() == b2:
		print("weapon 2")
		Eweapon = 2
	elif group.get_pressed_button() == b3:
		print("weapon 3")
		Eweapon = 3
	elif group.get_pressed_button() == b4:
		print("weapon 4")
		Eweapon = 4
	elif group.get_pressed_button() == b5:
		print("weapon 5")
		Eweapon = 5
	elif group.get_pressed_button() == b6:
		print("weapon 6")
		Eweapon = 6

func _on_Button_button_down():
	Eshoot = true
	print(Eshoot)

func _on_Button_button_up():
	Eshoot = false
	print(Eshoot)
