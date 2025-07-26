shader_type spatial;
render_mode blend_mix; 

#include "shaderincludes/fresnel.gdshaderinc"
#include "shaderincludes/linear_depth.gdshaderinc"
#include "shaderincludes/depth_fade.gdshaderinc"

group_uniforms Local;
uniform vec3 base_color: source_color;
uniform float metallic: hint_range(0.0, 1.0);
uniform float roughness: hint_range(0.0, 1.0);

uniform float speed;
uniform float wave_height = 1.0;

uniform sampler2D noise_texture_1;
uniform sampler2D noise_texture_2;

uniform sampler2D DEPTH_TEXTURE: hint_depth_texture;
uniform sampler2D SCREEN_TEXTURE: hint_screen_texture;

vec3 wave_strength(vec2 uv){
	vec3 wave_strength = texture(noise_texture_1, uv + vec2(TIME * speed, 0.0)).rgb;
	vec3 ripple_strength = texture(noise_texture_2, uv + vec2(0.0, TIME * speed)).rgb;
	return wave_strength + (ripple_strength * 0.2);
}

void vertex() {
	VERTEX.y += wave_strength(VERTEX.xz).y * wave_height;
}

void fragment() {
	vec3 final_color = base_color;
	
	// Fresnel color
	float fresnel_value = fresnel(NORMAL, VIEW);
	final_color = mix(final_color, fresnel_color, fresnel_value);
	
	vec3 normal_blend = mix(
		texture(noise_texture_1, UV + vec2(TIME * speed)).rgb,
		texture(noise_texture_2, UV + vec2(TIME * speed)).rgb,
		0.5
	);
	NORMAL_MAP = normal_blend;
	
	ALBEDO = final_color;
	METALLIC = metallic;
	ROUGHNESS = roughness;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
