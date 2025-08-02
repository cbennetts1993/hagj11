shader_type spatial;

uniform sampler2D noise;

uniform sampler2DArray textures;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec4 color = textureGather(textures, vec3(UV, 0));
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
