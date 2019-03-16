//
//  Console.m
//  Comp8051Assignment2
//
//  Created by Jason Hutton on 2019-03-15.
//  Copyright © 2019 Paul. All rights reserved.
//

#import "Console.h"


@implementation Console {
    GLKView * currentView;
    GLKMatrix4 viewMatrix;
    BaseEffect* _shader;
    Plane *_consolePlane;
}

- (void) setupConsole: (BaseEffect*) _shader view:(GLKView *) view {
    self.visible = false;
    self->_shader = _shader;
    
    _consolePlane = [[Plane alloc] initWithShader:_shader andTexture:@"crate.jpg"];
    
    UITapGestureRecognizer * doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
    doubleTapRecognizer.numberOfTouchesRequired = 2;
    doubleTapRecognizer.numberOfTapsRequired = 2;
    [view addGestureRecognizer:doubleTapRecognizer];
}

- (void)renderWithParentModelViewMatrix:(GLKMatrix4)parentModelViewMatrix posX:(int) x posZ:(int) z {
    [_consolePlane setPosition:GLKVector3Make(x*2, 0, z*2)];
}

- (void) draw {
    viewMatrix = GLKMatrix4Identity;
    viewMatrix = GLKMatrix4Translate(viewMatrix, 0, 0, -5);
    
    [_consolePlane setScaleX:0.5];
    [_consolePlane setScaleY:0.5];
    [_consolePlane setScaleZ:0.5];
    [_consolePlane render:viewMatrix];}

- (void)doubleTap:(UITapGestureRecognizer *)tap {
    self.visible = !self.visible;
}

@end
