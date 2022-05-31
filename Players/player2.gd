extends KinematicBody2D

export var Bullet1: PackedScene = preload("res://Players/Weapons/bullet1.tscn")
export var Bullet2: PackedScene = preload("res://Players/Weapons/bullet2.tscn")
export var Bullet3: PackedScene = preload("res://Players/Weapons/bullet3.tscn")
export var Bullet4: PackedScene = preload("res://Players/Weapons/bullet4.tscn")
export var Bullet5: PackedScene = preload("res://Players/Weapons/bullet5.tscn")
export var Bullet6: PackedScene = preload("res://Players/Weapons/bullet6.tscn")
export var particles: PackedScene = preload("res://Players/TexplosionParticles.tscn")

const Fhealth = 200
export var Ehealth = Fhealth

const ffuel = 200
export var Efuel = ffuel

onready var player1 = get_parent().get_child(1)
onready var weaponctrl = get_parent().get_child(6).get_child(1).get_child(1).get_child(1)
onready var UI = get_parent().get_child(6).get_child(0)

var gravity = 400
var speed = 1500
var velocity = Vector2()
var bullet_velocity = 600
var power_change = 20
var min_power = 100
var max_power = 1200
var barrel_minrot = -180
var barrel_maxrot = 0
var bullet
var go = false
var shot = false
var pressed = false

func take_damage(amount):
	var old_health = Ehealth
	Ehealth -= amount
	if Ehealth <= 0:
		Ehealth = 0
		yield(get_tree().create_timer(1), "timeout")
		var inst = particles.instance()
		inst.connect("ded", UI,"on_win")
		inst.global_position = global_position + Vector2(0, -64)
		get_parent().call_deferred("add_child", inst)
		$RotPoint.hide()
		$Sprite.hide()
		$Sprite2.show()
	else:
		$RotPoint.show()
		$Sprite.show()
		$Sprite2.hide()

func get_input():
	var left = Input.is_action_pressed("Eleft")
	var right = Input.is_action_pressed("Eright")

	var up = Input.is_action_pressed("Eup")
	var down = Input.is_action_pressed("Edown")
	if go:
		
		if Efuel > 0:
			if left:
				velocity.x = -100
				Efuel -= 1
			elif right:
				velocity.x = 100
				Efuel -= 1
			else:
				velocity.x = 0
				Efuel = Efuel
		else:
			Efuel = 0
			velocity.x = 0

		if up:
			bullet_velocity += power_change
			bullet_velocity = clamp(bullet_velocity, min_power, max_power)
		elif down:
			bullet_velocity -= power_change
			bullet_velocity = clamp(bullet_velocity, min_power, max_power)

func _ready():
	set_physics_process(false)

func _physics_process(delta: float) -> void:
	bullet = weaponctrl.Eweapon
	get_input()
	if get_parent().eTurn:
		if get_parent().eTurn and shot == false:
			shooting()
		go = true
	else:
		Efuel = ffuel
		shot = false
		go = false

	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP, true)

	if is_on_floor():
		rotation = get_floor_normal().angle() + PI/2
	else:
		rotation = 0

func shooting():
		if weaponctrl.Eshoot:
#B2
			if bullet == 2:
				var b2 = Bullet2.instance()
				get_parent().call_deferred("add_child", b2)
				b2.transform = $RotPoint/ShootPoint.global_transform
				b2.velocity = b2.transform.x * bullet_velocity
				b2.gravity = gravity
				shot = true
				b2.connect("damage2", self, "_on_bullet2_hit")
				b2.connect("damage1", player1, "_on_bullet2_hit")
#B3
			elif bullet == 3:
				var b3 = Bullet3.instance()
				get_parent().call_deferred("add_child", b3)
				b3.transform = $RotPoint/ShootPoint.global_transform
				b3.velocity = b3.transform.x * bullet_velocity
				b3.gravity = gravity
				shot = true
				b3.connect("damage2", self, "_on_bullet3_hit")
				b3.connect("damage1", player1, "_on_bullet3_hit")
#B4
			elif bullet == 4:
				var b4 = Bullet4.instance()
				get_parent().call_deferred("add_child", b4)
				b4.transform = $RotPoint/ShootPoint.global_transform
				b4.velocity = b4.transform.x * bullet_velocity
				b4.gravity = gravity
				shot = true
				b4.connect("damage2", self, "_on_bullet4_hit")
				b4.connect("damage1", player1, "_on_bullet4_hit")
#B5
			elif bullet == 5:
				var b5 = Bullet5.instance()
				get_parent().call_deferred("add_child", b5)
				b5.transform = $RotPoint/ShootPoint.global_transform
				b5.velocity = b5.transform.x * bullet_velocity
				b5.gravity = gravity
				shot = true
				b5.connect("damage2", self, "_on_bullet5_hit")
				b5.connect("damage1", player1, "_on_bullet5_hit")
#B6
			elif bullet == 6:
				var b6 = Bullet6.instance()
				get_parent().call_deferred("add_child", b6)
				b6.transform = $RotPoint/ShootPoint.global_transform
				b6.velocity = b6.transform.x * bullet_velocity
				b6.gravity = gravity
				shot = true
				b6.connect("damage2", self, "_on_bullet6_hit")
				b6.connect("damage1", player1, "_on_bullet6_hit")
#B1
			else:
				bullet == 1
				var b1 = Bullet1.instance()
				get_parent().call_deferred("add_child", b1)
				b1.transform = $RotPoint/ShootPoint.global_transform
				b1.velocity = b1.transform.x * bullet_velocity
				b1.gravity = gravity
				shot = true
				b1.connect("damage2", self, "_on_bullet1_hit")
				b1.connect("damage1", player1, "_on_bullet1_hit")

func _on_bullet1_hit():
	take_damage(10)

func _on_bullet2_hit():
	take_damage(20)

func _on_bullet3_hit():
	take_damage(30)

func _on_bullet4_hit():
	take_damage(100)

func _on_bullet5_hit():
	for i in 10:
		take_damage(6)
		yield(get_tree().create_timer(0.1), "timeout")

func _on_bullet6_hit():
	take_damage(45)

func _on_UI_gui_input(event):
# Click and drag mouse function:
	if go:
		if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
			$RotPoint.look_at(get_global_mouse_position())
			$RotPoint.rotation_degrees = clamp($RotPoint.rotation_degrees, barrel_minrot, barrel_maxrot)
			pressed = !pressed
		
		if event is InputEventMouseMotion:
			if pressed:
				$RotPoint.look_at(get_global_mouse_position())
				$RotPoint.rotation_degrees = clamp($RotPoint.rotation_degrees, barrel_minrot, barrel_maxrot)
