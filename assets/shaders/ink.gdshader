shader_type canvas_item;

uniform vec4 ink_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);

void fragment() {
	vec4 ink = texture(TEXTURE, UV);
	float alpha = ink.a * ink_color.a;
	
	COLOR = vec4(ink_color.rgb, alpha);
}