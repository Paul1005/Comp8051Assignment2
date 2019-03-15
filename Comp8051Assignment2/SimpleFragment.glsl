varying lowp vec4 frag_Color;
varying lowp vec2 frag_TexCoord;
varying lowp vec3 frag_Normal;
varying lowp vec3 frag_Position;

uniform sampler2D u_Texture; // keeps track of the texture coordinate slot to use
uniform highp float u_MatSpecularIntensity;
uniform highp float u_Shininess;

struct Light {
    lowp vec3 Color;
    lowp float AmbientIntensity;
    lowp float DiffuseIntensity;
    lowp vec3 Direction;
};

struct SpotLight {
    lowp vec3 position;
    lowp vec3 direction;
    lowp float cutOff;
};

uniform Light u_Light;
uniform SpotLight u_SpotLight;

const lowp vec3 fogColor = vec3(0.5, 0.5,0.5);
const lowp float FogDensity = 0.05;

void main(void) {
    lowp vec3 lightDir = normalize(u_SpotLight.position - frag_Position);
    
    // check if lighting is inside the spotlight cone
    lowp float theta = dot(lightDir, normalize(-u_SpotLight.direction));
    
    lowp float distance = length(vec4(frag_Position, 1));;
    lowp float fogFactor = 1.0 /exp(distance * FogDensity);;
    fogFactor = clamp( fogFactor, 0.0, 1.0 );
    
    // Ambient
    lowp vec3 AmbientColor = u_Light.Color * u_Light.AmbientIntensity;
    
    if(theta > u_SpotLight.cutOff){
        AmbientColor += 0.5;
    }
    
    //Diffuse
    lowp vec3 Normal = normalize(frag_Normal); // normalize the normal b/c it might not be normal anymore after being interpelated
    lowp float DiffuseFactor = max(-dot(Normal, u_Light.Direction), 0.0);
    lowp vec3 DiffuseColor = u_Light.Color * u_Light.DiffuseIntensity * DiffuseFactor;
    
    // Specular
    lowp vec3 Eye = normalize(frag_Position);// normal vector pointing towards the fragment from the eye/camera
    lowp vec3 Reflection = reflect(u_Light.Direction, Normal); // light reflection about the normal
    lowp float SpecularFactor = pow(max(0.0, -dot(Reflection, Eye)), u_Shininess);
    lowp vec3 SpecularColor = u_Light.Color * u_MatSpecularIntensity * SpecularFactor;
    
    gl_FragColor = texture2D(u_Texture, frag_TexCoord) * vec4(mix(fogColor, (AmbientColor + DiffuseColor + SpecularColor), fogFactor),1);;
}
