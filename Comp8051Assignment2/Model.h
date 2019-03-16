//
//  Model.h
//  Assignment2Maybe
//
//  Created by Paul on 2019-03-09.
//  Copyright © 2019 Paul. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Vertex.h"
#import <GLKit/GLkit.h>

@class BaseEffect;

@interface Model : NSObject

@property (nonatomic, strong) BaseEffect *shader;
@property (nonatomic, assign) GLKVector3 position;
@property (nonatomic) float rotationX;
@property (nonatomic) float rotationY;
@property (nonatomic) float rotationZ;
@property (nonatomic) float scaleX;
@property (nonatomic) float scaleY;
@property (nonatomic) float scaleZ;
@property (nonatomic) GLuint texture;

- (instancetype)initWithName:(char*)name shader:(BaseEffect*)shader vertices: (Vertex*)vertices vertexCount:(unsigned int)vertexCount indices:(GLubyte*)indices indexCount:(unsigned int)indexCount;
- (void)renderWithParentModelViewMatrix:(GLKMatrix4)parentModelViewMatrix;
- (void)render:(GLKMatrix4)modelViewMatrix;
- (void)updateWithDelta:(NSTimeInterval)dt;
- (void)loadTexture:(NSString *)filename;

@end
