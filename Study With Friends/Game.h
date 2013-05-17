//
//  Game.h
//  StudyWithFriends
//
//  Created by Sharif Younes on 4/18/13.
//  Copyright (c) 2013 Sharif Younes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameViewController.h"

@interface Game : NSObject 

@property NSString *title, *course;
@property int gameLength, amtQuestions, amtCorrect;
@property NSArray *questionSet;
@property NSArray *answerKey;
@property BOOL played;
@property NSMutableArray *userAnswers;
@property int courseSection;

- (int)getAmountCorrect:(NSMutableArray*) userAnswers;
+ (Game *)createGameWithTitle:(NSString *)gameTitle
                       Course:(NSString *)course
                 Questions:(NSArray *)questions
                   Answers:(NSArray *)answers
             andGameLength:(int)length;





@end
