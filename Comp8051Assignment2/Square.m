//
//  Square.m
//  Assignment2Maybe
//
//  Created by Paul on 2019-03-09.
//  Copyright © 2019 Paul. All rights reserved.
//

#import "Square.h"

const static Vertex vertices[] = {
    {{1, -1, 0}, {1, 0, 0, 1}}, // V0
    {{1, 1, 0}, {0, 1, 0, 1}}, // V1
    {{-1, 1, 0}, {0, 0, 1, 1}}, // V2
    {{-1, -1, 0}, {0, 0, 0, 0}} // V3
};

const static GLubyte indices[]={
    0,1,2,
    2,3,0
};

@implementation Square

-(instancetype)initWithShader:(BaseEffect*)shader{
    if ((self = [super initWithName:"square" shader:shader vertices:(Vertex*)vertices vertexCount:sizeof(vertices)/sizeof(vertices[0]) indices:(GLubyte*)indices indexCount:sizeof(indices)/sizeof(indices[0])])) {
        
    }
    return self;
}

- (void)updateWithDelta:(NSTimeInterval)dt{
    float secsPerMove = 2;
    self.position = GLKVector3Make(sinf(CACurrentMediaTime() * 2*M_PI/secsPerMove), self.position.y, self.position.z);
}

@end
