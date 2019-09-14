extends TileMap

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var required_wall = {0: "four_side_wall", 1: "three_side_wall", 2:"two_side_wall", 3: "one_side_wall", 4: "inner_wall"}
var relative_positions = [Vector2(1,0), Vector2(-1,0), Vector2(0,1), Vector2(0,-1)]
# Called when the node enters the scene tree for the first time.
func _ready():
	replace_walls()
				

func replace_walls():
	var wall_id : int = self.tile_set.find_tile_by_name("Wall")
	var walls : Array = get_used_cells_by_id(wall_id)
	for wall in walls:
		var adjacent_walls : Array = adjacent_walls(wall)
		self.call("replace_with_" + required_wall.get(adjacent_walls.size()), wall, adjacent_walls)
	
		
func replace_with_four_side_wall(wall : Vector2, adjacent_walls : Array):
	var four_side_id = self.tile_set.find_tile_by_name("FourSideWall")
	self.set_cellv(wall, four_side_id)
		
func replace_with_inner_wall(wall : Vector2, adjacent_walls : Array):
	var inner_id = self.tile_set.find_tile_by_name("InnerWall")
	self.set_cellv(wall, inner_id)
	
func replace_with_one_side_wall(wall : Vector2, adjacent_walls : Array):
	var rotation_direction = $ArrayHelper.minus(relative_positions, adjacent_walls)
	rotation_direction = rotation_direction.front()
	apply_rotations(wall, required_rotations(rotation_direction), "OneSideWall")
	
func replace_with_three_side_wall(wall : Vector2, adjacent_walls : Array):
	var rotation_direction : Vector2 = adjacent_walls.front()
	apply_rotations(wall, required_rotations(rotation_direction), "ThreeSideWall")
	
func replace_with_two_side_wall(wall : Vector2, adjacent_walls : Array):
	if !adjacent_walls.front() == adjacent_walls.back() * -1:
		replace_with_corner_wall(wall, adjacent_walls)
	else:
		var rotation_direction : Vector2 = adjacent_walls.front()
		apply_rotations(wall, required_rotations(rotation_direction), "TwoSideWall")
		
func replace_with_corner_wall(wall : Vector2, adjacent_walls : Array):
	var rotation_direction : Vector2 = adjacent_walls.back()
	apply_rotations(wall, required_rotations_corner(adjacent_walls), "CornerWall")

func required_rotations(rotation_direction : Vector2) -> int: #function assumes that the default rotation is down
	if rotation_direction == Vector2(0, 1):
		return 0	
	if rotation_direction == Vector2(-1, 0):
		return 1
	if rotation_direction == Vector2(0, -1):
		return 2
	if rotation_direction == Vector2(1, 0):
		return 3
	return -1
	
func required_rotations_corner(rotation_directions : Array) -> int:
	if rotation_directions.has(Vector2(0, -1)):
		if rotation_directions.has(Vector2(1, 0)):
			return 0
		else:
			return 3
	else:
		if rotation_directions.has(Vector2(1, 0)):
			return 1
		else:
			return 2
	return -1

func apply_rotations(wall : Vector2, rotations : int, wall_type : String): #rotations applied clockwise
	var one_side_id = self.tile_set.find_tile_by_name(wall_type)
	if rotations == 0:
		self.set_cellv(wall, one_side_id, false, false, false)
	if rotations == 1: 
		self.set_cellv(wall, one_side_id, true, false, true)
	if rotations == 2: 
		self.set_cellv(wall, one_side_id, true, true, false)
	if rotations == 3: 
		self.set_cellv(wall, one_side_id, false, true, true)
	
func adjacent_walls(wall : Vector2) -> Array:
	var adjacent_walls : Array = []
	for relative_position in relative_positions:
		if is_wall(wall + relative_position):
			adjacent_walls.append(relative_position)
	return adjacent_walls
	
	
	
func is_wall(cell : Vector2) -> bool:
	var cell_name = self.tile_set.tile_get_name(self.get_cellv(cell))
	return "Wall" in cell_name
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
