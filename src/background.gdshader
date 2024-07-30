shader_type canvas_item;

void fragment() {
    float color_value = abs(cos(TIME * 0.005)) / 2.0 + 0.5; // Pulsating color
    COLOR = vec4(color_value * UV.x, color_value * UV.y, 0.5, 1.0);
}
