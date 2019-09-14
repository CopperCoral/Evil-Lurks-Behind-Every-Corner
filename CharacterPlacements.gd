extends TileMap

# Declare member variables here. Examples:
# var a = 2
# var b = "te"
#const player = preload("res://Player.tscn")
signal position_determined


# Called when the node enters the scene tree for the first time.
func _ready():
	var tile_ids : Array = self.tile_set.get_tiles_ids()
	for tile_id in tile_ids:
		var tile_name : String = self.tile_set.tile_get_name(tile_id)
		var positions_on_grid = self.get_used_cells_by_id(tile_id)
		var thing : PackedScene = load("res://" + tile_name + ".tscn")
		for position_on_grid in positions_on_grid:
			var position_on_world = self.map_to_world(position_on_grid)
			emit_signal("position_determined", thing, position_on_world)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
