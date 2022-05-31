extends Node2D

var width = 2048

#Generates the world terrain
func map_draw():
	var poly = $Polygon2D
	var points = PoolVector2Array()
	var baseRect = PoolVector2Array()
	var lastPos = Vector2(0,600)
	
#	Makes sure that the arrays is empty before generating new terrain
	points.empty()
	baseRect.empty()
	
	randomize()
	var rndDist = ceil(rand_range(16,32))
	var rndChange = ceil(rand_range(-1,1))
	
	var topR = Vector2(2048, 600 + rndChange)
	var btmR = Vector2(2048, 1200 + rndChange)
	var btmL = Vector2(0, 1200 + rndChange)
	var topL = Vector2(0, 600 + rndChange)
	
#	Puts a base rectangle in the terrain
	baseRect.push_back(topR)
	baseRect.push_back(btmR)
	baseRect.push_back(btmL)
	baseRect.push_back(topL)

	points.append_array(baseRect)
	
	for x in width/rndDist:
		var rndHeight = ceil(rand_range(-rndDist, rndDist))
		var newPos = Vector2(lastPos.x + rndDist, lastPos.y + rndHeight)
		lastPos = newPos
		points.push_back(newPos)
		
	poly.set_polygon(points)
	poly.set_deferred("polygon", points)
	$Destructible/CollisionPolygon2D.polygon = $Polygon2D.polygon
	update()

func _ready() -> void:
	map_draw()
	update()

#Makes the 
func clip(poly):
	var offset_poly = Polygon2D.new()
	
	# Transform the polygon values to take into account the transform
	offset_poly.polygon = poly.global_transform.xform(poly.polygon)
	var res = Geometry.clip_polygons_2d($Polygon2D.polygon, offset_poly.polygon)

	$Polygon2D.polygon = res[0]
	$Destructible/CollisionPolygon2D.set_deferred("polygon", res[0])

#	Free the polygon to avoid memory leak
	offset_poly.call_deferred("queue_free")

#Moves the terrain down when generating a new map so players don't get stuck
func posChange():
	var Pos = 18
	
	for i in Pos:
		$Polygon2D.global_position += Vector2(0, 20)
		$Destructible.global_position += Vector2(0, 20)
		yield(get_tree().create_timer(0.02), "timeout")

	map_draw()

	for k in Pos*2:
		$Polygon2D.global_position -= Vector2(0, 10)
		$Destructible.global_position -= Vector2(0, 10)
		yield(get_tree().create_timer(0.02), "timeout")

#Moves terrain down and back up when regenerating map
func _on_NewMap_timeout():
	posChange()
