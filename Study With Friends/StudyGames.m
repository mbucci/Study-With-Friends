//
//  StudyGames.m
//  Study With Friends
//
//  Created by Max Bucci on 5/6/13.
//  Copyright (c) 2013 Sharif Younes. All rights reserved.
//

#import "StudyGames.h"

@implementation StudyGames

@synthesize games = _games;


- (NSMutableArray *)games
{
    if (!_games) {
        Game *game1 = [[Game alloc]init];
        _games = [[NSMutableArray alloc]init];
        
        NSMutableArray *question1, *question2, *question3, *question4, *question5;
        question1 = [[NSMutableArray alloc] init];
        question2 = [[NSMutableArray alloc] init];
        question3 = [[NSMutableArray alloc] init];
        question4 = [[NSMutableArray alloc] init];
        question5 = [[NSMutableArray alloc] init];
        
        [question1 addObject:@"If x=1 and y=1, what is x+y?"];
        [question1 addObject: @"2"];
        [question1 addObject: @"4"];
        [question1 addObject: @"6"];
        [question1 addObject: @"8"];
        [question1 addObject: @"10"];
        
        [question2 addObject:@"If x=2 and y=2, what is x+y?"];
        [question2 addObject: @"3"];
        [question2 addObject: @"4"];
        [question2 addObject: @"6"];
        [question2 addObject: @"8"];
        [question2 addObject: @"10"];
        
        [question3 addObject:@"If x=3 and y=3, what is x+y?"];
        [question3 addObject: @"5"];
        [question3 addObject: @"4"];
        [question3 addObject: @"6"];
        [question3 addObject: @"8"];
        [question3 addObject: @"10"];
        
        [question4 addObject:@"If x=4 and y=4, what is x+y?"];
        [question4 addObject: @"5"];
        [question4 addObject: @"4"];
        [question4 addObject: @"6"];
        [question4 addObject: @"8"];
        [question4 addObject: @"10"];
        
        [question5 addObject:@"If x=5 and y=5, what is x+y?"];
        [question5 addObject: @"6"];
        [question5 addObject: @"4"];
        [question5 addObject: @"6"];
        [question5 addObject: @"8"];
        [question5 addObject: @"10"];
        
        NSArray *questions = [[NSArray alloc] initWithObjects:question1, question2, question3, question4, question5, nil];
        NSArray *answerSet = [[NSArray alloc] initWithObjects:@"A", @"B", @"C", @"D", @"E", nil];
        
        
        
        game1 = [Game createGameWithTitle:@"Arithmetic"
                                   Course:@"Basic Math"
                                Questions:questions
                                  Answers:answerSet
                            andGameLength:180];
        
        [_games addObject:game1];
        
        
    }
    return _games;
}


-(void)addGame:(Game *)newGame
{
    [self.games addObject:newGame];
}

-(Game *)getGameForIndex:(int)index
{
    return [self.games objectAtIndex:index];
}

-(NSString *)getPercentageForIndex:(int)index
{
    Game *temp = [self.games objectAtIndex:index];
    
    NSString *fraction = [NSString stringWithFormat:@"%d/%d", temp.amtCorrect, temp.amtQuestions];
    
    return fraction;

}




@end
