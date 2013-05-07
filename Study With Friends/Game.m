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
@synthesize title;
@synthesize amtCorrect = _amtCorrect;
@synthesize played = _played;


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
    return amountCorrect;
}


+ (Game *)createGameWithTitle:(NSString *)gameTitle
                  Questions:(NSArray *)questions
                   Answers:(NSArray *)answers
             andGameLength:(int)length
{
    Game *game = [[Game alloc]init];
    
    game.title = gameTitle;
    game.answerKey = answers;
    game.questionSet = questions;
    game.gameLength = length;
    game.amtQuestions = [questions count];
    game.amtCorrect = 0;
    game.played = NO;
    
    return game;
    
}




@end
