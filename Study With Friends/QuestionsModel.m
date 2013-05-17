//
//  QuestionsModel.m
//  MakeNewGame
//
//  Created by Sharif Younes on 5/12/13.
//  Copyright (c) 2013 Sharif Younes. All rights reserved.
//

#import "QuestionsModel.h"

@implementation QuestionsModel

@synthesize tempQuestionSet, questionSet, tempAnswerKey, answerKey;

-(BOOL) enteredTitle: (NSString*) title {
    if([title length] != 0) {
        return TRUE;
    }
    return FALSE;
}


-(BOOL)enteredGameLength:(NSString *)lengthText {
    if([lengthText length] != 0 && [self stringIsNumber:lengthText]) {
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
