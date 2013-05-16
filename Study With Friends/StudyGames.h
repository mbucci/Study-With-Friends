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


-(void)addGame:(Game *)newGame;
-(Game *)getGameForIndex:(int)index andSection:(int)section;
-(int)getGamesPerCourse:(NSString *)course;
-(int)getNumberOfCourses;
-(NSString *)getCourseForCourseSection:(int)section;
-(int)getCourseSectionForCourse:(NSString *)course;
-(void)decrementCourseSelectionsBeyondSection:(int)section;


@end
