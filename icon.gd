extends Area2D

func _physics_process(_delta: float) -> void:
	# Check every physics body currently touching Icon
	for body in get_overlapping_bodies():
		if body.name == "Player" or body.name == "PlayerBeta":
			get_tree().quit()
