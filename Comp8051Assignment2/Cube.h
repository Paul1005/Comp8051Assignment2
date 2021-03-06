//
//  Cube.h
//  Assignment2Maybe
//
//  Created by Paul on 2019-03-09.
//  Copyright © 2019 Paul. All rights reserved.
//

#import "Model.h"

@interface Cube : Model

- (instancetype)initWithShader:(BaseEffect*)shader;

- (instancetype)initWithShader:(BaseEffect*)shader andTexture:(NSString *)texture;

- (void)updateWithDelta:(NSTimeInterval)dt rotate: (float)rot;

@end
