shader_type spatial;
render_mode cull_disabled, depth_draw_always;

uniform sampler2D base_texture;

uniform vec2 wind_directional_strength;
uniform float speed;
uniform sampler2D noise;

void vertex() {
	vec2 world_uv = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xz;
	float wind_value = texture(noise, world_uv + vec2(TIME * speed)).r;
	float vertex_height = clamp((1.0 - UV.y), 0.0, 1.0);
	VERTEX.x += wind_value * wind_directional_strength.x * pow(vertex_height, 2);
}

void fragment() {
	vec4 texture_color = texture(base_texture, UV);
	ALBEDO = texture_color.rgb;
	ALPHA = texture_color.a;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
