group_uniforms Linear_Depth;
uniform float z_near;
uniform float z_far;

uniform sampler2D ld_depth_texture: hint_depth_texture;

float linearize_depth(vec2 screen_uv, mat4 in_view_matrix) {
	float depth = texture(ld_depth_texture, screen_uv).x;
	vec3 ndc = vec3(screen_uv * 2.0 - 1.0, depth);
	vec4 view = in_view_matrix * vec4(ndc, 1.0);
	view.xyz /= view.w;
	float linear_depth = -view.z;
	return linear_depth;
}
