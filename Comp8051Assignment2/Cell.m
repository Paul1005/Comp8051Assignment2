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
    Cube *_northWall, *_southWall, *_westWall,*_eastWall;
    bool northWallPresent, southWallPresent, eastWallPresent, westWallPresent;
};

-(instancetype) initWithWalls: (bool) n south: (bool) s east: (bool) e west:(bool) w{
    if((self = [super init])){
        self->northWallPresent = n;
        self->southWallPresent = s;
        self->eastWallPresent = e;
        self->westWallPresent = w;
    }
    return self;
}

- (void)createCell:(BaseEffect*)shader{
    _plane = [[Plane alloc] initWithShader: shader];
    if(northWallPresent){
        _northWall = [[Cube alloc] initWithShader: shader andTexture:@"northWall.jpg"];
    }else if(southWallPresent){
        _southWall = [[Cube alloc] initWithShader: shader andTexture:@"southWall.jpg"];
    }else if(eastWallPresent){
        _westWall = [[Cube alloc] initWithShader: shader andTexture:@"eastWall.jpg"];
    }else if(westWallPresent){
        _eastWall = [[Cube alloc] initWithShader: shader andTexture:@"westWall.jpg"];
    }
}

- (void)renderWithParentModelViewMatrix:(GLKMatrix4)parentModelViewMatrix posX:(int) i posZ:(int) j{
    [_plane setPosition:GLKVector3Make(i*2, 0, j*2)];
    [_plane renderWithParentModelViewMatrix:parentModelViewMatrix];
    if(northWallPresent){
        [_northWall setPosition:GLKVector3Make(i*2, 2, j*2+0.95)];
        [_northWall setScaleZ: 0.05];
        [_northWall renderWithParentModelViewMatrix:parentModelViewMatrix];
    }else if(southWallPresent){
        [_southWall setPosition:GLKVector3Make(i*2, 2, j*2-0.95)];
        [_northWall setScaleZ: 0.05];
        [_southWall renderWithParentModelViewMatrix:parentModelViewMatrix];
    }else if(eastWallPresent){
        [_eastWall setPosition:GLKVector3Make(i*2+0.95, 2, j*2)];
        [_northWall setScaleX: 0.05];
        [_eastWall renderWithParentModelViewMatrix:parentModelViewMatrix];
    }else if(westWallPresent){
        [_westWall setPosition:GLKVector3Make(i*2-0.95, 2, j*2)];
        [_northWall setScaleX: 0.05];
        [_westWall renderWithParentModelViewMatrix:parentModelViewMatrix];
    }
}

- (void)updateWithDelta:(NSTimeInterval)dt{
    [_plane updateWithDelta:dt];
    if(northWallPresent){
        [_northWall updateWithDelta:dt];
    }else if(southWallPresent){
        [_southWall updateWithDelta:dt];
    }else if(eastWallPresent){
        [_eastWall updateWithDelta:dt];
    }else if(westWallPresent){
        [_westWall updateWithDelta:dt];
    }
}

@end
