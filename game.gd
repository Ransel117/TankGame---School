extends Node2D

export var eTurn = false

onready var pline = $Line2D1
onready var eline = $Line2D2
onready var Player1 = $Player1
onready var Player2 = $Player2

var max_points = 2000
var WWCD = 0 # Winner Winner Chicken Dinner

func _process(delta):
	textshit()
#	Checks if menu is open and if any player is dead
	if get_child(6).get_child(0).visible:
		Player1.set_physics_process(false)
		Player2.set_physics_process(false)
	else:
		Player1.set_physics_process(true)
		Player2.set_physics_process(true)
	if Player1.Phealth != 0 and Player2.Ehealth != 0:
		if eTurn:
			pline.hide()
			eline.show()
			$UI/Inventory/Player1/Weaponctrl/ActionPanel/Button.disabled = true
			$UI/Inventory/Player2/Weaponctrl/ActionPanel/Button.disabled = false
		else:
			pline.show()
			eline.hide()
			$UI/Inventory/Player1/Weaponctrl/ActionPanel/Button.disabled = false
			$UI/Inventory/Player2/Weaponctrl/ActionPanel/Button.disabled = true
	else:
		if Player1.Phealth == 0:
			WWCD = 2
			Player2.set_physics_process(false)
			yield(get_tree().create_timer(0.5), "timeout")
			Player1.set_physics_process(false)
		else:
			WWCD = 1
			Player1.set_physics_process(false)
			yield(get_tree().create_timer(0.5), "timeout")
			Player2.set_physics_process(false)
		pline.hide()
		eline.hide()
		$ShootTimer.stop()

# Sets text of labels
func textshit():
	$UI/Inventory/Panel/Label.text = str(ceil($ShootTimer.time_left))

	$UI/Inventory/Player1/Weaponctrl/ActionPanel/Fuelvalue.text = str(Player1.Pfuel)
	$UI/Inventory/Player1/HealthPanel/Healthbar.value = Player1.Phealth
	$UI/Inventory/Player1/HealthPanel/Healthvalue.text = str(Player1.Phealth) + "/" + str(Player1.Fhealth)

	$UI/Inventory/Player2/Weaponctrl/ActionPanel/Fuelvalue.text = str(Player2.Efuel)
	$UI/Inventory/Player2/HealthPanel/Healthbar.value = Player2.Ehealth
	$UI/Inventory/Player2/HealthPanel/Healthvalue.text = str(Player2.Ehealth) + "/" + str(Player2.Fhealth)


func _physics_process(delta: float) -> void:
	update_trajectory(delta)

# Gets the trajectory of the bullet
func update_trajectory(delta):
	if eTurn:
		eline.clear_points()
		var pos2 = $Player2/RotPoint/ShootPoint.global_position
		var vel2 = $Player2/RotPoint/ShootPoint.global_transform.x * Player2.bullet_velocity
		for i in max_points:
			eline.add_point(pos2)
			vel2.y += Player2.gravity * delta
			pos2 += vel2 * delta
			if Geometry.is_point_in_polygon($Terrain/Polygon2D.to_local(pos2), $Terrain/Polygon2D.polygon):
				break
	else:
		pline.clear_points()
		var pos1 = $Player1/RotPoint/ShootPoint.global_position
		var vel1 = $Player1/RotPoint/ShootPoint.global_transform.x * Player1.bullet_velocity
		for i in max_points:
			pline.add_point(pos1)
			vel1.y += Player1.gravity * delta
			pos1 += vel1 * delta
			if Geometry.is_point_in_polygon($Terrain/Polygon2D.to_local(pos1), $Terrain/Polygon2D.polygon):
				break

# Turns
func _on_Timer_timeout():
	eTurn = !eTurn
