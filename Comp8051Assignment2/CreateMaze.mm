//
//  CreateMaze.m
//  Comp8051Assignment2
//
//  Created by Paul on 2019-03-10.
//  Copyright © 2019 Paul. All rights reserved.
//

#import "CreateMaze.h"
#include "maze.h"
#import "Plane.h"

@implementation CreateMaze{
    Maze *_maze;
    Plane *_cells[16][16];
    int rows;
    int cols;
}

- (void) setupMaze: (int) rows cols:(int)cols shader:(BaseEffect*)_shader{
    self->rows = rows;
    self->cols = cols;
    _maze = new Maze(rows, cols);
    _maze->Create();
    for(int i = 0; i<rows; i++){
        for(int j = 0; j<cols; j++){
            _cells[i][j] = [[Plane alloc] initWithShader: _shader];
        }
    }
}

- (void) draw{
    GLKMatrix4 viewMatrix = GLKMatrix4MakeTranslation(-4,-3,-15); 
    viewMatrix = GLKMatrix4Rotate(viewMatrix, GLKMathDegreesToRadians(0),1,0,0);// rotate camera up by 00 degrees
    for(int i = 0; i<rows; i++){
        for(int j = 0; j<cols; j++){
            [_cells[i][j] setPosition:GLKVector3Make(i*2, 0, j*2)];
            [_cells[i][j] renderWithParentModelViewMatrix:viewMatrix];
        }
    }
}

- (void) update: (NSTimeInterval) timeSinceLastUpdate{
    for(int i = 0; i<rows; i++){
        for(int j = 0; j<cols; j++){
            [_cells[i][j] updateWithDelta:timeSinceLastUpdate];
        }
    }
}

@end
