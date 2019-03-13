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
#import "Plane.h"

@interface ViewController ()

@end

@implementation ViewController{
    Square *_square;
    BaseEffect *_shader;
    Cube *_cube;
    Plane *_plane;
    
    AmbientConditions *_ambientConditions;
}

- (void) setupScene{
    _ambientConditions = [[AmbientConditions alloc] init];
    _shader = [[BaseEffect alloc] initWithVertexShader:@"SimpleVertex.glsl" fragmentShader:@"SimpleFragment.glsl" ambientConditions:_ambientConditions];
    //_square = [[Square alloc] initWithShader: _shader];
    //_cube = [[Cube alloc] initWithShader: _shader];
    _plane = [[Plane alloc] initWithShader: _shader];
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
    glClearColor(135/255, 206/255, 235.0/255.0, 1.0); // sky blue
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glEnable(GL_DEPTH_TEST);// takes care of objects drawn on top of other objects
    glEnable(GL_CULL_FACE); //takes care of the own object
    glEnable(GL_BLEND); // enables blending
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA); // blends different textures, also deals with transparency
    GLKMatrix4 viewMatrix = GLKMatrix4MakeTranslation(0,-3,-5); // moves everything back by 5
    viewMatrix = GLKMatrix4Rotate(viewMatrix, GLKMathDegreesToRadians(0),1,0,0);// rotate camera up by 00 degrees
    //[_square renderWithParentModelViewMatrix:viewMatrix]; //multiplies the view matrix with the other matrices
    //[_cube renderWithParentModelViewMatrix:viewMatrix];
    [_plane renderWithParentModelViewMatrix:viewMatrix];
}

-(void)update {
    //[_square updateWithDelta:self.timeSinceLastUpdate];
    //[_cube updateWithDelta:self.timeSinceLastUpdate];
    [_plane updateWithDelta:self.timeSinceLastUpdate];
}

@end
