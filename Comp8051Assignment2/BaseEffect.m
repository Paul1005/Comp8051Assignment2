//
//  RWTBaseEffect.m
//  HelloOpenGL
//
//  Created by Ray Wenderlich on 9/3/13.
//  Copyright (c) 2013 Ray Wenderlich. All rights reserved.
//

#import "BaseEffect.h"
#import "Vertex.h"
#import "AmbientConditions.h"

@implementation BaseEffect {
    GLuint _programHandle;
    GLuint _modelViewMatrixUniform; //location of _modelViewMatrixUniform
    GLuint _projectionMatrixUniform;
    GLuint _texUniform;
    GLuint _lightColorUniform;
    GLuint _lightAmbientIntensityUniform;
    GLuint _lightDiffuseIntensityUniform;
    GLuint _lightDirectionUniform;
    GLuint _matSpecularIntensityUniform;
    GLuint _shininessUniform;
    GLuint _fogEnabledUniform;
    GLuint _spotLightDirectionUniform;
    GLuint _spotLightPositionUniform;
    GLuint _spotLightCutOffUniform;
    GLuint _spotLightIsOnUniform;
    
    AmbientConditions *_ambientConditions;
}

- (GLuint)compileShader:(NSString*)shaderName withType:(GLenum)shaderType {
    NSString* shaderPath = [[NSBundle mainBundle] pathForResource:shaderName ofType:nil];
    NSError* error;
    NSString* shaderString = [NSString stringWithContentsOfFile:shaderPath encoding:NSUTF8StringEncoding error:&error];
    if (!shaderString) {
        NSLog(@"Error loading shader: %@", error.localizedDescription);
        exit(1);
    }
    
    GLuint shaderHandle = glCreateShader(shaderType);
    
    const char * shaderStringUTF8 = [shaderString UTF8String];
    int shaderStringLength = (int)[shaderString length];
    glShaderSource(shaderHandle, 1, &shaderStringUTF8, &shaderStringLength);
    
    glCompileShader(shaderHandle);
    
    GLint compileSuccess;
    glGetShaderiv(shaderHandle, GL_COMPILE_STATUS, &compileSuccess);
    if (compileSuccess == GL_FALSE) {
        GLchar messages[256];
        glGetShaderInfoLog(shaderHandle, sizeof(messages), 0, &messages[0]);
        NSString *messageString = [NSString stringWithUTF8String:messages];
        NSLog(@"%@", messageString);
        exit(1);
    }
    
    return shaderHandle;
}

- (void)compileVertexShader:(NSString *)vertexShader
             fragmentShader:(NSString *)fragmentShader {
    GLuint vertexShaderName = [self compileShader:vertexShader
                                         withType:GL_VERTEX_SHADER];
    GLuint fragmentShaderName = [self compileShader:fragmentShader
                                           withType:GL_FRAGMENT_SHADER];
    
    _programHandle = glCreateProgram();
    glAttachShader(_programHandle, vertexShaderName);
    glAttachShader(_programHandle, fragmentShaderName);
    
    //VertexAttribPositions
    glBindAttribLocation(_programHandle, VertexAttribPosition, "a_Position");
    glBindAttribLocation(_programHandle, VertexAttribColor, "a_Color");
    glBindAttribLocation(_programHandle, VertexAttribTexCoord, "a_TexCoord");
    glBindAttribLocation(_programHandle, VertexAttribNormal, "a_Normal");
    
    glLinkProgram(_programHandle);
    
    //Uniform matrices, must be after linking
    self.modelViewMatrix = GLKMatrix4Identity; //default value
    _modelViewMatrixUniform = glGetUniformLocation(_programHandle, "u_ModelViewMatrix");
    _projectionMatrixUniform = glGetUniformLocation(_programHandle, "u_ProjectionMatrix");
    _texUniform = glGetUniformLocation(_programHandle, "u_Texture");
    _lightColorUniform = glGetUniformLocation(_programHandle, "u_Light.Color"); // use strcut name.attribute name
    _lightAmbientIntensityUniform = glGetUniformLocation(_programHandle, "u_Light.AmbientIntensity");
    _lightDiffuseIntensityUniform = glGetUniformLocation(_programHandle, "u_Light.DiffuseIntensity"); // use strcut name.attribute name
    _lightDirectionUniform = glGetUniformLocation(_programHandle, "u_Light.Direction");
    _matSpecularIntensityUniform = glGetUniformLocation(_programHandle, "u_MatSpecularIntensity");
    _shininessUniform = glGetUniformLocation(_programHandle, "u_Shininess");
    
    _fogEnabledUniform = glGetUniformLocation(_programHandle, "u_FogEnabled");
    
    _spotLightDirectionUniform = glGetUniformLocation(_programHandle, "u_SpotLight.direction");
    _spotLightPositionUniform = glGetUniformLocation(_programHandle, "u_SpotLight.position");
    _spotLightCutOffUniform = glGetUniformLocation(_programHandle, "u_SpotLight.cutOff");
    _spotLightIsOnUniform = glGetUniformLocation(_programHandle, "u_SpotLight.isOn");
    
    GLint linkSuccess;
    glGetProgramiv(_programHandle, GL_LINK_STATUS, &linkSuccess);
    if (linkSuccess == GL_FALSE) {
        GLchar messages[256];
        glGetProgramInfoLog(_programHandle, sizeof(messages), 0, &messages[0]);
        NSString *messageString = [NSString stringWithUTF8String:messages];
        NSLog(@"%@", messageString);
        exit(1);
    }
}

- (void)prepareToDraw {
    glUseProgram(_programHandle);
    
    //transformation matrices
    glUniformMatrix4fv(_modelViewMatrixUniform, 1, 0, self.modelViewMatrix.m);// location, 1 matrix, no transpose, raw data
    glUniformMatrix4fv(_projectionMatrixUniform, 1, 0, self.projectionMatrix.m);
    
    glActiveTexture(GL_TEXTURE1); //could be any texture slot
    glBindTexture(GL_TEXTURE_2D, self.texture); //loads a 2d texture
    
    //textures
    glUniform1i(_texUniform, 1); // for 1 integer, we're using texture unit one
    
    //ambient lighting
    glUniform3f(_lightColorUniform, 1.0, 1.0, 1.0); // 3 floats
    glUniform1f(_lightAmbientIntensityUniform, [_ambientConditions GetAmbient]); // 1 float
    
    //diffuse lighting
    GLKVector3 lightDirection = GLKVector3Normalize(GLKVector3Make(0,-1,0)); //from the top of the subject
    glUniform3f(_lightDirectionUniform, lightDirection.x, lightDirection.y, lightDirection.z); //uses normalized vector
    glUniform1f(_lightDiffuseIntensityUniform, [_ambientConditions GetDiffuse]);
    
    //specular lighting
    glUniform1f(_matSpecularIntensityUniform, 2.0);
    glUniform1f(_shininessUniform, 8.0);
    
    // fog
    glUniform1i(_fogEnabledUniform, [_ambientConditions GetFog] ? 1 : 0);
    
    //spotlight
    glUniform1i(_spotLightIsOnUniform, [_ambientConditions GetFlashlightStatus]);
    glUniform3f(_spotLightDirectionUniform, 0, 0, -1); //uses normalized vector
    glUniform3f(_spotLightPositionUniform, 0, 0, 3); //uses normalized vector
    glUniform1f(_spotLightCutOffUniform, 6.25);
    
    /*lowp vec3 lightDir = normalize(u_SpotLight.position - frag_Position);
    float theta = GLKVector3DotProduct(lightDir, normalize(-u_SpotLight.direction));*/
}

- (instancetype)initWithVertexShader:(NSString *)vertexShader fragmentShader:
(NSString *)fragmentShader ambientConditions:(AmbientConditions *) ambientConditions{
    if ((self = [super init])) {
        _ambientConditions = ambientConditions;
        [self compileVertexShader:vertexShader fragmentShader:fragmentShader];
    }
    return self;
}

@end
