extends TileMapLayer

# Drag your Player and PlayerBeta nodes into these slots in the Inspector,
# or leave them as-is if they are siblings of this TileMapLayer in the Scene tree
@onready var player1: Node2D = get_parent().get_node_or_null("Player")
@onready var player2: Node2D = get_parent().get_node_or_null("PlayerBeta")

# Replace Vector2i(0, 0) with the grid coordinate (column, row) of your lethal tile in your tileset image!
# For example: top-left tile is (0, 0), second tile to the right is (1, 0), second row first tile is (0, 1)
@export var lethal_tile_coords: Vector2i = Vector2i(0, 0)

func _physics_process(_delta: float) -> void:
	check_player(player1)
	check_player(player2)

func check_player(player: Node2D) -> void:
	if player == null:
		return
		
	# Convert the player's world position into the tile grid coordinate
	var local_pos: Vector2 = to_local(player.global_position)
	var cell_coords: Vector2i = local_to_map(local_pos)
	
	# Check if the tile type at the player's position matches your lethal tile type
	if get_cell_atlas_coords(cell_coords) == lethal_tile_coords:
		get_tree().call_deferred("reload_current_scene")
