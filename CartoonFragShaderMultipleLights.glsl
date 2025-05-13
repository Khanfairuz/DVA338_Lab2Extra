#version 410 core
in vec3 FragPos;
in vec3 Normal;
out vec4 FragColor;

uniform vec3 matDiffuse;
uniform vec3 matAmbient;

struct Light {
    vec3 position;
    vec3 diffuseColor; // Added color variation
    float intensity;
};
uniform Light lights[2]; // Exactly 2 lights matching your renderMesh

float quantizeDiffuse(float diff) {
    if (diff > 0.8) return 1.0;
    else if (diff > 0.6) return 0.8;
    else if (diff > 0.4) return 0.6;
    else if (diff > 0.2) return 0.4;
    else return 0.2;
}

void main() {
    vec3 norm = normalize(Normal);
    vec3 ambient = 0.1 * matAmbient;
    vec3 totalDiffuse = vec3(0.0);

    for (int i = 0; i < 2; i++) {
        vec3 lightDir = normalize(lights[i].position - FragPos);
        float diff = max(dot(norm, lightDir), 0.0);
        diff = quantizeDiffuse(diff);
        totalDiffuse += diff * matDiffuse * lights[i].diffuseColor * lights[i].intensity;
    }

    vec3 result = ambient + totalDiffuse;
    FragColor = vec4(result, 1.0);
}