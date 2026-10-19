shader_type canvas_item;

uniform vec4 outline_color : source_color = vec4(1.0, 0.85, 0.3, 1.0);
uniform float outline_width : hint_range(0.0, 20.0) = 4.0;
uniform float glow_strength : hint_range(0.0, 3.0) = 1.5;
uniform float pulse_speed = 5.0;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec4 base = texture(TEXTURE, UV);
	vec2 size = TEXTURE_PIXEL_SIZE * outline_width;
	
	float alpha = 0.0;
	for (int i = 0; i < 16; i ++) {
		float angle = float(i) * TAU / 16.0;
		alpha = max(alpha, texture(TEXTURE, UV + vec2(cos(angle), sin(angle)) * size).a);
	}
	
	float pulse = 0.75 + 0.25 * sin(TIME * pulse_speed);
	COLOR = vec4(outline_color.rgb * glow_strength, alpha * (1.0 - base.a) * pulse);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
