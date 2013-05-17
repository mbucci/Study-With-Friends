//
//  QuestionsModel.h
//  MakeNewGame
//
//  Created by Sharif Younes on 5/12/13.
//  Copyright (c) 2013 Sharif Younes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionsModel : NSObject

@property (strong, nonatomic) NSMutableArray *tempQuestionSet;
@property (strong, nonatomic) NSMutableArray *questionSet;
@property (strong, nonatomic) NSMutableArray *tempAnswerKey;
@property (strong, nonatomic) NSMutableArray *answerKey;

-(BOOL) enteredTitle: (NSString*) title;
-(BOOL)enteredGameLength:(NSString *)lengthText;
-(BOOL) stringIsNumber: (NSString*) string;
-(NSString*) getAlertMessage: (NSMutableArray*) incorrectEntries;
@end
