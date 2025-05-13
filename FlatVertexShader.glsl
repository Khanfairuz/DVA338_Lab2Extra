#version 410 core
layout(location = 0) in vec3 vPos;
layout(location = 1) in vec3 vNorm;
out vec3 FragPos;
out vec3 Normal;
uniform mat4 PV;
uniform mat4 M;

void main() {
    FragPos = vec3(M * vec4(vPos, 1.0));  // World-space position
    Normal = mat3(transpose(inverse(M))) * vNorm;  // Will be overridden by geometry shader
    gl_Position = PV * vec4(vPos, 1.0);  // Clip-space position
}