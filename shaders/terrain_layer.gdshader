shader_type spatial;
render_mode world_vertex_coords;

uniform sampler2D upper_level_texture;
uniform float upper_threshold = 0.8;
uniform sampler2D middle_level_texture;
uniform float middle_threshold = 0.4;
uniform sampler2D lower_level_texture;

varying float vertex_height;

void vertex() {
	vertex_height = VERTEX.y;
}

void fragment() {
	//float vertex_height = clamp((1.0 - VERTEX.y), 0.0, 1.0);
	
	vec3 color;
	
	if (vertex_height >= upper_threshold) {
		color = texture(upper_level_texture, UV).rgb;
	}
	if (vertex_height < upper_threshold && vertex_height >= middle_threshold) {
		color = texture(middle_level_texture, UV).rgb;
	}
	if (vertex_height < middle_threshold) {
		color = texture(lower_level_texture, UV).rgb;
	}

	ALBEDO = color;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
