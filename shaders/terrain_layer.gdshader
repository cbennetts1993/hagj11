shader_type spatial;
render_mode world_vertex_coords;

uniform vec2 texture_scale = vec2(1.0);

uniform sampler2D upper_level_texture;
uniform float upper_threshold = 0.8;

uniform sampler2D middle_level_texture;
uniform vec3 mid_level_albedo: source_color;
uniform float middle_threshold = 0.4;

uniform sampler2D lower_level_texture;

uniform sampler2D edge_noise;

varying float vertex_height;

void vertex() {
	vertex_height = VERTEX.y;
}

void fragment() {
	//float vertex_height = clamp((1.0 - VERTEX.y), 0.0, 1.0);

	float edge_noise_value = texture(edge_noise, UV).r * 2.0;
	vec3 color;

	if (vertex_height >= upper_threshold + edge_noise_value) {
		color = texture(upper_level_texture, UV * texture_scale).rgb;
	}
	if (vertex_height < upper_threshold + edge_noise_value && vertex_height >= middle_threshold + edge_noise_value) {
		color = texture(middle_level_texture, UV * texture_scale).rgb * mid_level_albedo;
	}
	if (vertex_height < middle_threshold + edge_noise_value) {
		color = texture(lower_level_texture, UV * texture_scale).rgb;
	}

	ALBEDO = color;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
