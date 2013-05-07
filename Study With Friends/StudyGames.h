//
//  StudyGames.h
//  Study With Friends
//
//  Created by Max Bucci on 5/6/13.
//  Copyright (c) 2013 Sharif Younes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Game.h"

@interface StudyGames : NSObject

@property (nonatomic, strong) NSMutableArray *games;


-(NSString *)getPercentageForIndex:(int)index;
-(void)addGame:(Game *)newGame;
-(Game *)getGameForIndex:(int)index;


@end
