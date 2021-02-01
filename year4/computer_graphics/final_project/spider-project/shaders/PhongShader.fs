#version 330 core

out vec4 FragColor;

in vec3 tnorm;
in vec3 vertex_inWorldSpace;

vec3 light_color = vec3(1.0, 1.0, 1.0);

uniform vec3 light_position;
uniform mat4 view;

in vec2 TexCoord;

uniform sampler2D texture1;

vec3 view_dir;

uniform vec3 view_pos;


//uniform float specular_coef;
struct Material {
    vec3 ambient;
    vec3 diffuse;
    vec3 specular;    
    float shininess;
}; 

struct Light {
    vec3 position;

    vec3 ambient;
    vec3 diffuse;
    vec3 specular;
};

uniform Material material;
uniform Light light1;
uniform Light light2;

vec3 calc_phong (Light light) {
	// ambient
	float ambientStrength = 0.1;
	//vec3 ambient = ambientStrength * light_color;
	vec3 ambient = light.ambient * material.ambient;
	
	// diffuse 
	vec3 norm = normalize(tnorm);
	vec3 lightDir = normalize(light.position - vertex_inWorldSpace);
	lightDir = vec3(view * vec4(lightDir, 0.0));
	float diff = max(dot(norm, lightDir), 0.0);
	//vec3 diffuse = diff * light_color;
	vec3 diffuse = light.diffuse * (diff * material.diffuse);

	// specular
    float specularStrength = 0.5;
    vec3 viewDir = normalize(view_pos - vertex_inWorldSpace);
    vec3 reflectDir = reflect(-lightDir, norm);  
    float spec = pow(max(dot(viewDir, reflectDir), 0.0), 32);
    //vec3 specular = specularStrength * spec * light_color; 
	vec3 specular = light.specular * (spec * material.specular); 

	return (ambient + diffuse + specular);
}



void main()
{
	vec3 result = calc_phong(light1) + calc_phong(light2);
	FragColor = vec4(result, 1.0) * texture(texture1, TexCoord);
}

