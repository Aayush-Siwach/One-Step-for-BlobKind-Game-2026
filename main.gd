extends Node2D

@export var respawn_position_Player: Vector2 = Vector2(338, 621)
@export var respawn_position_PlayerBeta: Vector2 = Vector2(125, 480)
var time_count = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_count += delta
	$Timer/TimerDisplay.text = "Time: %d" % time_count


func _on_icon_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
