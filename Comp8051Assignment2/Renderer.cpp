//
//  Renderer.cpp
//  Comp8051Assignment2
//
//  Created by Paul on 2019-03-06.
//  Copyright © 2019 Paul. All rights reserved.
//
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <string.h>
#include <iostream>

#include "Renderer.hpp"

void Renderer::setup(){
    glGenVertexArrays(1, &vao);
    glBindVertexArray(vao);
    
    
    glGenBuffers(GLsizei(1), &vbo);
    glBindBuffer(GL_ARRAY_BUFFER, vbo);
    glBufferData(GL_ARRAY_BUFFER, sizeof(cell.getPlaneVertices()), cell.getPlaneVertices(), GL_STATIC_DRAW);
    
    glGenBuffers(GLsizei(1), &ebo);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, ebo);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(cell.getPlaneIndices()), cell.getPlaneIndices(), GL_STATIC_DRAW);
    
    
    glEnableVertexAttribArray(0);
    glVertexAttribPointer(0,3,GL_FLOAT,GL_FALSE,5 * sizeof(float),  0);
    
    
    glEnableVertexAttribArray(1);
    glVertexAttribPointer(0,4,GL_FLOAT,GL_FALSE,5 * sizeof(float), (void*)(3*sizeof(float)));
    
    glBindVertexArray(0);
    glBindBuffer(GL_ARRAY_BUFFER, 0);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);
}

void Renderer::update(){
   }

void Renderer::draw(){
    glClearColor(0, 0, 0, 0);
    glClear(GL_COLOR_BUFFER_BIT);
    
    glBindVertexArray(vao);
    
    glDrawElements(GL_TRIANGLES,     // 1
                   sizeof(cell.getPlaneIndices()),   // 2
                   GL_UNSIGNED_BYTE, // 3
                   cell.getPlaneIndices());                   // 4
    
    glBindVertexArray(0);
}


