#version 410 core
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in vec3 FragPos[];
in vec3 Normal[];  // Unused (flat shading ignores vertex normals)

out vec3 GFragmentPos;
out vec3 FlatNormal;  // Face normal (same for all fragments in the triangle)

void main() {
    // Calculate face normal using cross product
    vec3 edge1 = FragPos[1] - FragPos[0];
    vec3 edge2 = FragPos[2] - FragPos[0];
    vec3 faceNormal = normalize(cross(edge1, edge2));
    
    // Emit all 3 vertices with the same face normal
    for (int i = 0; i < 3; i++) {
        GFragmentPos = FragPos[i];
        FlatNormal = faceNormal;
        gl_Position = gl_in[i].gl_Position;
        EmitVertex();
    }
    EndPrimitive();
}