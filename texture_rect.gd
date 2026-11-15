extends TextureRect

func _on_area_2d_body_entered(body: Node2D) -> void:
	# Restart the game if either Player or PlayerBeta touches this TextureRect
	if body.name == "Player" or body.name == "PlayerBeta":
		get_tree().call_deferred("reload_current_scene")
