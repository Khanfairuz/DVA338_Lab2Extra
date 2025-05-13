#version 410 core
in vec3 FragPos;
in vec3 Normal;
out vec4 FragColor;
uniform vec3 lightPos;
uniform vec3 viewPos;
uniform vec3 matAmbient;
uniform vec3 matDiffuse;
uniform vec3 matSpecular;
uniform float matShininess;
void main() {
    // Light properties
    vec3 lightAmbient = vec3(0.2);
    vec3 lightDiffuse = vec3(0.9, 0.9, 0.7);
    vec3 lightSpecular = vec3(1.0);
    // Ambient
    vec3 ambient = lightAmbient * matAmbient;
    // Diffuse
    vec3 norm = normalize(Normal);
    vec3 lightDir = normalize(lightPos - FragPos);
    float diff = max(dot(norm, lightDir), 0.0);
    vec3 diffuse = lightDiffuse * (diff * matDiffuse);
    // Specular
    vec3 viewDir = normalize(viewPos - FragPos);
    vec3 reflectDir = reflect(-lightDir, norm);
    float spec = pow(max(dot(viewDir, reflectDir), 0.0), matShininess);
    vec3 specular = lightSpecular * (spec * matSpecular);
    vec3 result = ambient + diffuse + specular;
    FragColor = vec4(result, 1.0);
}