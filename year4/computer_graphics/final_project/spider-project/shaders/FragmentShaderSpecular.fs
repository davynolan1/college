#version 330 core

out vec4 FragColor;

in vec3 tnorm;
in vec3 vertex_inWorldSpace;

in vec3 LightIntensity;
in vec2 TexCoord;

vec3 ambient_light_color = vec3(0.5, 0.5, 0.5);
vec3 diffuse_light_color = vec3(0.5, 0.5, 0.5);
vec3 spec_light_color = vec3(1.0, 1.0, 1.0);
uniform mat4 view;

uniform vec3 light_position;
uniform vec3 object_color;

uniform vec3 view_pos;

uniform float specular_coef;

uniform sampler2D texture1;

vec3 view_dir;


void main()
{
	// ambient 
	float ambientStrength = 0.1;
	vec3 ambient = ambientStrength * ambient_light_color;

	// diffuse
	vec3 norm = normalize(tnorm);
	vec3 light_dir = normalize(light_position - vertex_inWorldSpace);
	light_dir = vec3(view * vec4(light_dir, 0.0));
	float diff = max(dot(norm, light_dir), 0.0);
	vec3 diffuse = diff * diffuse_light_color;

	// specular
	
	float specularStrength = 0.5;
	view_dir = normalize(view_pos - vertex_inWorldSpace);
	vec3 reflect_dir = normalize(reflect(light_dir, tnorm));
	//vec3 reflect_dir = reflect(-light_dir, tnorm);
	float spec_dot = max(dot(view_dir, reflect_dir), 0.0);
	float spec = pow(spec_dot, specular_coef);
	vec3 specular = spec * specularStrength * spec_light_color;
	

	//vec3 result = (specular + ambient + diffuse) * object_color;
	vec3 result = (specular + ambient + diffuse);
	//FragColor = vec4(result, 1.0) * texture(texture1, TexCoord);
	FragColor = vec4(result, 1.0);
	//FragColor =texture(ourTexture, TexCoord);
	//FragColor = texture(texture1, TexCoord);
}