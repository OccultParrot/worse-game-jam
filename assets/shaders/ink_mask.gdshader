shader_type canvas_item;

uniform sampler2D ink_mask : filter_linear;
uniform vec4 ink_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);

void fragment() {
	vec4 image = texture(TEXTURE, UV);
	float mask = texture(ink_mask, UV).a * ink_color.a;

	float out_a = mask + image.a * (1.0 - mask);
	vec3 out_rgb = (ink_color.rgb * mask + image.rgb * image.a * (1.0 - mask)) / max(out_a, 0.0001);

	COLOR = vec4(out_rgb, out_a);
}