group_uniforms Fresnel;
uniform float amount;
uniform float intensity;
uniform vec3 fresnel_color: source_color;

float fresnel(vec3 normal, vec3 view){
	return pow((1.0 - clamp(dot(normalize(normal), normalize(view)), 0.0, 1.0 )), amount);
}

vec3 fresnel_glow(vec3 normal, vec3 view){
	return pow((1.0 - dot(normalize(normal), normalize(view))), amount) * fresnel_color * intensity;
}
