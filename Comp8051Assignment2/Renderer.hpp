//
//  Renderer.hpp
//  Comp8051Assignment2
//
//  Created by Paul on 2019-03-06.
//  Copyright © 2019 Paul. All rights reserved.
//

#ifndef Renderer_hpp
#define Renderer_hpp

#include "Cell.hpp"
#include <stdio.h>
#include <OpenGLES/ES2/gl.h>

class Renderer
{
    unsigned int vbo, vao, ebo;
    Cell cell;
public:
    void setup();
    void update();
    void draw();
    Cell getCell();
    char *LoadShaderFile(const char *shaderFileName);
    GLuint LoadShader(GLenum type, const char *shaderSrc);
    GLuint LoadProgram(const char *vertShaderSrc, const char *fragShaderSrc);
};

#endif /* Renderer_hpp */
