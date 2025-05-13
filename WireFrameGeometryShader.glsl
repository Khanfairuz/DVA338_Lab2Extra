#version 410 core
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in vec3 FragPos[];
in vec3 Normal[];

out vec3 GFragmentPos;
out vec3 GNormal;
out vec3 Barycentric;

void main() {
    // Emit vertices with barycentric coordinates
    for(int i = 0; i < 3; i++) {
        GFragmentPos = FragPos[i];
        GNormal = Normal[i];
        
        // Barycentric coordinates
        if(i == 0) Barycentric = vec3(1, 0, 0);
        else if(i == 1) Barycentric = vec3(0, 1, 0);
        else Barycentric = vec3(0, 0, 1);
        
        gl_Position = gl_in[i].gl_Position;
        EmitVertex();
    }
    EndPrimitive();
}