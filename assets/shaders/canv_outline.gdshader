shader_type canvas_item;

uniform vec4 fill_color: source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform vec4 outline_color: source_color = vec4(0.063, 0.043, 0.165, 1.0);
uniform float outline_size: hint_range(0.0, 32.0) = 16.0;
uniform int outline_copies: hint_range(4, 32) = 16;

void fragment() {
	vec4 tex = texture(TEXTURE, UV);
	float ring = 0.0;

	for (int i = 0; i < 32; i++) {
		if (i >= outline_copies) {
			break;
		}

		float angle = float(i) * TAU / float(outline_copies);
		vec2 offset = vec2(cos(angle), sin(angle)) * outline_size * TEXTURE_PIXEL_SIZE;
		ring = max(ring, texture(TEXTURE, UV + offset).a);
	}

	vec4 fill = vec4(tex.rgb * fill_color.rgb, tex.a * fill_color.a);
	vec4 outline = vec4(outline_color.rgb, outline_color.a * ring);

	COLOR = vec4(mix(outline.rgb, fill.rgb, fill.a), max(outline.a * (1.0 - fill.a), fill.a));
}
