extends TextureRect

var game_state: Enums.GameState = Enums.GameState.O_TURN
signal game_state_updated(old_game_state: Enums.GameState, new_game_state: Enums.GameState)

func update_game_state(new_game_state) -> void:
	var old_game_state = game_state
	game_state = new_game_state
	game_state_updated.emit(old_game_state, new_game_state)

func _ready() -> void:
	# Ensure the material is unique to this instance
	material = material.duplicate()
	update_game_state(game_state)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if get_global_rect().has_point(event.global_position):
			progressGame(event.global_position)

func progressGame(pos: Vector2) -> void:
	var grid_size = material.get_shader_parameter("grid_size")
	var o_mask = material.get_shader_parameter("o_mask")
	var x_mask = material.get_shader_parameter("x_mask")
	
	var uv = get_uv(pos)
	var grid_pos = get_grid_pos(uv, grid_size)
	var pos_mask = pos_to_mask(grid_pos, grid_size)

	var board_mask = o_mask | x_mask
	if (board_mask & pos_mask) != 0:
		return

	if game_state == Enums.GameState.O_TURN:
		o_mask |= pos_mask
	if game_state == Enums.GameState.X_TURN:
		x_mask |= pos_mask
	
	process_game(x_mask, o_mask, grid_size)

func process_game(x_mask: int, o_mask: int, grid_size: float):
	material.set_shader_parameter("x_mask", x_mask)
	material.set_shader_parameter("o_mask", o_mask)
	update_game_state(get_game_state(x_mask, o_mask, int(grid_size)))

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
	for _i in range(grid_size - 1):
		vertical_mask <<= grid_size
		vertical_mask |= 1

	for _i in range(grid_size):
		if (mask & vertical_mask) == vertical_mask:
			return true
		vertical_mask <<= 1
	
	var forward_diagonal_mask = 0
	for i in range(grid_size):
		forward_diagonal_mask |= (1 << (i + (i * grid_size)))
	
	if (mask & forward_diagonal_mask) == forward_diagonal_mask:
		return true
	
	var back_diagonal_mask = 0
	for i in range(grid_size):
		back_diagonal_mask |= (1 << ((grid_size - 1 - i) + (grid_size * i)))
	
	if (mask & back_diagonal_mask) == back_diagonal_mask:
		return true
	
	return false

func get_game_state(x: int, o: int, grid_size: int) -> Enums.GameState:
	if has_won(x, grid_size):
		return Enums.GameState.X_WON
	if has_won(o, grid_size):
		return Enums.GameState.O_WON
	
	var board = x | o
	var filled = (1 << (grid_size * grid_size)) - 1
	if board == filled:
		return Enums.GameState.TIE

	if game_state == Enums.GameState.X_TURN:
		return Enums.GameState.O_TURN
	elif game_state == Enums.GameState.O_TURN:
		return Enums.GameState.X_TURN

	push_error("Invalid game state detected")
	return Enums.GameState.O_TURN

func bin_string(n: int, l: int = 0) -> void:
	var ret_str = ""
	
	# Special case for zero
	if n == 0:
		ret_str = "0"
	
	# Convert the integer to a binary string
	while n > 0:
		ret_str = str(n & 1) + ret_str
		n = n >> 1
	
	# Pad with leading zeros if needed
	if l > 0:
		var padding_length = l - ret_str.length()
		if padding_length > 0:
			# Create a string of '0' with the required length
			var padding_str = ""
			for i in range(padding_length):
				padding_str += "0"
			ret_str = padding_str + ret_str
	
	print(ret_str)

func reset():
	material.set_shader_parameter("o_mask", 0)
	material.set_shader_parameter("x_mask", 0)
	update_game_state(Enums.GameState.O_TURN)

func get_random(mask: int, size: int) -> int:
	var placement = 1 << randi_range(0, size - 1)
	if mask | placement == mask:
		return get_random(mask, size)
	return placement

func in_play() -> bool:
	return game_state == Enums.GameState.X_TURN || game_state == Enums.GameState.O_TURN

func help():
	if !in_play():
		return
	var grid_size = material.get_shader_parameter("grid_size")
	var o_mask = material.get_shader_parameter("o_mask")
	var x_mask = material.get_shader_parameter("x_mask")
	
	var random_placement = get_random(o_mask | x_mask, int(grid_size * grid_size))
	
	if game_state == Enums.GameState.X_TURN:
		x_mask |= random_placement
	elif game_state == Enums.GameState.O_TURN:
		o_mask |= random_placement
	process_game(x_mask, o_mask, grid_size)

func _on_help_button_down():
	help()


func _on_reset_button_down():
	reset()
