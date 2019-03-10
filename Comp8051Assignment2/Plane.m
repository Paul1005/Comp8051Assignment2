//
//  Plane.m
//  Comp8051Assignment2
//
//  Created by Paul on 2019-03-10.
//  Copyright © 2019 Paul. All rights reserved.
//

#import "Plane.h"


const static Vertex vertices[] = {
    {{1,1,1},{1,1,0,1}},
    {{-1,1,1},{1,1,0,1}},
    {{-1,1,-1},{1,1,0,1}},
    {{1,1,-1},{1,1,0,1}},
};

const static GLubyte indices[]={
    0,3,2,
    2,1,0,
};

@implementation Plane

-(instancetype)initWithShader:(BaseEffect*)shader{
    if ((self = [super initWithName:"plane" shader:shader vertices:(Vertex*)vertices vertexCount:sizeof(vertices)/sizeof(vertices[0]) indices:(GLubyte*)indices indexCount:sizeof(indices)/sizeof(indices[0])])) {
        
    }
    return self;
}

- (void)updateWithDelta:(NSTimeInterval)dt{
//empty as planes shouldn't do anything other than sit
}

@end
