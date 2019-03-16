//
//  Plane.m
//  Comp8051Assignment2
//
//  Created by Paul on 2019-03-10.
//  Copyright © 2019 Paul. All rights reserved.
//

#import "Plane.h"


const static Vertex vertices[] = {
    {{1, -1, 1}, {1, 0, 0, 1}, {1, 0}, {0, 1, 0}}, // 16
    {{1, -1, -1}, {0, 1, 0, 1}, {1, 1}, {0, 1, 0}}, // 17
    {{-1, -1, -1}, {0, 0, 1, 1}, {0, 1}, {0, 1, 0}}, // 18
    {{-1, -1, 1}, {0, 0, 0, 1}, {0, 0}, {0, 1, 0}} // 19
};

const static GLubyte indices[]={
    0, 1, 2,
    2, 3, 0,
};

@implementation Plane

-(instancetype)initWithShader:(BaseEffect*)shader{
    if ((self = [super initWithName:"plane" shader:shader vertices:(Vertex*)vertices vertexCount:sizeof(vertices)/sizeof(vertices[0]) indices:(GLubyte*)indices indexCount:sizeof(indices)/sizeof(indices[0])])) {
        [self loadTexture:@"dungeon_01.png"];
        
    }
    return self;
}

-(instancetype)initWithShader:(BaseEffect*)shader andTexture:(NSString *)texture{
    if ((self = [super initWithName:"plane" shader:shader vertices:(Vertex*)vertices vertexCount:sizeof(vertices)/sizeof(vertices[0]) indices:(GLubyte*)indices indexCount:sizeof(indices)/sizeof(indices[0])])) {
        [self loadTexture:texture];
        
    }
    return self;
}
- (void)updateWithDelta:(NSTimeInterval)dt{
//empty as planes shouldn't do anything other than sit
}

@end
