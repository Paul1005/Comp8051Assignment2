//
//  CreateMaze.h
//  Comp8051Assignment2
//
//  Created by Paul on 2019-03-10.
//  Copyright © 2019 Paul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseEffect.h"

@interface CreateMaze: NSObject

- (void) setupMaze: (int) rows cols:(int)cols shader:(BaseEffect*)_shader view:(GLKView *) view;

- (void) draw;

- (void) update: (NSTimeInterval) timeSinceLastUpdate;

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;

@end
