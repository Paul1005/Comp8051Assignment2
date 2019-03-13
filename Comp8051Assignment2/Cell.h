//
//  Cell.h
//  Comp8051Assignment2
//
//  Created by Paul on 2019-03-12.
//  Copyright © 2019 Paul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseEffect.h"

@interface Cell : NSObject 

- (instancetype) initWithWalls:(bool)n south:(bool)s east:(bool)e west:(bool)w numrows:(int)rows numcols:(int)cols row:(int)row col:(int)col;

- (void)createCell:(BaseEffect*)shader;

- (void)renderWithParentModelViewMatrix:(GLKMatrix4)parentModelViewMatrix posX:(int) i posZ:(int) j;

- (void)updateWithDelta:(NSTimeInterval)dt;

@end
