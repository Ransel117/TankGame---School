extends Control

export var SFXVol = 100
export var MusicVol = 100

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_SFXSlider_value_changed(value):
	SFXVol = value


func _on_MusicSlider_value_changed(value1):
	MusicVol = value1
