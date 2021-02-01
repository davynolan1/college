#pragma region Include_Libraries
// Windows includes (For Time, IO, etc.)
#include <windows.h>
#include <mmsystem.h>
#include <iostream>
#include <string>
#include <stdio.h>
#include <math.h>
#include <vector> // STL dynamic memory.
#include <tuple>


// OpenGL includes
#include <GL/glew.h>
#include <GL/freeglut.h>

// Assimp includes
#include <assimp/cimport.h> // scene importer
#include <assimp/scene.h> // collects data
#include <assimp/postprocess.h> // various extra operations

// Project includes
#include "maths_funcs.h"

//glm
#include "glm/glm/glm.hpp"
#include "glm/glm/gtx/transform.hpp"
#include "glm/glm/gtc/type_ptr.hpp"

#define STB_IMAGE_IMPLEMENTATION
#include "stb_image.h"

#include "shader.h"
#pragma endregion Include_Libraries

#pragma region Model_Constants
#define SPIDER_BODY "models/spider_body_joints.dae"

#define LEG_L1_TOP "models/spider_leg_l1_t.dae"
#define LEG_L1_BTM "models/spider_leg_l1_b.dae"
#define LEG_L2_TOP "models/spider_leg_l2_t.dae"
#define LEG_L2_BTM "models/spider_leg_l2_b.dae"
#define LEG_L3_TOP "models/spider_leg_l3_t.dae"
#define LEG_L3_BTM "models/spider_leg_l3_b.dae"
#define LEG_L4_TOP "models/spider_leg_l4_t.dae"
#define LEG_L4_BTM "models/spider_leg_l4_b.dae"
#define LEG_R1_TOP "models/spider_leg_r1_t.dae"
#define LEG_R1_BTM "models/spider_leg_r1_b.dae"
#define LEG_R2_TOP "models/spider_leg_r2_t.dae"
#define LEG_R2_BTM "models/spider_leg_r2_b.dae"
#define LEG_R3_TOP "models/spider_leg_r3_t.dae"
#define LEG_R3_BTM "models/spider_leg_r3_b.dae"
#define LEG_R4_TOP "models/spider_leg_r4_t.dae"
#define LEG_R4_BTM "models/spider_leg_r4_b.dae"

#define PLANE "models/plane.dae"
#define LIGHT_CUBE "models/light_sphere.dae"
#define MONKEY_HEAD "monkeyhead_smooth.dae"
#define BIN "models/bin.dae"
#define ROCK "models/rock.dae"
#define WOOD "models/wood_pallet.dae"
#define WALL "models/wall.dae"
#define CANDLE "models/candle.dae"
#pragma endregion Model_Constants

#pragma region Texture_Constants
#define HAIRY1_TEX "textures/hairy1.jpg"
#define HAIRY2_TEX "textures/hairy2.jpg"
#define DIRT_TEX "textures/dirt.jpg"
#define STONE_TEX "textures/stone.jpg"
#define METAL_TEX "textures/metal.jpg"
#define ROCK_TEX "textures/rock.jpg"
#define WOOD_TEX "textures/wood.jpg"
#define BRICK_TEX "textures/brickwall.jpg"
#define GOLD_TEX "textures/gold.jpg"
#pragma endregion Texture_Constants

#pragma region ModelData_Variables
typedef struct
{
	size_t mPointCount = 0;
	std::vector<vec3> mVertices;
	std::vector<vec3> mNormals;
	std::vector<vec2> mTextureCoords;
} ModelData;
using namespace std;

// Initialising mesh data variables
ModelData body_mesh;
ModelData plane_mesh;
ModelData l1_t_mesh;
ModelData l1_b_mesh;
ModelData l2_t_mesh;
ModelData l2_b_mesh;
ModelData l3_t_mesh;
ModelData l3_b_mesh;
ModelData l4_t_mesh;
ModelData l4_b_mesh;
ModelData r1_t_mesh;
ModelData r1_b_mesh;
ModelData r2_t_mesh;
ModelData r2_b_mesh;
ModelData r3_t_mesh;
ModelData r3_b_mesh;
ModelData r4_t_mesh;
ModelData r4_b_mesh;

ModelData light_cube_mesh;
ModelData monkey_head;
ModelData bin_mesh;
ModelData rock_mesh;
ModelData wood_mesh;
ModelData wall_mesh;
ModelData candle_mesh;
#pragma endregion ModelData_Variables

#pragma region Camera_Variables
glm::vec3 cameraPos = glm::vec3(10.0f, 5.0f, 10.0f);
glm::vec3 cameraFront = glm::vec3(0.0f, 0.0f, -1.0f);
glm::vec3 cameraUp = glm::vec3(0.0f, 70.0f, 0.0f);
float deltaTime = 0.0f; // Time between current frame and last frame
float lastFrame = 0.0f; // Time of last frame
bool firstMouse = true;
float yaw = -90.0f;
float pitch = 0.0f;
int lastX = 800.0f / 2.0;
int lastY = 600.0 / 2.0;
float fov = 45.0f;
#pragma endregion Camera_Variables

#pragma region Material_Variables
struct Material {
	glm::vec3 ambient;
	glm::vec3 diffuse;
	glm::vec3 specular;
	float shininess;
};

Material stone_ground;
Material spider_fur;
Material rock;
Material metal_bin;
Material wood;
Material brick;
#pragma endregion Material_Variables

#pragma region Spider_Position_Variables
float spider1_xpos = 0.0f;
float spider1_zpos = 50.0f;
float spider1_start_xpos = 0.0f;
float spider1_start_zpos = 50.0f;
float spider1_deg = 0.0f;

float spider2_xpos = -25.0f;
float spider2_zpos = 50.0f;
float spider2_start_xpos = -25.0f;
float spider2_start_zpos = 50.0f;
float spider2_deg = 0.0f;

float spider3_xpos = 25.0f;
float spider3_zpos = 50.0f;
float spider3_start_xpos = 25.0f;
float spider3_start_zpos = 50.0f;
float spider3_deg = 0.0f;

float spider4_xpos = -50.0f;
float spider4_zpos = 50.0f;
float spider4_start_xpos = -50.0f;
float spider4_start_zpos = 50.0f;
float spider4_deg = 0.0f;

float spider5_xpos = 50.0f;
float spider5_zpos = 50.0f;
float spider5_start_xpos = 50.0f;
float spider5_start_zpos = 50.0f;
float spider5_deg = 0.0f;

float spider6_xpos = 0.0f;
float spider6_zpos = 75.0f;
float spider6_start_xpos = 0.0f;
float spider6_start_zpos = 75.0f;
float spider6_deg = 0.0f;

float spider7_xpos = -25.0f;
float spider7_zpos = 75.0f;
float spider7_start_xpos = -25.0f;
float spider7_start_zpos = 75.0f;
float spider7_deg = 0.0f;

float spider8_xpos = 25.0f;
float spider8_zpos = 75.0f;
float spider8_start_xpos = 25.0f;
float spider8_start_zpos = 75.0f;
float spider8_deg = 0.0f;

float spider9_xpos = -50.0f;
float spider9_zpos = 75.0f;
float spider9_start_xpos = -50.0f;
float spider9_start_zpos = 75.0f;
float spider9_deg = 0.0f;

float spider10_xpos = 50.0f;
float spider10_zpos = 75.0f;
float spider10_start_xpos = 50.0f;
float spider10_start_zpos = 75.0f;
float spider10_deg = 0.0f;

float spider11_xpos = 0.0f;
float spider11_zpos = 25.0f;
float spider11_start_xpos = 0.0f;
float spider11_start_zpos = 25.0f;
float spider11_deg = 0.0f;

float spider12_xpos = -25.0f;
float spider12_zpos = 25.0f;
float spider12_start_xpos = -25.0f;
float spider12_start_zpos = 25.0f;
float spider12_deg = 0.0f;

float spider13_xpos = 25.0f;
float spider13_zpos = 25.0f;
float spider13_start_xpos = 25.0f;
float spider13_start_zpos = 25.0f;
float spider13_deg = 0.0f;

float spider14_xpos = -50.0f;
float spider14_zpos = 25.0f;
float spider14_start_xpos = -50.0f;
float spider14_start_zpos = 25.0f;
float spider14_deg = 0.0f;

float spider15_xpos = 50.0f;
float spider15_zpos = 25.0f;
float spider15_start_xpos = 50.0f;
float spider15_start_zpos = 25.0f;
float spider15_deg = 0.0f;

float spider_user_ypos = 0.0f;
float spider_user_xpos = 0.0f;
float spider_user_zpos = 0.0f;
float spider_user_ground_ypos = 0.0f;

int jump_state = 0;
int jump_ascend = 0;
float new_height = 0.0f;
#pragma endregion Spider_Position_Variables

#pragma region Skybox_Variables
// Variable for loading skybox texture
GLuint cubemapTexture;

// Vector containing the images of 6-sided skybox texture
vector<std::string> faces
{
	"textures/right.jpg",
	"textures/left.jpg",
	"textures/top.jpg",
	"textures/bottom.jpg",
	"textures/back.jpg",
	"textures/front.jpg"
};

GLfloat skyboxVertices[] = {
	// positions          
	-1.0f,  1.0f, -1.0f,
	-1.0f, -1.0f, -1.0f,
	 1.0f, -1.0f, -1.0f,
	 1.0f, -1.0f, -1.0f,
	 1.0f,  1.0f, -1.0f,
	-1.0f,  1.0f, -1.0f,

	-1.0f, -1.0f,  1.0f,
	-1.0f, -1.0f, -1.0f,
	-1.0f,  1.0f, -1.0f,
	-1.0f,  1.0f, -1.0f,
	-1.0f,  1.0f,  1.0f,
	-1.0f, -1.0f,  1.0f,

	 1.0f, -1.0f, -1.0f,
	 1.0f, -1.0f,  1.0f,
	 1.0f,  1.0f,  1.0f,
	 1.0f,  1.0f,  1.0f,
	 1.0f,  1.0f, -1.0f,
	 1.0f, -1.0f, -1.0f,

	-1.0f, -1.0f,  1.0f,
	-1.0f,  1.0f,  1.0f,
	 1.0f,  1.0f,  1.0f,
	 1.0f,  1.0f,  1.0f,
	 1.0f, -1.0f,  1.0f,
	-1.0f, -1.0f,  1.0f,

	-1.0f,  1.0f, -1.0f,
	 1.0f,  1.0f, -1.0f,
	 1.0f,  1.0f,  1.0f,
	 1.0f,  1.0f,  1.0f,
	-1.0f,  1.0f,  1.0f,
	-1.0f,  1.0f, -1.0f,

	-1.0f, -1.0f, -1.0f,
	-1.0f, -1.0f,  1.0f,
	 1.0f, -1.0f, -1.0f,
	 1.0f, -1.0f, -1.0f,
	-1.0f, -1.0f,  1.0f,
	 1.0f, -1.0f,  1.0f
};
#pragma endregion Skybox_Variables

int width = 800; // Window width
int height = 600; // Window height

GLuint loc1, loc2, loc3;

// Rotation variables
GLfloat rotate_body = 0.0f;
GLfloat rotate_plane = 0.0f;
GLfloat rotate_leg = 0.0f;

// Decides whether leg moves up (+3) or down (-3)
GLfloat leg_direction = 3.0f;

// Translation variables to move the light source 
GLfloat light1_trans_x = 0.0f;
GLfloat light1_trans_z = 0.0f;
GLfloat light2_trans_x = 0.0f;
GLfloat light2_trans_z = 0.0f;

// Variable to play or pause animation of spiders
GLboolean animate = false;

GLuint idM;

// Variable defining Pi to a suitable decimal place for making spiders move in a circular path
const float  PI = 3.14159265358979f;

// Variable which allows the user to switch between spider-control (0) and camera-control (1) modes
int user_mode = 0;

// Variable which allows the user to switch which light source to control
int light_mode = 0;

std::vector<Shader> shaderPrograms;

/*----------------------------------------------------------------------------------------------------------------------*/

#pragma region Mesh_Loading_Function
/*----------------------------------------------------------------------------
MESH LOADING FUNCTION
----------------------------------------------------------------------------*/

ModelData load_mesh(const char* file_name) {
	ModelData modelData;

	/* Use assimp to read the model file, forcing it to be read as    */
	/* triangles. The second flag (aiProcess_PreTransformVertices) is */
	/* relevant if there are multiple meshes in the model file that   */
	/* are offset from the origin. This is pre-transform them so      */
	/* they're in the right position.                                 */
	const aiScene* scene = aiImportFile(
		file_name,
		aiProcess_Triangulate | aiProcess_PreTransformVertices
	);

	if (!scene) {
		fprintf(stderr, "ERROR: reading mesh %s\n", file_name);
		return modelData;
	}

	printf("  %i materials\n", scene->mNumMaterials);
	printf("  %i meshes\n", scene->mNumMeshes);
	printf("  %i textures\n", scene->mNumTextures);

	for (unsigned int m_i = 0; m_i < scene->mNumMeshes; m_i++) {
		const aiMesh* mesh = scene->mMeshes[m_i];
		printf("    %i vertices in mesh\n", mesh->mNumVertices);
		modelData.mPointCount += mesh->mNumVertices;
		for (unsigned int v_i = 0; v_i < mesh->mNumVertices; v_i++) {
			if (mesh->HasPositions()) {
				const aiVector3D* vp = &(mesh->mVertices[v_i]);
				modelData.mVertices.push_back(vec3(vp->x, vp->y, vp->z));
			}
			if (mesh->HasNormals()) {
				const aiVector3D* vn = &(mesh->mNormals[v_i]);
				modelData.mNormals.push_back(vec3(vn->x, vn->y, vn->z));
			}
			if (mesh->HasTextureCoords(0)) {
				const aiVector3D* vt = &(mesh->mTextureCoords[0][v_i]);
				modelData.mTextureCoords.push_back(vec2(vt->x, vt->y));
			}
			if (mesh->HasTangentsAndBitangents()) {
				/* You can extract tangents and bitangents here              */
				/* Note that you might need to make Assimp generate this     */
				/* data for you. Take a look at the flags that aiImportFile  */
				/* can take.                                                 */
			}
		}
	}

	aiReleaseImport(scene);
	return modelData;
}

#pragma endregion Mesh_Loading_Function

#pragma region Texture_Functions
void generateTextures(unsigned int texture, const char* textureName) {
	glGenTextures(1, &texture);
	glBindTexture(GL_TEXTURE_2D, texture);
	// set the texture wrapping parameters
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);	// set texture wrapping to GL_REPEAT (default wrapping method)
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
	// set texture filtering parameters
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
	// load image, create texture and generate mipmaps
	int width;
	int	height;
	int	nrChannels;
	stbi_set_flip_vertically_on_load(true); // tell stb_image.h to flip loaded texture's on the y-axis.
	unsigned char* data = stbi_load(textureName, &width, &height, &nrChannels, 0);
	if (data)
	{
		glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, width, height, 0, GL_RGB, GL_UNSIGNED_BYTE, data);
		glGenerateMipmap(GL_TEXTURE_2D);
	}
	else
	{
		std::cout << "Failed to load texture" << std::endl;
	}
	stbi_image_free(data);

	glVertexAttribPointer(loc3, 2, GL_FLOAT, GL_FALSE, 0, NULL);
	glEnableVertexAttribArray(loc3);

}
#pragma endregion Texture_Function

#pragma region VBO_Functions
ModelData generateObjectBufferMesh(const char* meshName, unsigned int vao_no, int shaderNo, const char* textureName) {
	/*----------------------------------------------------------------------------
	LOAD MESH HERE AND COPY INTO BUFFERS
	----------------------------------------------------------------------------*/

	//Note: you may get an error "vector subscript out of range" if you are using this code for a mesh that doesnt have positions and normals
	//Might be an idea to do a check for that before generating and binding the buffer.

	ModelData mesh_data = load_mesh(meshName);
	glGenVertexArrays(1, &vao_no);

	unsigned int vp_vbo;
	/*
	loc1 = glGetAttribLocation(shaderProgramID, "vertex_position");
	loc2 = glGetAttribLocation(shaderProgramID, "vertex_normal");
	loc3 = glGetAttribLocation(shaderProgramID, "vertex_texture");
	*/
	loc1 = glGetAttribLocation(shaderPrograms[shaderNo].ID, "vertex_position");
	loc2 = glGetAttribLocation(shaderPrograms[shaderNo].ID, "vertex_normal");
	loc3 = glGetAttribLocation(shaderPrograms[shaderNo].ID, "vertex_texture");

	glGenBuffers(1, &vp_vbo);
	glBindBuffer(GL_ARRAY_BUFFER, vp_vbo);
	glBufferData(GL_ARRAY_BUFFER, mesh_data.mPointCount * sizeof(vec3), &mesh_data.mVertices[0], GL_STATIC_DRAW);
	unsigned int vn_vbo;
	glGenBuffers(1, &vn_vbo);
	glBindBuffer(GL_ARRAY_BUFFER, vn_vbo);
	glBufferData(GL_ARRAY_BUFFER, mesh_data.mPointCount * sizeof(vec3), &mesh_data.mNormals[0], GL_STATIC_DRAW);

	//            This is for texture coordinates which you don't currently need, so I have commented it out
	//            unsigned int vt_vbo = 0;
	//            glGenBuffers (1, &vt_vbo);
	//            glBindBuffer (GL_ARRAY_BUFFER, vt_vbo);
	//            glBufferData (GL_ARRAY_BUFFER, monkey_head_data.mTextureCoords * sizeof (vec2), &monkey_head_data.mTextureCoords[0], GL_STATIC_DRAW);

	unsigned int vao = vao_no;

	glBindVertexArray(vao);

	glEnableVertexAttribArray(loc1);
	glBindBuffer(GL_ARRAY_BUFFER, vp_vbo);
	glVertexAttribPointer(loc1, 3, GL_FLOAT, GL_FALSE, 0, NULL);
	glEnableVertexAttribArray(loc2);
	glBindBuffer(GL_ARRAY_BUFFER, vn_vbo);
	glVertexAttribPointer(loc2, 3, GL_FLOAT, GL_FALSE, 0, NULL);

	//            This is for texture coordinates which you don't currently need, so I have commented it out
	//            glEnableVertexAttribArray (loc3);
	//            glBindBuffer (GL_ARRAY_BUFFER, vt_vbo);
	//            glVertexAttribPointer (loc3, 2, GL_FLOAT, GL_FALSE, 0, NULL);

	// texture 1
	// ---------

	unsigned int textureNo = vao_no;
	if (textureName != "") {
		generateTextures(textureNo, textureName);
		
	}
	glVertexAttribPointer(loc3, 2, GL_FLOAT, GL_FALSE, 0, NULL);
	glEnableVertexAttribArray(loc3);

	//textures.push_back(texture1);
	cout << meshName;
	return mesh_data;
}
#pragma endregion VBO_Functions

#pragma region Skybox_Functions
unsigned int loadCubemap()
{
	unsigned int textureID;
	glGenTextures(1, &textureID);
	glBindTexture(GL_TEXTURE_CUBE_MAP, textureID);

	int width, height, nrChannels;
	for (unsigned int i = 0; i < faces.size(); i++)
	{
		unsigned char* data = stbi_load(faces[i].c_str(), &width, &height, &nrChannels, 0);
		if (data)
		{
			glTexImage2D(GL_TEXTURE_CUBE_MAP_POSITIVE_X + i,
				0, GL_RGB, width, height, 0, GL_RGB, GL_UNSIGNED_BYTE, data
			);
			stbi_image_free(data);
		}
		else
		{
			std::cout << "Cubemap tex failed to load at path: " << faces[i] << std::endl;
			stbi_image_free(data);
		}
	}
	glTexParameteri(GL_TEXTURE_CUBE_MAP, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
	glTexParameteri(GL_TEXTURE_CUBE_MAP, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
	glTexParameteri(GL_TEXTURE_CUBE_MAP, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
	glTexParameteri(GL_TEXTURE_CUBE_MAP, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
	glTexParameteri(GL_TEXTURE_CUBE_MAP, GL_TEXTURE_WRAP_R, GL_CLAMP_TO_EDGE);

	return textureID;
}

void skyboxSetup(unsigned int vao_no) {
	GLuint skyboxVAO = vao_no;
	GLuint skyboxVBO = vao_no;
	glGenVertexArrays(1, &skyboxVAO);
	glGenBuffers(1, &skyboxVBO);
	glBindVertexArray(skyboxVAO);
	glBindBuffer(GL_ARRAY_BUFFER, skyboxVBO);
	glBufferData(GL_ARRAY_BUFFER, sizeof(skyboxVertices), &skyboxVertices, GL_STATIC_DRAW);
	glEnableVertexAttribArray(0);
	glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 3 * sizeof(GLfloat), (GLvoid*)0);
	glBindVertexArray(0);

	cubemapTexture = loadCubemap();
}
#pragma endregion Skybox_Functions

#pragma region Drawing_Functions
// Function for drawing the legs of the spider
glm::mat4 drawLegs(glm::mat4 M, int vao, ModelData mesh_name, float rotate_leg_direction) {

	glm::mat4 T_leg = glm::mat4(1.0f); //translation matrix
	glm::mat4 R_leg = glm::mat4(1.0f); //rotation matrix
	glm::mat4 M_leg = glm::mat4(1.0f); //model matrix M = T * R * S

	T_leg = glm::translate(glm::mat4(1.0f), glm::vec3(0.0f, 0.0f, 0.0f)); //translation matrix
	R_leg = glm::rotate(glm::mat4(1.0f), glm::radians(rotate_leg_direction), glm::vec3(0.0f, 0.0f, 1.0f)); //rotation matrix - could have a R_x, R_y, R_z
	M_leg = M * T_leg * R_leg;

	//glUniformMatrix4fv(idM, 1, GL_FALSE, glm::value_ptr(M_leg));
	shaderPrograms[0].setMat4("model", M_leg);

	glBindVertexArray(vao);
	glBindTexture(GL_TEXTURE_2D, vao);
	glDrawArrays(GL_TRIANGLES, 0, mesh_name.mPointCount);
	return M_leg;
}

// Function for drawing the body of the spider
glm::mat4 drawSpiderBody(glm::mat4 M_parent, float x_pos, float y_pos, float z_pos, float rot_degree, float scale) {
	//Body (child of the plane but parent of the legs)
	glm::mat4 T_body = glm::mat4(1.0f); //translation matrix
	glm::mat4 R_body = glm::mat4(1.0f); //rotation matrix
	glm::mat4 S_body = glm::mat4(1.0f); //scaling matrix
	glm::mat4 M_body = glm::mat4(1.0f); //model matrix M = T * R * S

	T_body = glm::translate(glm::mat4(1.0f), glm::vec3(x_pos, y_pos, z_pos)); //translation matrix
	R_body = glm::rotate(glm::mat4(1.0f), glm::radians(rot_degree), glm::vec3(0.0f, 1.0f, 0.0f)); //rotation matrix - could have a R_x, R_y, R_z
	S_body = glm::scale(glm::mat4(1.0f), glm::vec3(scale)); //scaling matrix
	M_body = M_parent * T_body * R_body * S_body; // combine to form model matrix - NB order is very important here - scaling comes first but it goes from right to left

	shaderPrograms[0].setMat4("model", M_body);

	glBindTexture(GL_TEXTURE_2D, 2);
	glBindVertexArray(2);
	glDrawArrays(GL_TRIANGLES, 0, body_mesh.mPointCount);
	return M_body;
}

// Function for calling both the leg and body drawing functions
void drawSpider(glm::mat4 ground, float x_pos, float y_pos, float z_pos, float rot_degree, float scale) {
	

	glm::mat4 spiderBody = drawSpiderBody(ground, x_pos, y_pos, z_pos, rot_degree, scale);
	float rotate_leg_direction = rotate_leg;
	//left legs
	glm::mat4 l1_t_model = drawLegs(spiderBody, 3, l1_t_mesh, rotate_leg_direction);
	glm::mat4 l1_b_model = drawLegs(l1_t_model, 4, l1_b_mesh, 0.0f);
	glm::mat4 l2_t_model = drawLegs(spiderBody, 5, l2_t_mesh, -rotate_leg_direction);
	glm::mat4 l2_b_model = drawLegs(l2_t_model, 6, l2_b_mesh, 0.0f);
	glm::mat4 l3_t_model = drawLegs(spiderBody, 7, l3_t_mesh, rotate_leg_direction);
	glm::mat4 l3_b_model = drawLegs(l3_t_model, 8, l3_b_mesh, 0.0f);
	glm::mat4 l4_t_model = drawLegs(spiderBody, 9, l4_t_mesh, -rotate_leg_direction);
	glm::mat4 l4_b_model = drawLegs(l4_t_model, 10, l4_b_mesh, 0.0f);
	//right legs
	glm::mat4 r1_t_model = drawLegs(spiderBody, 11, r1_t_mesh, -rotate_leg_direction);
	glm::mat4 r1_b_model = drawLegs(r1_t_model, 12, r1_b_mesh, 0.0f);
	glm::mat4 r2_t_model = drawLegs(spiderBody, 13, r2_t_mesh, rotate_leg_direction);
	glm::mat4 r2_b_model = drawLegs(r2_t_model, 14, r2_b_mesh, 0.0f);
	glm::mat4 r3_t_model = drawLegs(spiderBody, 15, r3_t_mesh, -rotate_leg_direction);
	glm::mat4 r3_b_model = drawLegs(r3_t_model, 16, r3_b_mesh, 0.0f);
	glm::mat4 r4_t_model = drawLegs(spiderBody, 17, r4_t_mesh, rotate_leg_direction);
	glm::mat4 r4_b_model = drawLegs(r4_t_model, 18, r4_b_mesh, 0.0f);
}

// Animation function to make the user-controlled spider jump 
void spiderJump() {
	if (jump_ascend == 1) {
		new_height += 2.0f;
		spider_user_ypos = spider_user_ground_ypos + new_height;

		if ((spider_user_ypos - spider_user_ground_ypos)>= 10.0f) {
			jump_ascend = 0;
		}
	}
	else if (jump_ascend == 0) {
		new_height -= 2.0f;
		spider_user_ypos = spider_user_ground_ypos + new_height;

		if ((spider_user_ypos - spider_user_ground_ypos) <= 0.0f) {
			jump_state = 0;
		}
	}
}

void display() {
	glEnable(GL_DEPTH_TEST); // enable depth-testing
	//glDepthFunc(GL_LESS); // depth-testing interprets a smaller value as "closer"
	glClearColor(0.5f, 0.5f, 0.5f, 1.0f);
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
		
	//Prepare view matrix - aka camera
	glm::mat4 V = glm::mat4(1.0f);
	V = glm::lookAt(cameraPos, cameraPos + cameraFront, cameraUp);	// create lookAt matrix for camera view

	//Prepare projection matrix
	glm::mat4 P = glm::mat4(1.0f);
	P = glm::perspective(glm::radians(45.0f), (float)width / (float)height, 1.0f, 100.0f); //perspective projection glm::perspective(field of view, aspect ratio, near plane, far plane)
	//P = glm::ortho(-16.0f, 16.0f, -12.0f, 12.0f, 1.0f, 100.0f); //orthographic projection glm::ortho(left, right, bottom, top, near plane, far plane)

#pragma region Draw_Skybox
	glDepthFunc(GL_LEQUAL);
	shaderPrograms[1].use();
	glm::mat4 viewSkyBox = glm::mat4(glm::mat3(glm::lookAt(cameraPos, cameraPos + cameraFront, cameraUp)));
	shaderPrograms[1].setMat4("view", viewSkyBox);
	shaderPrograms[1].setMat4("projection", P);
	// skybox cube
	glBindVertexArray(23);
	glActiveTexture(GL_TEXTURE0);
	glBindTexture(GL_TEXTURE_CUBE_MAP, cubemapTexture);
	glDrawArrays(GL_TRIANGLES, 0, 36);
	glDepthFunc(GL_LESS); // depth-testing interprets a smaller value as "closer"
#pragma endregion Draw_Skybox

	shaderPrograms[0].use();
	shaderPrograms[0].setMat4("proj", P);
	shaderPrograms[0].setMat4("view", V);
	glm::vec3 view_position = cameraUp;
	shaderPrograms[0].setVec3("view_pos", view_position);

#pragma region Draw_Candle
	glm::mat4 T_lamp1 = glm::mat4(1.0f); //translation matrix
	glm::mat4 R_lamp1 = glm::mat4(1.0f); //rotation matrix
	glm::mat4 S_lamp1 = glm::mat4(1.0f); //scaling matrix
	glm::mat4 M_lamp1 = glm::mat4(1.0f); //model matrix M = T * R * S

	glm::vec3 light1_position = glm::vec3(light1_trans_x + 10.0f, 10.0, light1_trans_z);

	T_lamp1 = glm::translate(glm::mat4(1.0f), light1_position); //translation matrix
	S_lamp1 = glm::scale(glm::mat4(1.0f), glm::vec3(0.03f));
	M_lamp1 = M_lamp1 * T_lamp1 * S_lamp1; // combine to form model matrix - NB order is very important here - scaling comes first but it goes from right to left

	shaderPrograms[0].setVec3("material.ambient", metal_bin.ambient);
	shaderPrograms[0].setVec3("material.diffuse", metal_bin.diffuse);
	shaderPrograms[0].setVec3("material.specular", metal_bin.specular); 
	shaderPrograms[0].setFloat("material.shininess", metal_bin.shininess);
	shaderPrograms[0].setMat4("model", M_lamp1);

	//glBindTexture(GL_TEXTURE_2D, 19);
	glBindVertexArray(19);
	glDrawArrays(GL_TRIANGLES, 0, candle_mesh.mPointCount);

	glm::mat4 T_lamp2 = glm::mat4(1.0f); //translation matrix
	glm::mat4 R_lamp2 = glm::mat4(1.0f); //rotation matrix
	glm::mat4 S_lamp2 = glm::mat4(1.0f); //scaling matrix
	glm::mat4 M_lamp2 = glm::mat4(1.0f); //model matrix M = T * R * S

	glm::vec3 light2_position = glm::vec3(light2_trans_x - 10.0f, 10.0, light2_trans_z);

	T_lamp2 = glm::translate(glm::mat4(1.0f), light2_position); //translation matrix
	S_lamp2 = glm::scale(glm::mat4(1.0f), glm::vec3(0.03f));
	M_lamp2 = M_lamp2 * T_lamp2 * S_lamp2; // combine to form model matrix - NB order is very important here - scaling comes first but it goes from right to left

	shaderPrograms[0].setMat4("model", M_lamp2);

	//glBindTexture(GL_TEXTURE_2D, 19);
	//glBindVertexArray(19);
	glDrawArrays(GL_TRIANGLES, 0, candle_mesh.mPointCount);
#pragma endregion Draw_Candle

#pragma region Setup_Lighting
	glm::vec3 lightColor = glm::vec3(3.0f, 3.0f, 3.0f);
	glm::vec3 diffuseColor = lightColor * glm::vec3(0.8f); 
	glm::vec3 ambientColor = diffuseColor * glm::vec3(0.3f); 
	glm::vec3 specularColor = glm::vec3(1.0f, 1.0f, 1.0f);

	shaderPrograms[0].setVec3("light1.position", light1_position);
	shaderPrograms[0].setVec3("light1.ambient", ambientColor);
	shaderPrograms[0].setVec3("light1.diffuse", diffuseColor);
	shaderPrograms[0].setVec3("light1.specular", specularColor);

	shaderPrograms[0].setVec3("light2.position", light2_position);
	shaderPrograms[0].setVec3("light2.ambient", ambientColor);
	shaderPrograms[0].setVec3("light2.diffuse", diffuseColor);
	shaderPrograms[0].setVec3("light2.specular", specularColor);
#pragma endregion Setup_Lighting
	
#pragma region Draw_Ground
	//flat plane under spider
	glm::mat4 T_plane = glm::mat4(1.0f); //translation matrix
	glm::mat4 R_plane = glm::mat4(1.0f); //rotation matrix
	glm::mat4 S_plane = glm::mat4(1.0f); //scaling matrix
	glm::mat4 M_plane = glm::mat4(1.0f); //model matrix M = T * R * S

	// stone ground material properties
	shaderPrograms[0].setVec3("material.ambient", stone_ground.ambient);
	shaderPrograms[0].setVec3("material.diffuse", stone_ground.diffuse);
	shaderPrograms[0].setVec3("material.specular", stone_ground.specular); 
	shaderPrograms[0].setFloat("material.shininess", stone_ground.shininess);

	T_plane = glm::translate(glm::mat4(1.0f), glm::vec3(0.0f, 0.0f, 0.0f)); //translation matrix
	R_plane = glm::rotate(glm::mat4(1.0f), glm::radians(rotate_plane), glm::vec3(0.0f, 1.0f, 0.0f)); //rotation matrix - could have a R_x, R_y, R_z
	S_plane = glm::scale(glm::mat4(1.0f), glm::vec3(0.1f, 0.1f, 0.1f)); //scaling matrix
	M_plane = M_plane * T_plane * R_plane * S_plane; // combine to form model matrix - NB order is very important here - scaling comes first but it goes from right to left

	shaderPrograms[0].setMat4("model", M_plane);
	
	glBindVertexArray(1);
	glBindTexture(GL_TEXTURE_2D, 1);
	glDrawArrays(GL_TRIANGLES, 0, plane_mesh.mPointCount);
#pragma endregion Draw_Ground

#pragma region Draw_Wall
	//draw wall
	glm::mat4 T_wall = glm::mat4(1.0f); //translation matrix
	glm::mat4 R_wall = glm::mat4(1.0f); //rotation matrix
	glm::mat4 S_wall = glm::mat4(1.0f); //scaling matrix
	glm::mat4 M_wall = glm::mat4(1.0f); //model matrix M = T * R * S

	T_wall = glm::translate(glm::mat4(1.0f), glm::vec3(0.0f, -30.0f, 0.0f)); //translation matrix
	R_wall = glm::rotate(glm::mat4(1.0f), glm::radians(1.0f), glm::vec3(0.0f, 1.0f, 0.0f)); //rotation matrix - could have a R_x, R_y, R_z
	S_wall = glm::scale(glm::mat4(1.0f), glm::vec3(1.0f, 1.0f, 1.0f)); //scaling matrix
	M_wall = M_plane * T_wall * R_wall * S_wall; // combine to form model matrix - NB order is very important here - scaling comes first but it goes from right to left

	shaderPrograms[0].setMat4("model", M_wall);

	glBindVertexArray(24);
	glBindTexture(GL_TEXTURE_2D, 24);
	glDrawArrays(GL_TRIANGLES, 0, wall_mesh.mPointCount);
#pragma endregion Draw_Wall

#pragma region Draw_Spiders
	// material properties
	shaderPrograms[0].setVec3("material.ambient", spider_fur.ambient);
	shaderPrograms[0].setVec3("material.diffuse", spider_fur.diffuse);
	shaderPrograms[0].setVec3("material.specular", spider_fur.specular); 
	shaderPrograms[0].setFloat("material.shininess", spider_fur.shininess);
	
	shaderPrograms[0].use();
	drawSpider(M_plane, spider1_xpos, 5.0f, spider1_zpos, 50.0f, 0.2f);
	drawSpider(M_plane, spider2_xpos, 5.0f, spider2_zpos, 107.0f, 0.2f);
	drawSpider(M_plane, spider3_xpos, 5.0f, spider3_zpos, 270.0f, 0.2f);
	drawSpider(M_plane, spider4_xpos, 5.0f, spider4_zpos, 23.0f, 0.2f);
	drawSpider(M_plane, spider5_xpos, 5.0f, spider5_zpos, 69.0f, 0.2f);
	drawSpider(M_plane, spider6_xpos, 5.0f, spider6_zpos, 138.0f, 0.2f);
	drawSpider(M_plane, spider7_xpos, 5.0f, spider7_zpos, 198.0f, 0.2f);
	drawSpider(M_plane, spider8_xpos, 5.0f, spider8_zpos, 12.0f, 0.2f);
	drawSpider(M_plane, spider9_xpos, 5.0f, spider9_zpos, 154.0f, 0.2f);
	drawSpider(M_plane, spider10_xpos, 5.0f, spider10_zpos, 289.0f, 0.2f);
	drawSpider(M_plane, spider11_xpos, 5.0f, spider11_zpos, 207.0f, 0.2f);
	drawSpider(M_plane, spider12_xpos, 5.0f, spider12_zpos, 324.0f, 0.2f);
	drawSpider(M_plane, spider13_xpos, 5.0f, spider13_zpos, 99.0f, 0.2f);
	drawSpider(M_plane, spider14_xpos, 5.0f, spider14_zpos, 143.0f, 0.2f);
	drawSpider(M_plane, spider15_xpos, 5.0f, spider15_zpos, 360.0f, 0.2f);

	if ((spider_user_xpos >= -30.0f && spider_user_xpos <= 30.0f) && (spider_user_zpos <= -20.0f && spider_user_zpos >= -95.0f)) {
		spider_user_ground_ypos = 10.0f;
		spider_user_ypos = 10.0f;
	}
	else {
		spider_user_ground_ypos = 0.0f;
		spider_user_ypos = 0.0f;
	}

	if (jump_state == 1) {
		spiderJump();
	}
	drawSpider(M_plane, spider_user_xpos, spider_user_ypos, spider_user_zpos, rotate_body, 0.4f);
#pragma endregion Draw_Spiders

#pragma region Draw_Bin
	glm::mat4 T_bin = glm::mat4(1.0f); //translation matrix
	glm::mat4 R_bin = glm::mat4(1.0f); //rotation matrix
	glm::mat4 S_bin = glm::mat4(1.0f); //scaling matrix
	glm::mat4 M_bin = glm::mat4(1.0f); //model matrix M = T * R * S

	// material properties
	shaderPrograms[0].setVec3("material.ambient", metal_bin.ambient);
	shaderPrograms[0].setVec3("material.diffuse", metal_bin.diffuse);
	shaderPrograms[0].setVec3("material.specular", metal_bin.specular); 
	shaderPrograms[0].setFloat("material.shininess", metal_bin.shininess);

	T_bin = glm::translate(glm::mat4(1.0f), glm::vec3(70.0f, 0.0f, -50.0f)); //translation matrix
	R_bin = glm::rotate(glm::mat4(1.0f), glm::radians(1.0f), glm::vec3(0.0f, 1.0f, 0.0f)); //rotation matrix - could have a R_x, R_y, R_z
	S_bin = glm::scale(glm::mat4(1.0f), glm::vec3(15.0f, 15.0f, 15.0f)); //scaling matrix
	M_bin = M_plane * T_bin * R_bin * S_bin; // combine to form model matrix - NB order is very important here - scaling comes first but it goes from right to left

	shaderPrograms[0].setMat4("model", M_bin);

	glBindVertexArray(20);
	glBindTexture(GL_TEXTURE_2D, 20);
	glDrawArrays(GL_TRIANGLES, 0, bin_mesh.mPointCount);
#pragma endregion Draw_Bin

#pragma region Draw_Rock
	glm::mat4 T_rock = glm::mat4(1.0f); //translation matrix
	glm::mat4 R_rock = glm::mat4(1.0f); //rotation matrix
	glm::mat4 S_rock = glm::mat4(1.0f); //scaling matrix
	glm::mat4 M_rock = glm::mat4(1.0f); //model matrix M = T * R * S

	// material properties
	shaderPrograms[0].setVec3("material.ambient", rock.ambient);
	shaderPrograms[0].setVec3("material.diffuse", rock.diffuse);
	shaderPrograms[0].setVec3("material.specular", rock.specular); 
	shaderPrograms[0].setFloat("material.shininess", rock.shininess);

	T_rock = glm::translate(glm::mat4(1.0f), glm::vec3(-60.0f, 0.0f, -60.0f)); //translation matrix
	R_rock = glm::rotate(glm::mat4(1.0f), glm::radians(1.0f), glm::vec3(0.0f, 1.0f, 0.0f)); //rotation matrix - could have a R_x, R_y, R_z
	S_rock = glm::scale(glm::mat4(1.0f), glm::vec3(0.6f, 0.6f, 0.6f)); //scaling matrix
	M_rock = M_plane * T_rock * R_rock * S_rock; // combine to form model matrix - NB order is very important here - scaling comes first but it goes from right to left

	shaderPrograms[0].setMat4("model", M_rock);

	glBindVertexArray(21);
	glBindTexture(GL_TEXTURE_2D, 21);
	glDrawArrays(GL_TRIANGLES, 0, rock_mesh.mPointCount);
#pragma endregion Draw_Rock

#pragma region Draw_Wood
	glm::mat4 T_wood = glm::mat4(1.0f); //translation matrix
	glm::mat4 R_wood = glm::mat4(1.0f); //rotation matrix
	glm::mat4 S_wood = glm::mat4(1.0f); //scaling matrix
	glm::mat4 M_wood = glm::mat4(1.0f); //model matrix M = T * R * S

	// material properties
	shaderPrograms[0].setVec3("material.ambient", wood.ambient);
	shaderPrograms[0].setVec3("material.diffuse", wood.diffuse);
	shaderPrograms[0].setVec3("material.specular", wood.specular); 
	shaderPrograms[0].setFloat("material.shininess", wood.shininess);

	T_wood = glm::translate(glm::mat4(1.0f), glm::vec3(0.0f, 0.0f, -40.0f)); //translation matrix
	R_wood = glm::rotate(glm::mat4(1.0f), glm::radians(1.0f), glm::vec3(0.0f, 1.0f, 0.0f)); //rotation matrix - could have a R_x, R_y, R_z
	S_wood = glm::scale(glm::mat4(1.0f), glm::vec3(0.6f, 0.6f, 0.6f)); //scaling matrix
	M_wood = M_plane * T_wood * R_wood * S_wood; // combine to form model matrix - NB order is very important here - scaling comes first but it goes from right to left

	shaderPrograms[0].setMat4("model", M_wood);

	glBindVertexArray(22);
	glBindTexture(GL_TEXTURE_2D, 22);
	glDrawArrays(GL_TRIANGLES, 0, wood_mesh.mPointCount);
#pragma endregion Draw_Wood

	glutSwapBuffers();
}
#pragma endregion Drawing_Functions

#pragma region Spider_Animation_Functions

// Make spider legs move
void animateSpider() {

	if (animate == true) {

		rotate_leg += leg_direction;

		if (rotate_leg == 9)
			leg_direction = -0.5f;
		if (rotate_leg == -9)
			leg_direction = 0.5f;

	}
}

// Make spider move in a circular path
std::tuple<float,float,float> updateSpiderPos(float xpos, float zpos, float degree, float speed, float radius, float oval_deg_x, float oval_deg_z, float dir) {
	
	float new_xpos = xpos + dir*(radius * cos(degree*(PI/180)*speed))*oval_deg_x; // cos function to simulate circular motion
	float new_zpos = zpos + dir*(radius * sin(degree*(PI/180)*speed))*oval_deg_z; // sin function to simulate circular motion
	degree += 1.0f; //increment degree 
	return make_tuple(new_xpos, new_zpos, degree); //return tuple containing the new positions of the spider and the degree
}

// Calls updateSpiderPos for each spider to move them all in their own unique circular path
void translateSpider() {
	if (animate == true) {
		float movement_speed = 3.0f;
		// tie values returned from updateSpiderPos to global variables, done for each moving spider 
		tie(spider1_xpos, spider1_zpos, spider1_deg) = updateSpiderPos(spider1_start_xpos, spider1_start_zpos, spider1_deg, movement_speed, 30.0f, 0.3f, 1.0f, -1.0f);
		tie(spider2_xpos, spider2_zpos, spider2_deg) = updateSpiderPos(spider2_start_xpos, spider2_start_zpos, spider2_deg, movement_speed, 30.0f, 0.7f, 0.2f, 1.0f);
		tie(spider3_xpos, spider3_zpos, spider3_deg) = updateSpiderPos(spider3_start_xpos, spider3_start_zpos, spider3_deg, movement_speed, 30.0f, 0.45f, 0.8f, -1.0f);
		tie(spider4_xpos, spider4_zpos, spider4_deg) = updateSpiderPos(spider4_start_xpos, spider4_start_zpos, spider4_deg, movement_speed, 30.0f, 0.1f, 0.6f, 1.0f);
		tie(spider5_xpos, spider5_zpos, spider5_deg) = updateSpiderPos(spider5_start_xpos, spider5_start_zpos, spider5_deg, movement_speed, 50.0f, 0.9f, 0.05f, -1.0f);
		tie(spider6_xpos, spider6_zpos, spider6_deg) = updateSpiderPos(spider6_start_xpos, spider6_start_zpos, spider6_deg, movement_speed, 30.0f, 0.56f, 0.25f, 1.0f);
		tie(spider7_xpos, spider7_zpos, spider7_deg) = updateSpiderPos(spider7_start_xpos, spider7_start_zpos, spider7_deg, movement_speed, 30.0f, 0.72f, 0.812f, -1.0f);
		tie(spider8_xpos, spider8_zpos, spider8_deg) = updateSpiderPos(spider8_start_xpos, spider8_start_zpos, spider8_deg, movement_speed, 30.0f, 0.987f, 0.02f, 1.0f);
		tie(spider9_xpos, spider9_zpos, spider9_deg) = updateSpiderPos(spider9_start_xpos, spider9_start_zpos, spider9_deg, movement_speed, 30.0f, 0.67f, 0.25f, -1.0f);
		tie(spider10_xpos, spider10_zpos, spider10_deg) = updateSpiderPos(spider10_start_xpos, spider10_start_zpos, spider10_deg, movement_speed, 30.0f, 0.365f, 0.42f, 1.0f);
		tie(spider11_xpos, spider11_zpos, spider11_deg) = updateSpiderPos(spider11_start_xpos, spider11_start_zpos, spider11_deg, movement_speed, 30.0f, 0.69f, 0.21f, -1.0f);
		tie(spider12_xpos, spider12_zpos, spider12_deg) = updateSpiderPos(spider12_start_xpos, spider12_start_zpos, spider12_deg, movement_speed, 30.0f, 0.47f, 0.3f, 1.0f);
		tie(spider13_xpos, spider13_zpos, spider13_deg) = updateSpiderPos(spider13_start_xpos, spider13_start_zpos, spider13_deg, movement_speed, 30.0f, 0.37f, 0.7f, -1.0f);
		tie(spider14_xpos, spider14_zpos, spider14_deg) = updateSpiderPos(spider14_start_xpos, spider14_start_zpos, spider14_deg, movement_speed, 30.0f, 0.5f, 0.98f, 1.0f);
		tie(spider15_xpos, spider15_zpos, spider15_deg) = updateSpiderPos(spider15_start_xpos, spider15_start_zpos, spider15_deg, movement_speed, 30.0f, 0.2f, 0.77f, -1.0f);
	}
}

#pragma endregion Spider_Animation_Functions

#pragma region Initialisation_Functions
void updateScene() {

	static DWORD last_time = 0;
	DWORD curr_time = timeGetTime();
	if (last_time == 0)
		last_time = curr_time;
	float delta = (curr_time - last_time) * 0.001f;
	last_time = curr_time;
	float currentFrame = timeGetTime();
	deltaTime = currentFrame - lastFrame;
	lastFrame = currentFrame;
	// Draw the next frame
	animateSpider();
	translateSpider();
	glutPostRedisplay();
}

// Function for setting different lighting variables for different materials
void defineMaterials() {
	//stone ground material
	stone_ground.ambient = glm::vec3(0.220f, 0.220f, 0.220f);
	stone_ground.diffuse = glm::vec3(0.220f, 0.220f, 0.220f);
	stone_ground.specular = glm::vec3(0.1f, 0.1f, 0.1f);
	stone_ground.shininess = 50.0f;

	//spider fur material 
	spider_fur.ambient = glm::vec3(0.1f, 0.1f, 0.1f);
	spider_fur.diffuse = glm::vec3(0.1f, 0.1f, 0.1f);
	spider_fur.specular = glm::vec3(0.9f, 0.9f, 0.9f);
	spider_fur.shininess = 90.0f;

	//metal bin material 
	metal_bin.ambient = glm::vec3(0.25f, 0.25f, 0.25f);
	metal_bin.diffuse = glm::vec3(0.4f, 0.4f, 0.4f);
	metal_bin.specular = glm::vec3(0.774597f, 0.774597f, 0.774597f);
	metal_bin.shininess = 100.0f;

	//rock material
	rock.ambient = glm::vec3(0.120f, 0.120f, 0.120f);
	rock.diffuse = glm::vec3(0.320f, 0.320f, 0.320f);
	rock.specular = glm::vec3(0.4f, 0.4f, 0.4f);
	rock.shininess = 70.0f;

	//wood material
	wood.ambient = glm::vec3(0.0f, 0.0f, 0.0f);
	wood.diffuse = glm::vec3(0.5f, 0.5f, 0.0f);
	wood.specular = glm::vec3(0.6f, 0.6f, 0.5f);
	wood.shininess = 10.0f;
}

void init()
{
	// Define shaders
	Shader shaderPhong("shaders/PhongShader.vs", "shaders/PhongShader.fs");
	shaderPrograms.push_back(shaderPhong); //shaderPrograms[0]
	Shader shaderSkybox("shaders/VertexShaderSkybox.vs", "shaders/FragmentShaderSkybox.fs");
	shaderPrograms.push_back(shaderSkybox); //shaderPrograms[1]
	// Initialise skybox shader uniform variable
	shaderSkybox.setInt("skybox", 0);

	// Initialise all materials
	defineMaterials(); 
	
	int shaderPhongNo = 0;

	// Generate VBOs for each model mesh taking the shader and texture into account
	plane_mesh = generateObjectBufferMesh(PLANE, 1, shaderPhongNo, STONE_TEX);
	body_mesh = generateObjectBufferMesh(SPIDER_BODY, 2, shaderPhongNo, HAIRY1_TEX);
	l1_t_mesh = generateObjectBufferMesh(LEG_L1_TOP, 3, shaderPhongNo, HAIRY1_TEX);
	l1_b_mesh = generateObjectBufferMesh(LEG_L1_BTM, 4, shaderPhongNo, HAIRY1_TEX);
	l2_t_mesh = generateObjectBufferMesh(LEG_L2_TOP, 5, shaderPhongNo, HAIRY1_TEX);
	l2_b_mesh = generateObjectBufferMesh(LEG_L2_BTM, 6, shaderPhongNo, HAIRY1_TEX);
	l3_t_mesh = generateObjectBufferMesh(LEG_L3_TOP, 7, shaderPhongNo, HAIRY1_TEX);
	l3_b_mesh = generateObjectBufferMesh(LEG_L3_BTM, 8, shaderPhongNo, HAIRY1_TEX);
	l4_t_mesh = generateObjectBufferMesh(LEG_L4_TOP, 9, shaderPhongNo, HAIRY1_TEX);
	l4_b_mesh = generateObjectBufferMesh(LEG_L4_BTM, 10, shaderPhongNo, HAIRY1_TEX);
	r1_t_mesh = generateObjectBufferMesh(LEG_R1_TOP, 11, shaderPhongNo, HAIRY1_TEX);
	r1_b_mesh = generateObjectBufferMesh(LEG_R1_BTM, 12, shaderPhongNo, HAIRY1_TEX);
	r2_t_mesh = generateObjectBufferMesh(LEG_R2_TOP, 13, shaderPhongNo, HAIRY1_TEX);
	r2_b_mesh = generateObjectBufferMesh(LEG_R2_BTM, 14, shaderPhongNo, HAIRY1_TEX);
	r3_t_mesh = generateObjectBufferMesh(LEG_R3_TOP, 15, shaderPhongNo, HAIRY1_TEX);
	r3_b_mesh = generateObjectBufferMesh(LEG_R3_BTM, 16, shaderPhongNo, HAIRY1_TEX);
	r4_t_mesh = generateObjectBufferMesh(LEG_R4_TOP, 17, shaderPhongNo, HAIRY1_TEX);
	r4_b_mesh = generateObjectBufferMesh(LEG_R4_BTM, 18, shaderPhongNo, HAIRY1_TEX);
	candle_mesh = generateObjectBufferMesh(CANDLE , 19, shaderPhongNo, GOLD_TEX);
	bin_mesh = generateObjectBufferMesh(BIN, 20, shaderPhongNo, METAL_TEX);
	rock_mesh = generateObjectBufferMesh(ROCK, 21, shaderPhongNo, ROCK_TEX);
	wood_mesh = generateObjectBufferMesh(WOOD, 22, shaderPhongNo, WOOD_TEX);
	skyboxSetup(23);
	wall_mesh = generateObjectBufferMesh(WALL, 24, shaderPhongNo, BRICK_TEX);
}
#pragma endregion Initialisation_Functions

#pragma region User_Interaction_Functions
void keypress(unsigned char key, int x, int y) {

	float cameraSpeed = 1.0f;

	switch (key) {
	case 'i':
		if (user_mode == 0)
			user_mode = 1;
		else if (user_mode == 1)
			user_mode = 0;
	case 'w':
		if (user_mode == 0)
			spider_user_zpos -= 2.0f;
		else if (user_mode == 1)
			cameraPos += cameraFront * (cameraSpeed);
		break;
	case 's':
		if (user_mode == 0)
			spider_user_zpos += 2.0f;
		else if (user_mode == 1)
			cameraPos -= cameraFront * (cameraSpeed);
		break;
	case 'a':
		if (user_mode == 0)
			spider_user_xpos -= 2.0f;
		else if (user_mode == 1)
			cameraPos -= glm::normalize(glm::cross(cameraFront, cameraUp)) * (cameraSpeed);
		break;
	case 'd':
		if (user_mode == 0)
			spider_user_xpos += 2.0f;
		else if (user_mode == 1)
			cameraPos += glm::normalize(glm::cross(cameraFront, cameraUp)) * (cameraSpeed);
		break;
	case 'j':
		jump_state = 1;
		jump_ascend = 1;
		break;
	case 'p':
		if (animate == false)
			animate = true;
		else if (animate == true)
			animate = false;
		break;
	case 'b':
		rotate_body += 6.0f;
		break;
	case 'r':
		rotate_plane += 3.0f;
		break;

	case 'm':
		if (light_mode == 0)
			light1_trans_x += 1.0f;
		else if (light_mode == 1)
			light2_trans_x += 1.0f;
		break;
	case 'n':
		if (light_mode == 0)
			light1_trans_x -= 1.0f;
		else if (light_mode == 1)
			light2_trans_x -= 1.0f;
		break;
	case ',':
		if (light_mode == 0)
			light1_trans_z += 1.0f;
		else if (light_mode == 1)
			light2_trans_z += 1.0f;
		break;
	case '.':
		if (light_mode == 0)
			light1_trans_z -= 1.0f;
		else if (light_mode == 1)
			light2_trans_z -= 1.0f;
		break;
	case 'l':
		if (light_mode == 0)
			light_mode = 1;
		else if (light_mode == 1)
			light_mode = 0;
	}
	glutPostRedisplay();
}

void mouse(int xpos, int ypos) {

	if (firstMouse) {
		lastX = xpos;
		lastY = ypos;
		firstMouse = false;
	}
	float xoffset = xpos - lastX;
	float yoffset = lastY - ypos;
	lastX = xpos;
	lastY = ypos;

	float sensitivity = 0.6f;
	xoffset *= sensitivity;
	yoffset *= sensitivity;

	yaw += xoffset;
	pitch += yoffset;

	if (pitch > 89.0f) {
		pitch = 89.0f;
	}
	if (pitch < -89.0f) {
		pitch = -89.0f;
	}

	glm::vec3 direction;
	direction.x = cos(glm::radians(yaw)) * cos(glm::radians(pitch));
	direction.y = sin(glm::radians(pitch));
	direction.z = sin(glm::radians(yaw)) * cos(glm::radians(pitch));
	cameraFront = glm::normalize(direction);
}

void scroll(int button, int dir, int xoffset, int yoffset) {

	float zoomSpeed = 2.0f;

	if (dir > 0) {
		//zoom in
		cameraPos += cameraFront * zoomSpeed;
	}
	else {
		//zoom out
		cameraPos -= cameraFront * zoomSpeed;
	}
}
#pragma endregion User_Interaction_Functions

#pragma region Main_Function
int main(int argc, char** argv) {
	
	// Set up the window
	glutInit(&argc, argv);
	glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB);
	glutInitWindowSize(width, height);
	glutCreateWindow("Try not to get too spooked!");

	// Tell glut where the display function is
	glutDisplayFunc(display);
	glutIdleFunc(updateScene);
	glutKeyboardFunc(keypress);
	glutPassiveMotionFunc(mouse);
	glutMouseWheelFunc(scroll);


	// A call to glewInit() must be done after glut is initialized!
	GLenum res = glewInit();
	// Check for any errors
	if (res != GLEW_OK) {
		fprintf(stderr, "Error: '%s'\n", glewGetErrorString(res));
		return 1;
	}
	

	// Set up your objects and shaders
	init();
	// Begin infinite event loop
	glutMainLoop();
	return 0;
}
#pragma endregion Main_Function
