//
//  Cell.hpp
//  Comp8051Assignment2
//
//  Created by Paul on 2019-03-06.
//  Copyright © 2019 Paul. All rights reserved.
//

#ifndef Cell_hpp
#define Cell_hpp

#include <stdio.h>
#include <OpenGLES/ES3/gl.h>
#include <stdlib.h>
#include "Vertex.hpp"

class Cell
{
public:
    void CreateCell();
    Vertex* getPlaneVertices();
    GLuint* getPlaneIndices();
private:
    void CreatePlane();
    void CreateWalls();
    void CreateNorthWall();
    void CreateSouthWall();
    void CreateEastWall();
    void CreateWestWall();
};

#endif /* Cell_hpp */
