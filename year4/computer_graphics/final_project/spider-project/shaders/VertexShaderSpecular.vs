#version 330 core

layout (location = 0) in vec3 vertex_position;
layout (location = 1) in vec3 vertex_normal;
layout (location = 2) in vec2 vertex_texture;



out vec3 vertex_inWorldSpace;
out vec3 tnorm;
out mat3 NormalMatrix;

out vec3 LightIntensity;
out vec2 TexCoord;

vec4 LightPosition = vec4 (20.0, 150.0, 0.0, 1.0); // Light position in world coords.
vec3 Kd = vec3 (0.0, 5.8, 0.0); // green diffuse surface reflectance
vec3 Ld = vec3 (1.0, 1.0, 1.0); // Light source intensity

uniform mat4 model;
uniform mat4 view;
uniform mat4 proj;



void main()
{	
	TexCoord = vertex_texture;

	vertex_inWorldSpace = vec3(model * vec4(vertex_position, 1.0));

	mat4 ModelViewMatrix = view * model;
	mat3 NormalMatrix = mat3(ModelViewMatrix);

	tnorm = normalize(NormalMatrix * vertex_normal); // Transform normals to eye-space

	// Position in view space
	vec4 eyeCoords = ModelViewMatrix * vec4(vertex_position,1.0);
    //normalised vector towards the light source
    vec3 s = normalize(vec3(LightPosition - eyeCoords));

	// The diffuse shading equation, dot product gives us the cosine of angle between the vectors
    LightIntensity = Ld * Kd * max( dot( s, tnorm ), 0.0 );

	gl_Position = proj * view * vec4(vertex_inWorldSpace, 1.0);

}