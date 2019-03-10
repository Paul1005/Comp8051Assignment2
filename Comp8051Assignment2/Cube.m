//
//  Cube.m
//  Assignment2Maybe
//
//  Created by Paul on 2019-03-09.
//  Copyright © 2019 Paul. All rights reserved.
//

#import "Cube.h"

const static Vertex vertices[] = {
    // Front
    {{1,-1,1},{1,0,0,1}},
    {{1,1,1},{1,0,0,1}},
    {{-1,1,1},{0,1,0,1}},
    {{-1,-1,1},{0,1,0,1}},
    
    // Back
    {{-1,-1,-1},{1,0,0,1}},
    {{-1,1,-1},{1,0,0,1}},
    {{1,1,-1},{0,1,0,1}},
    {{1,-1,-1},{0,1,0,1}},
};

const static GLubyte indices[] = {
    // Front
    0,1,2,
    2,3,0,
    // Back
    4,5,6,
    6,7,4,
    // Left
    3,2,5,
    5,4,3,
    // Right
    7,6,1,
    1,0,7,
    // Top
    1,6,5,
    5,2,1,
    // Bottom
    3,4,7,
    7,0,3
};

@implementation Cube

-(instancetype)initWithShader:(BaseEffect*)shader{
    if ((self = [super initWithName:"cube" shader:shader vertices:(Vertex*)vertices vertexCount:sizeof(vertices)/sizeof(vertices[0]) indices:(GLubyte*)indices indexCount:sizeof(indices)/sizeof(indices[0])])) {
        
    }
    return self;
}

- (void)updateWithDelta:(NSTimeInterval)dt{
    self.rotationZ += M_PI * dt;
    self.rotationY += M_PI * dt;
}

@end
