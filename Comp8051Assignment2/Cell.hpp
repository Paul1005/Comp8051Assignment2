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
    int CreateCell();
private:
    int CreatePlane();
    int CreateWalls();
    int CreateNorthWall();
    int CreateSouthWall();
    int CreateEastWall();
    int CreateWestWall();
};

#endif /* Cell_hpp */
