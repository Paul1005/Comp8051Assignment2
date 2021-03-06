varying lowp vec4 frag_Color;
varying lowp vec2 frag_TexCoord;
varying lowp vec3 frag_Normal;
varying lowp vec3 frag_Position;

void main(void) {
    frag_Color = a_Color;
    gl_Position = u_ProjectionMatrix * u_ModelViewMatrix * a_Position; //could have combined projection and modelview matrices but it is useful to keep them separate for now
    frag_TexCoord = a_TexCoord;
    frag_Normal = (u_ModelViewMatrix * vec4(a_Normal, 0)).xyz; // converts to camera coordinates
    frag_Position = (u_ModelViewMatrix * a_Position).xyz;
}
