group_uniforms Depth_Fade;

uniform vec3 depth_fade_color: source_color;
uniform float beers_law = 2.0;
uniform float depth_offset = -0.75;

uniform sampler2D df_depth_texture: hint_depth_texture;
uniform sampler2D df_screen_texture: hint_screen_texture;

float depth_fade_value(vec3 vertex, vec2 screen_uv, mat4 inv_view_matrix, mat4 inv_projection_matrix) {
	float depth = texture(df_depth_texture, screen_uv).r;
	vec3 ndc = vec3(screen_uv * 2.0 - 1.0, depth);
	vec4 view = inv_projection_matrix * vec4(ndc, 1.0);
	view.xyz /= view.w;
	float linear_depth = -view.z;
	
	// fragment world position
	vec4 world = inv_view_matrix * inv_projection_matrix * vec4(ndc, 1.0);
	vec3 world_pos = world.xyz / world.w;
	
	vec3 vertex_pos = (inv_view_matrix * vec4(vertex, 1.0)).xyz;
	
	float vert_depth = vertex_pos.y - world_pos.y;
	
	return vert_depth;
}

