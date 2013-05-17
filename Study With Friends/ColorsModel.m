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

#define RED_2 .10
#define GREEN_2 .15
#define BLUE_2 .95
#define OPAQUE_2 .85

#define RED_3 .85
#define GREEN_3 .8
#define BLUE_3 1
#define OPAQUE_3 1

#define RED_4 1
#define GREEN_4 .7
#define BLUE_4 .7
#define OPAQUE_4 1

#define RED_5 .95
#define GREEN_5 .15
#define BLUE_5 .1
#define OPAQUE_5 .85





-(UIColor*) secondaryOutline {
    return  [UIColor colorWithRed:RED_1 green:GREEN_1 blue:BLUE_1 alpha:OPAQUE_1];
}


-(UIColor*) addButtonTopColor {
        return  [UIColor colorWithRed:RED_3 green:GREEN_3 blue:BLUE_3 alpha:OPAQUE_3];
}


-(UIColor*) addButtonBottomColor {
    return [UIColor colorWithRed:RED_2 green:GREEN_2 blue:BLUE_2 alpha:OPAQUE_2];
}

-(UIColor*) deleteButtonTopColor {
    return [UIColor colorWithRed:RED_4 green:GREEN_4 blue:BLUE_4 alpha:OPAQUE_4];
}


-(UIColor*) deleteButtonBottomColor {
    return [UIColor colorWithRed:RED_5 green:GREEN_5 blue:BLUE_5 alpha:OPAQUE_5];
}




@end
