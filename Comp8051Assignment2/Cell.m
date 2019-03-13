//
//  Cell.m
//  Comp8051Assignment2
//
//  Created by Paul on 2019-03-12.
//  Copyright © 2019 Paul. All rights reserved.
//

#import "Cell.h"
#import "Plane.h"
#import "Cube.h"

@implementation Cell{
    Plane *_plane;
    Cube *_northWall, *_southWall, *_westWall, *_eastWall;
    bool northWallPresent, southWallPresent, eastWallPresent, westWallPresent;
};

-(instancetype) initWithWalls: (bool) n south: (bool) s east: (bool) e west:(bool) w numrows:(int)rows numcols:(int)cols row:(int)row col:(int)col;{
    if((self = [super init])){
        self->northWallPresent = n;
        self->southWallPresent = s;
        self->eastWallPresent = e;
        self->westWallPresent = w;
    
        if(row == 0){
            self->northWallPresent = true;
        } else if(row == rows-1){
            self->southWallPresent = true;
        }
        
        if(col == 0){
            self->westWallPresent = true;
        } else if(col == cols-1){
            self->eastWallPresent = true;
        }
        
        if(row == 0 && col == 0){
            self->northWallPresent = false;
        }
        
        if(row == rows-1 && col == cols-1){
            self->southWallPresent = false;
        }
    }
    return self;
}

- (void)createCell:(BaseEffect*)shader{
    _plane = [[Plane alloc] initWithShader: shader];
    if(northWallPresent){
        _northWall = [[Cube alloc] initWithShader: shader andTexture:@"northWall.jpg"];
    }
    if(southWallPresent){
        _southWall = [[Cube alloc] initWithShader: shader andTexture:@"southWall.jpg"];
    }
    if(eastWallPresent){
        _eastWall = [[Cube alloc] initWithShader: shader andTexture:@"eastWall.jpg"];
    }
    if(westWallPresent){
        _westWall = [[Cube alloc] initWithShader: shader andTexture:@"westWall.jpg"];
    }
}

- (void)renderWithParentModelViewMatrix:(GLKMatrix4)parentModelViewMatrix posX:(int) x posZ:(int) z {
    [_plane setPosition:GLKVector3Make(x*2, 0, z*2)];
    [_plane renderWithParentModelViewMatrix:parentModelViewMatrix];
    if(northWallPresent){
        [_northWall setPosition:GLKVector3Make(x*2, 0, z*2-0.95)];
        [_northWall setScaleZ: 0.05];
        [_northWall renderWithParentModelViewMatrix:parentModelViewMatrix];
    }
    if(southWallPresent){
        [_southWall setPosition:GLKVector3Make(x*2, 0, z*2+0.95)];
        [_southWall setScaleZ: 0.05];
        [_southWall renderWithParentModelViewMatrix:parentModelViewMatrix];
    }
    if(eastWallPresent){
        [_eastWall setPosition:GLKVector3Make(x*2+0.95, 0, z*2)];
        [_eastWall setScaleX: 0.05];
        [_eastWall renderWithParentModelViewMatrix:parentModelViewMatrix];
    }
    if(westWallPresent){
        [_westWall setPosition:GLKVector3Make(x*2-0.95, 0, z*2)];
        [_westWall setScaleX: 0.05];
        [_westWall renderWithParentModelViewMatrix:parentModelViewMatrix];
    }
}

- (void)updateWithDelta:(NSTimeInterval)dt{
    [_plane updateWithDelta:dt];
    if(northWallPresent){
        [_northWall updateWithDelta:dt];
    }
    if(southWallPresent){
        [_southWall updateWithDelta:dt];
    }
    if(eastWallPresent){
        [_eastWall updateWithDelta:dt];
    }
    if(westWallPresent){
        [_westWall updateWithDelta:dt];
    }
}

@end
