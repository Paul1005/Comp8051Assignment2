//
//  AmbientConditions.m
//  Comp8051Assignment2
//
//  Created by Jason Hutton on 2019-03-12.
//  Copyright © 2019 Paul. All rights reserved.
//

#import "AmbientConditions.h"

//enum conditions { day, night, foggy, clear } ambientConditions;
//typedef enum conditions conditions_type;

@implementation AmbientConditions

-(instancetype)init {
    if((self = [super init])){
        /* Setup default values */
        self.dayAmbient = 0.5;
        self.nightAmbient = 0.01;
        self.dayDiffuse = 0.7;
        self.nightDiffuse = 0.3;
        
        [self SetDay:true];
        [self SetFog:false];
    }

    return self;
}

-(void)SetDay:(Boolean) daytime {
    if(daytime == true) {
        self.conditions |= ConditionsDay;
    } else {
        self.conditions &= ~ConditionsDay;
    }
}

-(Boolean)GetDay {
    return (self.conditions & ConditionsDay);
}

-(GLfloat)GetAmbient {
    if(self.conditions & ConditionsDay) {
        return self.dayAmbient;
    } else {
        return self.nightAmbient;
    }
}

-(GLfloat)GetDiffuse {
    if(self.conditions & ConditionsDay) {
        return self.dayDiffuse;
    } else {
        return self.nightDiffuse;
    }
}

-(void)SetFog:(Boolean) fog {
    if(fog == true) {
        self.conditions |= ConditionsFoggy;
    } else {
        self.conditions &= ~ConditionsFoggy;
    }
}

-(Boolean)GetFog {
    return (self.conditions & ConditionsFoggy);
}

@end
