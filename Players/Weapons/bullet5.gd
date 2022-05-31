extends Node2D

signal damage1
signal damage2

export var particles: PackedScene = preload("res://Players/explosionParticles.tscn")
export var radius = 100
export var explosion_force = 350

var velocity := Vector2.ZERO
var gravity := 0

var collider = null

var affected = []

func _ready() -> void:
	randomize()
	var nb_points = 32
	var points = PoolVector2Array()
	for i in range(nb_points+1):
		var point = deg2rad(i * 360 / nb_points - 90)
		points.push_back(Vector2.ZERO + Vector2(cos(point), sin(point)) * radius)
	$Area2D/DestructionPolygon.polygon = points
	
func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	position += velocity * delta
	rotation = velocity.angle()
	
func explode() -> void:
	for x in affected:
		x.apply_central_impulse((x.global_position - global_position).normalized() * explosion_force)
	var inst = particles.instance()
	inst.global_position = global_position
	get_parent().call_deferred("add_child", inst)
	
	if collider.is_in_group("Destructibles"):
		collider.get_parent().clip($Area2D/DestructionPolygon)
	
	call_deferred("queue_free")
	
func _on_CollisionDetection_body_entered(body: Node) -> void:
	collider = body
	if body.is_in_group("Player"):
		print(body.name)
		if body.name == "Player1":
			emit_signal("damage1")
		if body.name == "Player2":
			emit_signal("damage2")
	explode()
