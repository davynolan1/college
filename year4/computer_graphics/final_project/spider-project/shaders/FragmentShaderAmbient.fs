#version 330 core

vec3 light_intensity = vec3 (1.0, 1.0, 9.0); // Light source intensity

uniform vec3 object_color; // Uniform should be used when there are multiple objects

float ambient_strength = 0.1;

void main() 
{
	vec3 ambient = ambient_strength * light_intensity;

	vec3 result = ambient * object_color;

	gl_FragColor = vec4(result, 1.0);
}