extends Control

export(ButtonGroup) var group
export(int) var weapon = 1
export(bool) var Pshoot = false

onready var b1 = $WeaponPanel/Button
onready var b2 = $WeaponPanel/Button2
onready var b3 = $WeaponPanel/Button3
onready var b4 = $WeaponPanel/Button4
onready var b5 = $WeaponPanel/Button5
onready var b6 = $WeaponPanel/Button6

func _ready():
	for i in group.get_buttons():
		i.connect("pressed", self, "button_pressed")

func button_pressed():
	if group.get_pressed_button() == b1:
		print("weapon 1")
		weapon = 1
	elif group.get_pressed_button() == b2:
		print("weapon 2")
		weapon = 2
	elif group.get_pressed_button() == b3:
		print("weapon 3")
		weapon = 3
	elif group.get_pressed_button() == b4:
		print("weapon 4")
		weapon = 4
	elif group.get_pressed_button() == b5:
		print("weapon 5")
		weapon = 5
	elif group.get_pressed_button() == b6:
		print("weapon 6")
		weapon = 6

func _on_Button_button_down():
	Pshoot = true
	print(Pshoot)

func _on_Button_button_up():
	Pshoot = false
	print(Pshoot)
