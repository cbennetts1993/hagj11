shader_type spatial;
render_mode blend_mix, unshaded;

uniform vec3 modulate: source_color = vec3(1.0);
uniform sampler2D base_texture;

uniform vec2 wind_directional_strength;
uniform float speed;
uniform sampler2D noise;

void vertex() {
	// Billboard Mode: Y-Billboard
	MODELVIEW_MATRIX = VIEW_MATRIX * mat4(
			vec4(normalize(cross(vec3(0.0, 1.0, 0.0), MAIN_CAM_INV_VIEW_MATRIX[2].xyz)), 0.0),
			vec4(0.0, 1.0, 0.0, 0.0),
			vec4(normalize(cross(MAIN_CAM_INV_VIEW_MATRIX[0].xyz, vec3(0.0, 1.0, 0.0))), 0.0),
			MODEL_MATRIX[3]);

	// Billboard Keep Scale: Enabled
	MODELVIEW_MATRIX = MODELVIEW_MATRIX * mat4(
			vec4(length(MODEL_MATRIX[0].xyz), 0.0, 0.0, 0.0),
			vec4(0.0, length(MODEL_MATRIX[1].xyz), 0.0, 0.0),
			vec4(0.0, 0.0, length(MODEL_MATRIX[2].xyz), 0.0),
			vec4(0.0, 0.0, 0.0, 1.0));
	MODELVIEW_NORMAL_MATRIX = mat3(MODELVIEW_MATRIX);

	vec2 world_uv = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xz;
	float wind_value = texture(noise, world_uv + vec2(TIME * speed)).r;
	float vertex_height = clamp((1.0 - UV.y), 0.0, 1.0);
	VERTEX.x += wind_value * wind_directional_strength.x * pow(vertex_height, 2);
}

void fragment() {
	vec4 texture_color = texture(base_texture, UV);
	ALBEDO = texture_color.rgb * modulate;
	ALPHA_SCISSOR_THRESHOLD = 0.7;
	ALPHA = texture_color.a;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
