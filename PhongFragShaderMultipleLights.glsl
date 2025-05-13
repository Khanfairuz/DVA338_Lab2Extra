#version 410 core
in vec3 FragPos;
in vec3 Normal;
out vec4 FragColor;

// Material properties from CPU
uniform vec3 matAmbient;
uniform vec3 matDiffuse;
uniform vec3 matSpecular;
uniform float matShininess;

// Camera position
uniform vec3 viewPos;

// Light structure
struct Light {
    vec3 position;
    vec3 ambient;
    vec3 diffuse;
    vec3 specular;
};

// Array of lights (2 lights)
uniform Light lights[2];

vec3 calculateLight(Light light, vec3 normal, vec3 fragPos, vec3 viewDir) {
    // Ambient
    vec3 ambient = light.ambient * matAmbient;
    
    // Diffuse 
    vec3 lightDir = normalize(light.position - fragPos);
    float diff = max(dot(normal, lightDir), 0.0);
    vec3 diffuse = light.diffuse * (diff * matDiffuse);
    
    // Specular
    vec3 reflectDir = reflect(-lightDir, normal);  
    float spec = pow(max(dot(viewDir, reflectDir), 0.0), matShininess);
    vec3 specular = light.specular * (spec * matSpecular);
    
    return (ambient + diffuse + specular);
}

void main() {
    vec3 norm = normalize(Normal);
    vec3 viewDir = normalize(viewPos - FragPos);
    
    // Calculate lighting from all lights
    vec3 result = vec3(0.0);
    for(int i = 0; i < 2; i++) {
        result += calculateLight(lights[i], norm, FragPos, viewDir);
    }
    
    FragColor = vec4(result, 1.0);
}