extends Camera2D

@export var Player: Node2D
@export var PlayerBeta: Node2D

@export var move_speed: float = 5.0
@export var zoom_speed: float = 10.0
@export var min_zoom: float = 1.4
@export var max_zoom: float = 1.7

@export var margin: Vector2 = Vector2(300, 500)

func _ready() -> void:
	enabled = true
	if not Player:
		Player = get_parent().find_child("Player", true, false)
	if not PlayerBeta:
		PlayerBeta = get_parent().find_child("PlayerBeta", true, false)

func _process(delta: float) -> void:
	if not Player or not PlayerBeta:
		return

	var midpoint = (Player.global_position + PlayerBeta.global_position) * 0.5
	global_position = global_position.lerp(midpoint, move_speed * delta)

	var screen_size = get_viewport_rect().size
	var distance = (Player.global_position - PlayerBeta.global_position).abs() + margin

	var zoom_x = screen_size.x / max(distance.x, 2.0)
	var zoom_y = screen_size.y / max(distance.y, 2.0)
	var target_zoom_val = clamp(min(zoom_x, zoom_y), min_zoom, max_zoom)

	var target_zoom = Vector2(target_zoom_val, target_zoom_val)
	zoom = zoom.lerp(target_zoom, zoom_speed * delta)
