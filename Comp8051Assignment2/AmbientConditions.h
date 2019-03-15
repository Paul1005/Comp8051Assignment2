//
//  AmbientConditions.h
//  Comp8051Assignment2
//
//  Created by Jason Hutton on 2019-03-12.
//  Copyright © 2019 Paul. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

typedef NS_OPTIONS(NSInteger, Conditions) {
    ConditionsNone      =   0,
    ConditionsDay       =   1 << 0, // Not set = night
    ConditionsFoggy     =   1 << 1 // Not set = clear
};

/* This is "Ambient" in the sense of "current surroundings" not as in ambient lighting. */
@interface AmbientConditions : NSObject

@property Conditions conditions;
@property GLfloat dayAmbient;
@property GLfloat nightAmbient;
@property GLfloat dayDiffuse;
@property GLfloat nightDiffuse;

-(instancetype)init;
-(void)SetDay:(Boolean) daytime;
-(Boolean)GetDay;
-(GLfloat)GetAmbient;
-(GLfloat)GetDiffuse;

-(void)SetFog:(Boolean) fog;
-(Boolean)GetFog;

@end


/* AmbientConditions_h */
