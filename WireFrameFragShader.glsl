#version 410 core
in vec3 GFragmentPos;
in vec3 GNormal;
in vec3 Barycentric;
out vec4 FragColor;

uniform vec3 lightPos;
uniform vec3 viewPos;
uniform vec3 matDiffuse;
uniform vec3 matAmbient;
uniform float wireWidth = 0.8;
uniform vec3 wireColor = vec3(0.0);

float edgeFactor() {
    vec3 d = fwidth(Barycentric);
    vec3 a3 = smoothstep(vec3(0.0), d * wireWidth, Barycentric);
    return min(min(a3.x, a3.y), a3.z);
}

void main() {
    // Basic lighting
    vec3 lightDir = normalize(lightPos - GFragmentPos);
    vec3 viewDir = normalize(viewPos - GFragmentPos);
    vec3 normal = normalize(GNormal);
    
    // Diffuse lighting
    float diff = max(dot(normal, lightDir), 0.0);
    vec3 diffuse = diff * matDiffuse;
    
    // Combine with wireframe
    float ef = edgeFactor();
    vec3 color = mix(wireColor, matAmbient + diffuse, ef);
    
    // Hidden line removal
    float facing = 1.0 - abs(dot(normal, viewDir));
    color *= mix(1.0, 0.3, facing);
    
    FragColor = vec4(color, 1.0);
}