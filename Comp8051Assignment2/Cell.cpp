//
//  Cell.cpp
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
#include "Cell.hpp"

Vertex planeVertices[];

int Cell::CreateCell(){
    CreatePlane();
    CreateWalls();
    return 1;
}

int Cell::CreatePlane()
{
    planeVertices =
    {
        Vertex(1,0,-1),
        Vertex(1,0,1),
        Vertex(-1,0,1),
        Vertex(-1,0,-1)
    };
    
    GLuint indices[]= {
        0, 1, 2,
        2, 3, 0
    }
}

int Cell::CreateWalls(){
    
}

int Cell::CreateEastWall(){
    
}

int Cell::CreateWestWall(){
    
}

int Cell::CreateNorthWall(){
    
}

int Cell::CreateSouthWall(){
    
}
