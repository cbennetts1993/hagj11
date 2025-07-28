shader_type spatial;

uniform sampler2D base_texture;
uniform sampler2D wind_mask;

uniform vec2 wind_directional_strength;
uniform float speed;
uniform sampler2D noise;

void vertex() {
	float wind_value = texture(noise, UV + vec2(TIME * speed)).r * texture(wind_mask, UV).r;
	VERTEX.xy += wind_value * wind_directional_strength;
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
