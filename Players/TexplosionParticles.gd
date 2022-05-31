extends Particles2D

signal ded

func _ready() -> void:
		emitting = true
		$DirtParticles.emitting = true
		$Timer.start($DirtParticles.lifetime * $DirtParticles.speed_scale)

func _on_Timer_timeout() -> void:
	call_deferred("queue_free")
	emit_signal("ded")
