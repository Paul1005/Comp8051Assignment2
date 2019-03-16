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
    BaseEffect* _shader;
}

- (void) setupConsole: (BaseEffect*) _shader view:(GLKView *) view {
    self.visible = false;
    self->_shader = _shader;
    
    UITapGestureRecognizer * doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
    doubleTapRecognizer.numberOfTouchesRequired = 2;
    doubleTapRecognizer.numberOfTapsRequired = 2;
    [view addGestureRecognizer:doubleTapRecognizer];}

- (void) draw {

}

- (void)doubleTap:(UITapGestureRecognizer *)tap {
    self.visible = !self.visible;
}
@end
