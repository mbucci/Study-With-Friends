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
@synthesize courseSection = _courseSection;


- (int)getAmountCorrect:(NSMutableArray*) userAnswers {
    int amountCorrect= 0;
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
    game.courseSection = 0;
    
    return game;
    
}


-(BOOL)enteredTitle:(NSString*)Enteredtitle {
    if(Enteredtitle.length != 0) {
        return TRUE;
    }
    return FALSE;
}

-(BOOL) stringIsNumber: (NSString*) string {
    for (int i = 0; i < [string length] ; i = i+1) {
        NSRange range = NSMakeRange(i, 1);
        NSString *charToCheck = [string substringWithRange:range];
        NSSet *integers = [NSSet setWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", nil];
        if(![integers containsObject:charToCheck]) {
            return FALSE;
        }
    }
    return TRUE;
}


-(NSString*) getAlertMessage: (NSMutableArray*) incorrectEntries {
    NSString *alertString;
    alertString = [[NSString alloc] init];
    if([incorrectEntries count] == 1) {
        alertString = [NSString stringWithFormat:@"Please enter valid text for %@.", [incorrectEntries objectAtIndex:0]];
    }
    else if([incorrectEntries count] == 2) {
        alertString = [NSString stringWithFormat:@"Please enter valid text for %@ and %@.", [incorrectEntries objectAtIndex:0], [incorrectEntries objectAtIndex:1]];
    }
    else if([incorrectEntries count] == 3) {
        alertString = [NSString stringWithFormat:@"Please enter valid text for %@, %@, and %@.", [incorrectEntries objectAtIndex:0],[incorrectEntries objectAtIndex:1], [incorrectEntries objectAtIndex:2]];
    }
    else if([incorrectEntries count] == 4) {
        alertString = [NSString stringWithFormat:@"Please enter valid text for %@, %@, %@, and %@.", [incorrectEntries objectAtIndex:0],[incorrectEntries objectAtIndex:1],[incorrectEntries objectAtIndex:2],[incorrectEntries objectAtIndex:3]];
    }
    else if([incorrectEntries count] == 5) {
        alertString = [NSString stringWithFormat:@"Please enter valid text for %@, %@, %@, %@, and %@.", [incorrectEntries objectAtIndex:0],[incorrectEntries objectAtIndex:1],[incorrectEntries objectAtIndex:2],[incorrectEntries objectAtIndex:3],[incorrectEntries objectAtIndex:4]];
    }
    else if([incorrectEntries count] == 6) {
        alertString = [NSString stringWithFormat:@"Please enter valid text for %@, %@, %@, %@, %@, and %@.", [incorrectEntries objectAtIndex:0],[incorrectEntries objectAtIndex:1],[incorrectEntries objectAtIndex:2],[incorrectEntries objectAtIndex:3],[incorrectEntries objectAtIndex:4],[incorrectEntries objectAtIndex:5]];
    }
    return alertString;
}


@end
