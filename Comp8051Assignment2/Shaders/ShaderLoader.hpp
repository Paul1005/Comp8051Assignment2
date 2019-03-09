//
//  ShaderLoader.hpp
//  Comp8051Assignment2
//
//  Created by Paul on 2019-03-09.
//  Copyright © 2019 Paul. All rights reserved.
//

#ifndef ShaderLoader_hpp
#define ShaderLoader_hpp

#include <stdio.h>

#include <OpenGLES/ES3/gl.h>

class ShaderLoader
{
public:
    char *LoadShaderFile(const char *shaderFileName);
    GLuint LoadShader(GLenum type, const char *shaderSrc);
    GLuint LoadProgram(const char *vertShaderSrc, const char *fragShaderSrc);
    
};
#endif /* GLESRenderer_hpp */
