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
#import "Cube.h"

@implementation CreateMaze{
    Maze *_maze;
    Cell *_cells[16][16];
    Cube *_entranceCube;
    GLKView * currentView;
    GLKMatrix4 viewMatrix;
    int rows;
    int cols;
}

- (void) setupMaze: (int) rows cols:(int)cols shader:(BaseEffect*)_shader view:(GLKView *) view{
    viewMatrix = GLKMatrix4MakeTranslation(0, 0, -3);
    viewMatrix = GLKMatrix4Rotate(viewMatrix, GLKMathDegreesToRadians(180),0,1,0);
    currentView = view;
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
    _entranceCube = [[Cube alloc] initWithShader:_shader andTexture:@"crate.jpg"];
}

- (void) draw{

    for(int i = 0; i<rows; i++){
        for(int j = 0; j<cols; j++){
            [_cells[i][j] renderWithParentModelViewMatrix:viewMatrix posX:j posZ:i];
        }
    }
    [_entranceCube setScaleX:0.5];
    [_entranceCube setScaleY:0.5];
    [_entranceCube setScaleZ:0.5];
    [_entranceCube renderWithParentModelViewMatrix:viewMatrix];
}

- (void) update: (NSTimeInterval) timeSinceLastUpdate{
    for(int i = 0; i<rows; i++){
        for(int j = 0; j<cols; j++){
            [_cells[i][j] updateWithDelta:timeSinceLastUpdate];
        }
    }
    [_entranceCube updateWithDelta:timeSinceLastUpdate rotate:0.5];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    CGPoint location = [touch locationInView:currentView];
    CGPoint lastLoc = [touch previousLocationInView:currentView];
    CGPoint diff = CGPointMake(lastLoc.x - location.x, lastLoc.y - location.y);
    
    viewMatrix = GLKMatrix4Rotate(viewMatrix, GLKMathDegreesToRadians(diff.x),0,1,0);
}

@end
