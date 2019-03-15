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
    AmbientConditions *_ambientConditions;
    
    BaseEffect *_shader;
    CreateMaze *_maze;
}

- (void) setupScene: (GLKView *) view{
    _ambientConditions = [[AmbientConditions alloc] init];
    _shader = [[BaseEffect alloc] initWithVertexShader:@"SimpleVertex.glsl" fragmentShader:@"SimpleFragment.glsl" ambientConditions:_ambientConditions];
    
    _maze = [[CreateMaze alloc] init];
    [_maze setupMaze:5 cols: 5 shader: _shader view: view];
    //[_maze setupMaze:1 cols: 1 shader: _shader view: view]; // This is a workaround for Jason, as I'm unable to run the app using a 5x5 maze, it simply refuses to load on the provided iPod Touch, and my Simulator runs far too slowly to test anything.
    
    _shader.projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(85.0), self.view.bounds.size.width / self.view.bounds.size.height, 1, 150); //fov, aspect ratio, near plane, far plane
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    GLKView *view = (GLKView *) self.view;
    view.context = [[EAGLContext alloc] initWithAPI: kEAGLRenderingAPIOpenGLES2];
    view.drawableDepthFormat = GLKViewDrawableDepthFormat16; // sets up a depth buffer
    
    // Toggle Day/Night Button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 50, 200, 10);
    button.tag = 1;
    [button setTitle:@"Toggle Day/Night" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchDown];
    [button setEnabled:YES];
    [self.view addSubview:button];
    
    // Toggle Fog Button
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeSystem];
    button2.frame = CGRectMake(0, 100, 200, 10);
    button2.tag = 2;
    [button2 setTitle:@"Toggle Fog" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchDown];
    [button2 setEnabled:YES];
    [self.view addSubview:button2];
    
    // Toggle Flashlight Button
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeSystem];
    button3.frame = CGRectMake(150, 50, 200, 10);
    button3.tag = 3;
    [button3 setTitle:@"Toggle Flashlight" forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchDown];
    [button3 setEnabled:YES];
    [self.view addSubview:button3];
    
    [EAGLContext setCurrentContext:view.context];
    [self setupScene: view];
}

-(void)onClick:(id)sender
{
    switch([sender tag]) {
        case 1:
            // Set Day to the inverse of the current Day setting.
            [_ambientConditions SetDay:![_ambientConditions GetDay]];
            break;
        case 2:
            [_ambientConditions SetFog:![_ambientConditions GetFog]];
            break;
        case 3:
            [_ambientConditions ToggleFlashlight];
            break;
            // Undefined behavior if we don't have a tag.
    }

    [self resignFirstResponder];
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect) rect{
    glClearColor(135/255, 206/255, 235.0/255.0, 1.0); // sky blue
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glEnable(GL_DEPTH_TEST);// takes care of objects drawn on top of other objects
    glEnable(GL_CULL_FACE); //takes care of the own object
    glEnable(GL_BLEND); // enables blending
    //glEnable(GL_FOG);
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
