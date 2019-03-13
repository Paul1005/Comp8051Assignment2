//
//  CreateMaze.m
//  Comp8051Assignment2
//
//  Created by Paul on 2019-03-10.
//  Copyright © 2019 Paul. All rights reserved.
//

#import "CreateMaze.h"
#include "maze.h"
#import "Cell.h"

@implementation CreateMaze{
    Maze *_maze;
    Cell *_cells[16][16];
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
            _cells[i][j] = [[Cell alloc] initWithWalls:_maze->GetCell(i, j).northWallPresent south:_maze->GetCell(i, j).southWallPresent east:_maze->GetCell(i, j).eastWallPresent west:_maze->GetCell(i, j).westWallPresent numrows:rows numcols:cols row:i col:j];
            [_cells[i][j] createCell:_shader];
        }
    }
}

- (void) draw{
    GLKMatrix4 viewMatrix = GLKMatrix4MakeTranslation(-4,-3,-15);
    viewMatrix = GLKMatrix4Rotate(viewMatrix, GLKMathDegreesToRadians(20),1,0,0);
    viewMatrix = GLKMatrix4Rotate(viewMatrix, GLKMathDegreesToRadians(55),0,1,0);
    for(int i = 0; i<rows; i++){
        for(int j = 0; j<cols; j++){
            [_cells[i][j] renderWithParentModelViewMatrix:viewMatrix posX:i posZ:j];
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
