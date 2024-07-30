shader_type canvas_item;

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
