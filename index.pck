GDPC                                                                                          d   res://.godot/exported/133200997/export-40e5d3704c1a7c5b24b090a7298450b9-O_player_button_group.res   P5            L�!��}�oh�EƩ    P   res://.godot/exported/133200997/export-6455994a605b35b7d96f8362f3055c4a-Game.scn�            ��7r�t���[^��    d   res://.godot/exported/133200997/export-f14a9173213e452c537e2b290beff082-X_player_button_group.res   �7            ��S8�r�U.�w��O    ,   res://.godot/global_script_class_cache.cfg  P:      �       b�
A�y�mN�t��    D   res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex�3      �       jCQ�h%�ֈJ�.C�       res://.godot/uid_cache.bin  �<      �       �ZE���c���yoh-�       res://AI.gd         [      gV���=�����       res://Enums.gd  0      �       ���?=�l1]&E1��v       res://Game.tscn.remap   �8      a       ����:w�W�0[��+J    (   res://O_player_button_group.tres.remap  P9      r       8N�s�B��� ����F       res://RichTextLabel.gd  `6      o      "��5�'�c@f�!c�    (   res://X_player_button_group.tres.remap  �9      r       �P��+������       res://background.gdshader   `      �       u���&O@v�J�Зb       res://gameboard.gd  �      $      ��LFTcV�,�+����       res://gameboard.gdshader (      �      �e�Lm�ׅ�̎�%�       res://icon.svg  �:      �      @K�qOe?{숝�_�       res://icon.svg.import   �4      �       ����U[�w��1*�&��       res://project.binary`=      �      ���r��$�^RJ���            extends Node2D


signal player_type_updated(player: Enums.Player, player_type: Enums.PlayerType)


func _on_human_x_button_toggled(toggled_on):
	if toggled_on:
		player_type_updated.emit(Enums.Player.X, Enums.PlayerType.HUMAN)


func _on_aix_button_toggled(toggled_on):
	if toggled_on:
		player_type_updated.emit(Enums.Player.X, Enums.PlayerType.AI)


func _on_human_o_button_toggled(toggled_on):
	if toggled_on:
		player_type_updated.emit(Enums.Player.O, Enums.PlayerType.HUMAN)


func _on_aio_button_toggled(toggled_on):
	if toggled_on:
		player_type_updated.emit(Enums.Player.O, Enums.PlayerType.AI)
     shader_type canvas_item;

void fragment() {
    float color_value = abs(cos(TIME * 0.005)) / 2.0 + 0.5; // Pulsating color
    COLOR = vec4(color_value * UV.x, color_value * UV.y, 0.5, 1.0);
}
               class_name Enums
enum GameState {
	O_WON,
	X_WON,
	TIE,
	X_TURN,
	O_TURN,
}

enum Player {
	X,
	O,
}

enum PlayerType {
	HUMAN,
	AI,
}
         RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name    shader    script    diffuse_texture    normal_texture    specular_texture    specular_color    specular_shininess    texture_filter    texture_repeat    allow_unpress 	   _bundled       Shader    res://background.gdshader ��������   Shader    res://gameboard.gdshader ��������   Script    res://gameboard.gd ��������   Script    res://RichTextLabel.gd ��������   Script    res://AI.gd ��������      local://ShaderMaterial_xmc81 +         local://CanvasTexture_50lf1 Z         local://ShaderMaterial_ca6b2 x         local://ButtonGroup_ukkp4 �         local://ButtonGroup_0ie5f �         local://PackedScene_nqv4b �         ShaderMaterial                          CanvasTexture             ShaderMaterial                         ButtonGroup             ButtonGroup             PackedScene          	         names "   #      Node2D    background 	   material    offset_left    offset_top    offset_right    offset_bottom    texture    TextureRect 
   gameboard    script    RichTextLabel    text    ResetButton    Button 	   position    HumanXButton    toggle_mode    button_pressed    button_group 
   AIXButton    HumanOButton 
   AIOButton    RichTextLabel2 !   _on_gameboard_game_state_updated    game_state_updated    _on_reset_button_down    button_down     _on_node_2d_player_type_updated    player_type_updated    _on_human_x_button_toggled    toggled    _on_aix_button_toggled    _on_human_o_button_toggled    _on_aio_button_toggled    	   variants    4                  P�     �@     �D    @#D                       �B     C      D    �D             @AD     �B     `D     �B      Game starting              �SD     �C    @rD    ��C      Reset 
    �]D  �C              ��     B     x�     C                     Human      l�     ��      AI      HB     B     �B     C              �B     .C     ��     �?     ��     $B   	   Player X      �B     `�     %C     �A   	   Player O       node_count             nodes     �   ��������        ����                      ����                                                       	   ����                        	      
         
                        ����                                 
                        ����                                                     ����         
                       ����                                                                    ����                   !                        "                    ����      #      $      %      &                  '                          ����      (      $      )      &            '      "                    ����      *      +      ,      -      .                    ����      /      0      1      2      3             conn_count             conns     M                                                                                                                                                                               !                 	      !              	         "              	         "                    node_paths              editable_instances              version             RSRC               extends TextureRect

var player_o: Enums.PlayerType = Enums.PlayerType.HUMAN
var player_x: Enums.PlayerType = Enums.PlayerType.HUMAN

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
	if game_state == Enums.GameState.X_TURN && player_x == Enums.PlayerType.AI:
		return
	if game_state == Enums.GameState.O_TURN && player_o == Enums.PlayerType.AI:
		return

	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if get_global_rect().has_point(event.global_position):
			progress_human_input(event.global_position)

func _process(_delta):
	if game_state == Enums.GameState.X_TURN && player_x == Enums.PlayerType.AI:
		ai()
		return
	if game_state == Enums.GameState.O_TURN && player_o == Enums.PlayerType.AI:
		ai()
		return

	if !in_play() && player_x == Enums.PlayerType.AI && player_o == Enums.PlayerType.AI:
		reset()

func progress_human_input(pos: Vector2) -> void:
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

func get_random(mask: int, mask_size: int) -> int:
	var placement = 1 << randi_range(0, mask_size - 1)
	if mask | placement == mask:
		return get_random(mask, mask_size)
	return placement

func in_play() -> bool:
	return game_state == Enums.GameState.X_TURN || game_state == Enums.GameState.O_TURN

func ai():
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


func _on_reset_button_down():
	reset()


func _on_node_2d_player_type_updated(player: Enums.Player, player_type: Enums.PlayerType):
	match player:
		Enums.Player.X:
			player_x = player_type
		Enums.Player.O:
			player_o = player_type
            shader_type canvas_item;

uniform float line_thickness = 0.05; // Thickness of the lines
uniform vec4 line_color = vec4(0.0, 0.0, 0.0, 1.0); // Color of the lines
uniform vec4 background = vec4(1.0, 1.0, 1.0, 1.0); // Color of the background
uniform vec4 x_color = vec4(1.0, 0.0, 0.0, 1.0); // Color of Xs
uniform vec4 o_color = vec4(0.0, 0.0, 1.0, 1.0); // Color of Os
uniform float grid_size = 3.0;

uniform bool is_clicked = false;

uniform int o_mask = 0;
uniform int x_mask = 0;

void translate_pos(vec2 uv, inout vec2 pos) {
	pos.x += 0.5;
	pos.y += 0.5;

	pos.x /= grid_size;
	pos.y /= grid_size;
	
	pos.x = uv.x - pos.x;
	pos.y = uv.y - pos.y;
}

bool is_circle(vec2 uv, vec2 pos) {
	float circle_size = 0.00002518629 + (1.168574 - 0.00002518629)/(1.0 + pow((grid_size/0.4903008),2.213454));
	float circle_thickness = (37764.0)/(1.0 + pow((grid_size/0.0002911425),1.8));
	
	translate_pos(uv, pos);

	bool outer_circle = abs((pos.y * pos.y) + (pos.x * pos.x)) < circle_size;
	bool inner_circle = abs((pos.y * pos.y) + (pos.x * pos.x)) > circle_size - circle_thickness;

	return outer_circle && inner_circle;
}

bool is_cross(vec2 uv, vec2 pos) {
	translate_pos(uv, pos);
	float cross_thickness = 0.01;

	float bottom = -0.45 / grid_size;
	float top = 0.45 / grid_size;
	float left = -0.45 / grid_size;
	float right = 0.45 / grid_size;

	bool in_bounds = pos.y > bottom && pos.y < top && pos.x > left && pos.x < right;

	bool forward_slash_top = pos.y + pos.x > -cross_thickness;
	bool forward_slash_bottom = pos.y + pos.x < cross_thickness;

	bool forward_slash = forward_slash_bottom && forward_slash_top;

	bool back_slash_top = pos.y - pos.x > -cross_thickness;
	bool back_slash_bottom = pos.y - pos.x < cross_thickness;

	bool back_slash = back_slash_bottom && back_slash_top;

	return (forward_slash || back_slash) && in_bounds;
}

bool check_pos_in_mask(vec2 pos, int marksMask) {
	int posMask = 1 << int(pos.y) * int(grid_size) + int(pos.x);
	return (marksMask & posMask) != 0;
}

void fragment() {
	// Default background color
	vec4 color = background;

	float offset = line_thickness / (grid_size * 2.0);
	// Create the grid lines
	float horizontal_line = abs(mod((UV.y + offset) * grid_size, 1.0)) < line_thickness ? 1.0 : 0.0;
	float vertical_line = abs(mod((UV.x + offset) * grid_size, 1.0)) < line_thickness ? 1.0 : 0.0;

	// Draw grid lines
	float grid = max(horizontal_line, vertical_line);
	
	if (grid > 0.0) {
		color = line_color; // Grid lines color
	}

	for (float i = 0.0; i < grid_size; i += 1.0) {
		for (float j = 0.0; j < grid_size; j += 1.0) {
			if (check_pos_in_mask(vec2(i,j), o_mask) && is_circle(UV, vec2(i, j))) {
				color = vec4(0.5, 1.0, 0.0, 1.0);
			}
		}
	}

	for (float i = 0.0; i < grid_size; i += 1.0) {
		for (float j = 0.0; j < grid_size; j += 1.0) {
			if (check_pos_in_mask(vec2(i,j), x_mask) && is_cross(UV, vec2(i, j))) {
				color = vec4(1.0, 0.5, 0.0, 1.0);
			}
		}
	}


	COLOR = color;
}
              GST2   d   d      ����               d d        �   RIFF�   WEBPVP8L�   /c���H��|<�8�A��Y��������g������y��Pa� �'5�'�m�:Ii}~����>�$�� Q��y�\�x �� �)��>q��:�6ɬ�Q��x�i�^�'Jr�d�d��S� xu �1%z�g�dVI�\�>�w���w>9 ����y�M�   [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://c20cmp88onb1k"
path="res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex"
metadata={
"vram_texture": false
}
                RSRC                    ButtonGroup            ��������                                                  resource_local_to_scene    resource_name    allow_unpress    script           local://ButtonGroup_bm8de �          ButtonGroup          RSRC           extends RichTextLabel

const GameState = Enums.GameState
const texts = {
	GameState.O_WON: "O Won",
	GameState.X_WON: "X Won",
	GameState.O_TURN: "O's Turn",
	GameState.X_TURN: "X's Turn",
	GameState.TIE: "It's a Tie!",
}

func _on_gameboard_game_state_updated(_old_game_state: Enums.GameState, new_game_state: Enums.GameState) -> void:
	text = texts[new_game_state]
 RSRC                    ButtonGroup            ��������                                                  resource_local_to_scene    resource_name    allow_unpress    script           local://ButtonGroup_22m2p �          ButtonGroup          RSRC           [remap]

path="res://.godot/exported/133200997/export-6455994a605b35b7d96f8362f3055c4a-Game.scn"
               [remap]

path="res://.godot/exported/133200997/export-40e5d3704c1a7c5b24b090a7298450b9-O_player_button_group.res"
              [remap]

path="res://.godot/exported/133200997/export-f14a9173213e452c537e2b290beff082-X_player_button_group.res"
              list=Array[Dictionary]([{
"base": &"RefCounted",
"class": &"Enums",
"icon": "",
"language": &"GDScript",
"path": "res://Enums.gd"
}])
          <svg width="100" height="100" xmlns="http://www.w3.org/2000/svg">
    <rect x="10" y="10" width="80" height="80" fill="white"/>
    <line x1="33.33" y1="10" x2="33.33" y2="90" stroke="black" stroke-width="4"/>
    <line x1="66.67" y1="10" x2="66.67" y2="90" stroke="black" stroke-width="4"/>
    <line x1="10" y1="33.33" x2="90" y2="33.33" stroke="black" stroke-width="4"/>
    <line x1="10" y1="66.67" x2="90" y2="66.67" stroke="black" stroke-width="4"/>
  </svg>
                  J{Ձ�@0K   res://Game.tscn�6,�r%A]   res://icon.svgG\���9"    res://O_player_button_group.tres8!f���fU    res://X_player_button_group.tres               ECFG      application/config/name      	   tictactoe      application/run/main_scene         res://Game.tscn    application/config/features(   "         4.2    GL Compatibility       application/config/icon         res://icon.svg     display/window/size/resizable             dotnet/project/assembly_name      	   tictactoe   #   rendering/renderer/rendering_method         gl_compatibility*   rendering/renderer/rendering_method.mobile         gl_compatibility       