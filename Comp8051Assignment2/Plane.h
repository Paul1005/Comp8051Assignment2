//
//  Plane.h
//  Comp8051Assignment2
//
//  Created by Paul on 2019-03-10.
//  Copyright © 2019 Paul. All rights reserved.
//

#import "Model.h"

@interface Plane : Model

- (instancetype)initWithShader:(BaseEffect*)shader;
- (instancetype)initWithShader:(BaseEffect*)shader andTexture:(NSString *)texture;
@end
