//
//  BridgeFile.m
//  Comp8051Assignment2
//
//  Created by Paul on 2019-03-08.
//  Copyright © 2019 Paul. All rights reserved.
//

#import "BridgeFile.h"
#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
#include <chrono>
#include "Renderer.hpp"

// Uniform index.
enum
{
    UNIFORM_MODELVIEW_MATRIX,
    UNIFORM_PROJECTION_MATRIX

};
GLint uniforms[2];

@interface BridgeFile () {
    GLKView *theView;
    Renderer renderer;
}

@end
@implementation BridgeFile


- (void)update{
    GLKView *theView;
    float aspect = (float)theView.drawableWidth / (float)theView.drawableHeight;
    GLKMatrix4 perspective = GLKMatrix4MakePerspective(60.0f * M_PI / 180.0f, aspect, 1.0f, 20.0f);
    
    glUniformMatrix4fv(uniforms[UNIFORM_PROJECTION_MATRIX], 1, GLboolean(GL_FALSE), perspective.m);
    
    GLKMatrix4 modelView = GLKMatrix4Identity;
    glUniformMatrix4fv(uniforms[UNIFORM_MODELVIEW_MATRIX], 1, GLboolean(GL_FALSE), modelView.m);
    
    renderer.update();
}
- (void)draw:(CGRect)drawRect{
    renderer.draw();
}
@end
