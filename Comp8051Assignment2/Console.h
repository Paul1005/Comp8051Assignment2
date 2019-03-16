//
//  Console.h
//  Comp8051Assignment2
//
//  Created by Jason Hutton on 2019-03-15.
//  Copyright © 2019 Paul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>
#import "BaseEffect.h"

@interface Console: NSObject

@property Boolean visible;

- (void) setupConsole: (BaseEffect*) _shader view:(GLKView *) view;

- (void) draw;

@end
