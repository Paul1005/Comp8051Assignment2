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
    float rotY;
    float translateX;
    float translateZ;
}

- (void) setupMaze: (int) rows cols:(int)cols shader:(BaseEffect*)_shader view:(GLKView *) view{
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
    
    UITapGestureRecognizer * doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
    doubleTapRecognizer.numberOfTapsRequired = 2;
    [view addGestureRecognizer:doubleTapRecognizer];
    
    UIPanGestureRecognizer * panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(twoFingerPan:)];
    panRecognizer.minimumNumberOfTouches = 2;
    panRecognizer.maximumNumberOfTouches = 2;
    [view addGestureRecognizer:panRecognizer];
}

- (void) draw{
    viewMatrix = GLKMatrix4Identity;
    viewMatrix = GLKMatrix4Rotate(viewMatrix, GLKMathDegreesToRadians(180),0,1,0);
    viewMatrix = GLKMatrix4Rotate(viewMatrix, GLKMathDegreesToRadians(rotY),0,1,0);
    viewMatrix = GLKMatrix4Translate(viewMatrix, 0, 0, 3);
    viewMatrix = GLKMatrix4Translate(viewMatrix, translateX, 0, translateZ);
    
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
    
    rotY += -diff.x;
    translateX += -sinf(rotY)*diff.y/100;
    translateZ += -cosf(rotY)*diff.y/100;
}

- (void)doubleTap:(UITapGestureRecognizer *)tap {
    rotY = 0;
    translateX = 0;
    translateZ = 0;
}

- (void)twoFingerPan:(UIPanGestureRecognizer *)pan {
    CGPoint touchLocation = [pan locationInView:currentView];
    translateX += touchLocation.x/100;
    translateZ += touchLocation.y/100;
}

@end
