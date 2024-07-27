extends TextureRect

var o_turn = true

func _ready() -> void:
	# Ensure the material is unique to this instance
	material = material.duplicate()

func _input(event: InputEvent) -> void:
	
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		# Check if the click is within the Sprite's bounds
		if get_global_rect().has_point(event.global_position):
			# Toggle the `is_clicked` uniform
			getPos(event.global_position)
		

func getPos(pos: Vector2) -> void:
	var grid_size = material.get_shader_parameter("grid_size")
	var o_mask = material.get_shader_parameter("o_mask")
	var x_mask = material.get_shader_parameter("x_mask")
	var board_mask = o_mask | x_mask
	
	var uv = get_uv(pos)
	var grid_pos = get_grid_pos(uv, grid_size)
	var pos_mask = pos_to_mask(grid_pos, grid_size)

	if (board_mask & pos_mask) != 0:
		return

	if o_turn:
		o_mask |= pos_mask
		material.set_shader_parameter("o_mask", o_mask)
	else:
		x_mask |= pos_mask
		material.set_shader_parameter("x_mask", x_mask)
	
	o_turn = !o_turn
	
	check_game(x_mask, o_mask, int(grid_size))

# Function to get the UV coordinates
func get_uv(mouse_pos: Vector2) -> Vector2:
	if get_rect().has_point(mouse_pos):
		var uv_x = (mouse_pos.x - position.x) / size.x
		var uv_y = (mouse_pos.y - position.y) / size.y
		return Vector2(uv_x, uv_y)
	return Vector2()

func get_grid_pos(pos: Vector2, grid_size: float) -> Vector2:
	return Vector2(
		floor(pos.x * grid_size),
		floor(pos.y * grid_size),
	)

func pos_to_mask(pos: Vector2, grid_size: int) -> int:
	return 1 << int(pos.y) * grid_size + int(pos.x)

func has_won(mask: int, grid_size: int) -> bool:
	var horizontal_mask = (1 << grid_size) - 1
	for _i in range(grid_size):
		if (mask & horizontal_mask) == horizontal_mask:
			return true
		horizontal_mask <<= grid_size
		
	var vertical_mask = 1
	for _i in range(grid_size):
		vertical_mask <<= 2
		vertical_mask |= 1
		
	print(bin_string(vertical_mask))
	for _i in range(grid_size):
		if (mask & vertical_mask) == vertical_mask:
			return true
		vertical_mask <<= grid_size
	return false

func check_game(x: int, o: int, grid_size: int) -> void:
	if has_won(x, grid_size):
		print("X WON!!")
		return
	if has_won(o, grid_size):
		print("O WON!!")
		return
	
	var board = x | o
	var filled = (1 << (grid_size * grid_size)) - 1
	if board == filled:
		print("TIE!!")
		return
		
func bin_string(n: int) -> String:    
	var ret_str = ""
	while n > 0:
		ret_str = "{0}{1}".format([n&1, ret_str])
		n = n>>1
	return ret_str
