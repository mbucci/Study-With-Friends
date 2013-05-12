//
//  Game.h
//  StudyWithFriends
//
//  Created by Sharif Younes on 4/18/13.
//  Copyright (c) 2013 Sharif Younes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameViewController.h"

@interface Game : NSObject {

    NSMutableArray *questionSet;
    NSMutableArray *answerKey;
    NSString *title;
    
    int gameLength;
    int amtQuestions;

}

@property NSString *title;
@property int gameLength, amtQuestions, amtCorrect;
@property NSArray *questionSet;
@property NSArray *answerKey;
@property BOOL played;
@property NSMutableArray *userAnswers;

- (int)getAmountCorrect:(NSMutableArray*) userAnswers;
+ (Game *)createGameWithTitle:(NSString *)gameTitle
                 Questions:(NSArray *)questions
                   Answers:(NSArray *)answers
             andGameLength:(int)length;





@end
