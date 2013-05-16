//
//  ColorsModel.m
//  MakeNewGame
//
//  Created by Sharif Younes on 5/14/13.
//  Copyright (c) 2013 Sharif Younes. All rights reserved.
//

#import "ColorsModel.h"

@implementation ColorsModel

#define RED_1 .72
#define GREEN_1 .78
#define BLUE_1 .8
#define OPAQUE_1 .75

#define RED_2 42.0f / 255.0f
#define GREEN_2 75.0f / 255.0f
#define BLUE_2 216.0f / 255.0f
#define OPAQUE_2 1

#define RED_3 117.0f / 255.0f
#define GREEN_3 154.0f / 255.0f
#define BLUE_3 255.0f / 255.0f
#define OPAQUE_3 .95

@synthesize secondaryOutline = _secondaryOutline;
@synthesize bottomButtonBottomColor = _bottomButtonBottomColor;
@synthesize bottomButtonTopColor = _bottomButtonTopColor;


-(UIColor*) secondaryOutline {
    if(!_secondaryOutline) {
        _secondaryOutline = [UIColor colorWithRed:RED_1 green:GREEN_1 blue:BLUE_1 alpha:OPAQUE_1];
    }
    return _secondaryOutline;
}

-(UIColor*) bottomButtonTopColor {
    if(!_bottomButtonTopColor) {
        _bottomButtonTopColor = [UIColor colorWithRed:RED_3 green:GREEN_3 blue:BLUE_3 alpha:OPAQUE_3];
    }
    return _bottomButtonTopColor;
}


-(UIColor*) bottomButtonBottomColor {
    if(!_bottomButtonBottomColor) {
        _bottomButtonBottomColor = [UIColor colorWithRed:RED_2 green:GREEN_2 blue:BLUE_2 alpha:OPAQUE_2];
    }
    return _bottomButtonBottomColor;
}




@end
