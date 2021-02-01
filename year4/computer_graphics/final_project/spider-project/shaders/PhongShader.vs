#version 330 core

layout (location = 0) in vec3 vertex_position;
layout (location = 1) in vec3 vertex_normal;
layout (location = 2) in vec2 vertex_texture;

out vec3 vertex_inWorldSpace;
out vec3 tnorm;
out mat3 NormalMatrix;

uniform mat4 model;
uniform mat4 view;
uniform mat4 proj;

out vec2 TexCoord;

void main()
{	
	TexCoord = vertex_texture;

	vertex_inWorldSpace = vec3(model * vec4(vertex_position, 1.0));

	mat4 ModelViewMatrix = view * model;
	mat3 NormalMatrix = mat3(ModelViewMatrix);

	tnorm = normalize(NormalMatrix * vertex_normal); // Transform normals to eye-space


	gl_Position = proj * view * vec4(vertex_inWorldSpace, 1.0);
}