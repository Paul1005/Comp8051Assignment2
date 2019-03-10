//
//  ViewController.m
//  Assignment2Maybe
//
//  Created by Paul on 2019-03-09.
//  Copyright © 2019 Paul. All rights reserved.
//

#import "ViewController.h"
#import "Vertex.h"
#import "BaseEffect.h"
#import "Square.h"
#import "Cube.h"
@interface ViewController ()

@end

@implementation ViewController{
    Square *_square;
    BaseEffect *_shader;
    Cube *_cube;
}

- (void) setupScene{
    _shader = [[BaseEffect alloc] initWithVertexShader:@"SimpleVertex.glsl" fragmentShader:@"SimpleFragment.glsl"];
    _square = [[Square alloc] initWithShader: _shader];
    _cube = [[Cube alloc] initWithShader: _shader];
    _shader.projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(85.0), self.view.bounds.size.width / self.view.bounds.size.height, 1, 150); //fov, aspect ratio, near plane, far plane
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    GLKView *view = (GLKView *) self.view;
    view.context = [[EAGLContext alloc] initWithAPI: kEAGLRenderingAPIOpenGLES2];
    view.drawableDepthFormat = GLKViewDrawableDepthFormat16; // sets up a depth buffer
    
    [EAGLContext setCurrentContext:view.context];
    [self setupScene];
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect) rect{
    glClearColor(0, 104.0/255, 55.0/255.0, 1.0);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glEnable(GL_DEPTH_TEST);// takes care of objects drawn on top of other objects
    glEnable(GL_CULL_FACE); //takes care of the own object
    
    GLKMatrix4 viewMatrix = GLKMatrix4MakeTranslation(0,-1,-5); // moves everything down by one and back by 5
    //[_square renderWithParentModelViewMatrix:viewMatrix]; //multiplies the view matrix with the other matrices
    [_cube renderWithParentModelViewMatrix:viewMatrix];
}

-(void)update {
    //[_square updateWithDelta:self.timeSinceLastUpdate];
    [_cube updateWithDelta:self.timeSinceLastUpdate];
}

@end
