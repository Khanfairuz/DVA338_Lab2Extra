#version 410 core
in vec3 GFragmentPos;
in vec3 FlatNormal;
out vec4 FragColor;

uniform vec3 lightPos;
uniform vec3 viewPos;
uniform vec3 matAmbient;
uniform vec3 matDiffuse;
uniform vec3 matSpecular;
uniform float matShininess;

void main() {
    vec3 norm = normalize(FlatNormal);  // Uses face normal (not interpolated)
    vec3 lightDir = normalize(lightPos - GFragmentPos);
    
    // Ambient
    vec3 ambient = 0.2 * matAmbient;
    
    // Diffuse (quantized for cartoon-like effect)
    float diff = max(dot(norm, lightDir), 0.0);
    if (diff > 0.8) diff = 1.0;
    else if (diff > 0.6) diff = 0.8;
    else if (diff > 0.4) diff = 0.6;
    else if (diff > 0.2) diff = 0.4;
    else diff = 0.2;
    
    vec3 diffuse = diff * matDiffuse;
    FragColor = vec4(ambient + diffuse, 1.0);
}