//
//  Game.m
//  StudyWithFriends
//
//  Created by Sharif Younes on 4/18/13.
//  Modified by Max Bucci on 4/29/13
//  Copyright (c) 2013 Sharif Younes. All rights reserved.
//

#import "Game.h"

@implementation Game

@synthesize amtQuestions, gameLength;
@synthesize answerKey, questionSet;
@synthesize title, course;
@synthesize amtCorrect = _amtCorrect;
@synthesize played = _played;
@synthesize userAnswers = _userAnswers;


- (int)getAmountCorrect:(NSMutableArray*) userAnswers {
    int amountCorrect=0;
    int answerNumber = 0;
    for (NSString *userAnswer in userAnswers) {
        if([[answerKey objectAtIndex: answerNumber] isEqualToString: userAnswer]) {
            amountCorrect ++;
        }
        answerNumber ++;
    }
    self.amtCorrect = amountCorrect;
    self.played = YES;
    self.userAnswers = userAnswers;
    return amountCorrect;
}


+ (Game *)createGameWithTitle:(NSString *)gameTitle
                       Course:(NSString *)course
                    Questions:(NSArray *)questions
                      Answers:(NSArray *)answers
                andGameLength:(int)length

{
    Game *game = [[Game alloc]init];
    
    game.title = gameTitle;
    game.course = course;
    game.answerKey = answers;
    game.questionSet = questions;
    game.gameLength = length;
    game.amtQuestions = [questions count];
    game.amtCorrect = 0;
    game.played = NO;
    game.userAnswers = NULL;
    
    return game;
    
}




@end
