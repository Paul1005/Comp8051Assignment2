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

Vertex planeVertices[]=
{
    Vertex(1,0,-1),
    Vertex(1,0,1),
    Vertex(-1,0,1),
    Vertex(-1,0,-1)
};

GLuint planeIndices[]=
{
    0, 1, 2,
    2, 3, 0
};

void Cell::CreateCell(){
    CreatePlane();
    CreateWalls();
}

Vertex* getPlaneVertices(){
    return planeVertices;
};

GLuint* getPlaneIndices(){
    return planeIndices;
};

void Cell::CreatePlane()
{

}

void Cell::CreateWalls(){
    
}

void Cell::CreateEastWall(){
    
}

void Cell::CreateWestWall(){
    
}

void Cell::CreateNorthWall(){
    
}

void Cell::CreateSouthWall(){
    
}
