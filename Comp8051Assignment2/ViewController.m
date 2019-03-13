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

@interface ViewController ()

@end

@implementation ViewController{
    BaseEffect *_shader;
    CreateMaze *_maze;
}

- (void) setupScene: (GLKView *) view{
    _shader = [[BaseEffect alloc] initWithVertexShader:@"SimpleVertex.glsl" fragmentShader:@"SimpleFragment.glsl"];
    
    _maze = [[CreateMaze alloc] init];
    [_maze setupMaze:5 cols: 5 shader: _shader view: view];
    
    _shader.projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(85.0), self.view.bounds.size.width / self.view.bounds.size.height, 1, 150); //fov, aspect ratio, near plane, far plane
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    GLKView *view = (GLKView *) self.view;
    view.context = [[EAGLContext alloc] initWithAPI: kEAGLRenderingAPIOpenGLES2];
    view.drawableDepthFormat = GLKViewDrawableDepthFormat16; // sets up a depth buffer
    
    [EAGLContext setCurrentContext:view.context];
    
    [self setupScene: view];
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect) rect{
    glClearColor(135/255, 206/255, 235.0/255.0, 1.0); // sky blue
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glEnable(GL_DEPTH_TEST);// takes care of objects drawn on top of other objects
    glEnable(GL_CULL_FACE); //takes care of the own object
    glEnable(GL_BLEND); // enables blending
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA); // blends different textures, also deals with transparency

    [_maze draw];
}

-(void)update {
    [_maze update: self.timeSinceLastUpdate];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [_maze touchesMoved:touches withEvent:event]; // ###
}

@end
