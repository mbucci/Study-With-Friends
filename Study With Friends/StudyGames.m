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
        Game *game2 = [[Game alloc]init];
        Game *game3 = [[Game alloc]init];
        Game *game4 = [[Game alloc]init];
        Game *game5 = [[Game alloc]init];
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
        
        [question2 addObject:@"If x=2 and y=2, what is x+y?"];
        [question2 addObject: @"3"];
        [question2 addObject: @"4"];
        [question2 addObject: @"6"];
        [question2 addObject: @"8"];
        
        [question3 addObject:@"If x=3 and y=3, what is x+y?"];
        [question3 addObject: @"5"];
        [question3 addObject: @"4"];
        [question3 addObject: @"6"];
        [question3 addObject: @"8"];
        
        [question4 addObject:@"If x=4 and y=4, what is x+y?"];
        [question4 addObject: @"5"];
        [question4 addObject: @"4"];
        [question4 addObject: @"6"];
        [question4 addObject: @"8"];
        
        [question5 addObject:@"If x=5 and y=5, what is x+y?"];
        [question5 addObject: @"4"];
        [question5 addObject: @"10"];
        [question5 addObject: @"6"];
        [question5 addObject: @"8"];
        
        NSArray *questions = [[NSArray alloc] initWithObjects:question1, question2, question3, question4, question5, nil];
        NSArray *answerSet = [[NSArray alloc] initWithObjects:@"A", @"B", @"C", @"D", @"B", nil];
        
        
        
        game1 = [Game createGameWithTitle:@"Arithmetic"
                                   Course:@"Basic Math"
                                Questions:questions
                                  Answers:answerSet
                            andGameLength:180];
        
        [self addGame:game1];
        
        NSMutableArray *question6, *question7, *question8, *question9;
        question6 = [[NSMutableArray alloc] init];
        question7 = [[NSMutableArray alloc] init];
        question8 = [[NSMutableArray alloc] init];
        question9 = [[NSMutableArray alloc] init];
        
        [question6 addObject:@"What is the derivative of x^2?"];
        [question6 addObject: @"2x"];
        [question6 addObject: @"x"];
        [question6 addObject: @"1"];
        [question6 addObject: @"2x^2"];
        
        [question7 addObject:@"What is the integral of x^2?"];
        [question7 addObject: @"2x"];
        [question7 addObject: @"(1/3)x^3"];
        [question7 addObject: @"x"];
        [question7 addObject: @"x^2"];
        
        [question8 addObject:@"What is the derivative of x?"];
        [question8 addObject: @"0"];
        [question8 addObject: @"x"];
        [question8 addObject: @"1"];
        [question8 addObject: @"(1/2)x^2"];
        
        [question9 addObject:@"What is the integral of 2?"];
        [question9 addObject: @"2x"];
        [question9 addObject: @"1"];
        [question9 addObject: @"x"];
        [question9 addObject: @"x^2"];
        
        NSArray *questions2 = [[NSArray alloc] initWithObjects:question6, question7, question8, question9, nil];
        NSArray *answerSet2 = [[NSArray alloc] initWithObjects:@"A", @"B", @"C", @"A", nil];
        
        
        
        game2 = [Game createGameWithTitle:@"Derivatives and Integrals"
                                   Course:@"Math 161"
                                Questions:questions2
                                  Answers:answerSet2
                            andGameLength:100];
        
        [self addGame:game2];
        
        NSMutableArray *question10, *question11, *question12, *question13;
        question10 = [[NSMutableArray alloc] init];
        question11 = [[NSMutableArray alloc] init];
        question12 = [[NSMutableArray alloc] init];
        question13 = [[NSMutableArray alloc] init];
        
        [question10 addObject:@"What is 2 x 2?"];
        [question10 addObject: @"5"];
        [question10 addObject: @"4"];
        
        [question11 addObject:@"What is 3 x 7?"];
        [question11 addObject: @"21"];
        [question11 addObject: @"14"];
        [question11 addObject: @"10"];
        [question11 addObject: @"28"];
        
        [question12 addObject:@"What is 6 x 8?"];
        [question12 addObject: @"14"];
        [question12 addObject: @"36"];
        [question12 addObject: @"48"];
        
        [question13 addObject:@"What is 11 x 11?"];
        [question13 addObject: @"99"];
        [question13 addObject: @"121"];
        
        NSArray *questions3 = [[NSArray alloc] initWithObjects:question10, question11, question12, question13, nil];
        NSArray *answerSet3 = [[NSArray alloc] initWithObjects:@"B", @"A", @"C", @"B", nil];
        
        
        
        game3 = [Game createGameWithTitle:@"Multiplication"
                                   Course:@"Basic Math"
                                Questions:questions3
                                  Answers:answerSet3
                            andGameLength:60];
        
        [self addGame:game3];
        
        NSMutableArray *question14, *question15, *question16, *question17;
        question14 = [[NSMutableArray alloc] init];
        question15 = [[NSMutableArray alloc] init];
        question16 = [[NSMutableArray alloc] init];
        question17 = [[NSMutableArray alloc] init];
        
        [question14 addObject:@"Who Was the 16th President of the United States?"];
        [question14 addObject: @"George Washington"];
        [question14 addObject: @"Abraham Lincoln"];
        [question14 addObject: @"Thomas Jefferson"];
        [question14 addObject: @"Benjamin Franklin"];
        
        [question15 addObject:@"On what day did the Japanese attack Pearl Harbor?"];
        [question15 addObject: @"July 4th 1863"];
        [question15 addObject: @"December 25th 1902"];
        [question15 addObject: @"December 7th 1941"];
        [question15 addObject: @"April 1 2001"];
        
        [question16 addObject:@"Who assassinated Abraham Licoln?"];
        [question16 addObject: @"John Wilkes Booth"];
        [question16 addObject: @"Benedict Arnold"];
        [question16 addObject: @"Robert E. Lee"];
        
        [question17 addObject:@"Who was the president during WWII?"];
        [question17 addObject: @"Franklin Delano Roosevelt"];
        [question17 addObject: @"Theodore Roosevelt"];
        
        NSArray *questions4 = [[NSArray alloc] initWithObjects:question14, question15, question16, question17, nil];
        NSArray *answerSet4 = [[NSArray alloc] initWithObjects:@"B", @"C", @"A", @"A", nil];
        
        
        
        game4 = [Game createGameWithTitle:@"Presidents and Wars"
                                   Course:@"American History"
                                Questions:questions4
                                  Answers:answerSet4
                            andGameLength:60];
        
        [self addGame:game4];
        
        NSMutableArray *question18, *question19, *question20, *question21;
        question18 = [[NSMutableArray alloc] init];
        question19 = [[NSMutableArray alloc] init];
        question20 = [[NSMutableArray alloc] init];
        question21 = [[NSMutableArray alloc] init];
        
        [question18 addObject:@"What is the equation for classical kinetic energy?"];
        [question18 addObject: @"mv^2"];
        [question18 addObject: @"1/2mv^2"];
        [question18 addObject: @"mv"];
        
        [question19 addObject:@"What is work?"];
        [question19 addObject: @"Force / Distance"];
        [question19 addObject: @"Force * Distance^2"];
        [question19 addObject: @"1/2 Force * Distance"];
        [question19 addObject: @"Force * Distance"];
        
        [question20 addObject:@"On what scale is the visible light spectrum?"];
        [question20 addObject: @"100 - 800 nm"];
        [question20 addObject: @"10 - 80 mm"];
        [question20 addObject: @"1 - 8 m"];
        
        [question21 addObject:@"What does the area under the velocity curve represent?"];
        [question21 addObject: @"Acceleration"];
        [question21 addObject: @"Distance traveled"];
        
        NSArray *questions5 = [[NSArray alloc] initWithObjects:question18, question19, question20, question21, nil];
        NSArray *answerSet5 = [[NSArray alloc] initWithObjects:@"B", @"D", @"A", @"B", nil];
        
        
        
        game5 = [Game createGameWithTitle:@"Physics Mashup"
                                   Course:@"Physics 101"
                                Questions:questions5
                                  Answers:answerSet5
                            andGameLength:45];
        
        [self addGame:game5];
        
    }
    return _games;
}


-(void)addGame:(Game *)newGame
{
    //Figure out and assign section number to a game for its course
    NSSet *coursesSet = [NSSet setWithArray:[self.games valueForKey:@"course"]];
    for (id obj in coursesSet) {
        if ([obj isEqualToString:newGame.course]) {
            newGame.courseSection = [self getCourseSectionForCourse:obj];
        } else {
            newGame.courseSection = coursesSet.count;
        }
    }
    [self.games addObject:newGame];
}


-(int)getCourseSectionForCourse:(NSString *)course {
    int section = 0;
    for (id obj in self.games) {
        Game *temp = obj; 
        if ([temp.course isEqualToString:course]) {
             section = temp.courseSection;
        }
    }
    return section;
}


-(NSString *)getCourseForCourseSection:(int)section {
    NSString *course;
    for (id obj in self.games) {
        Game *temp = obj;
        if (temp.courseSection == section) {
            course = temp.course;
        }
    }
    return course;
}


-(int)getNumberOfCourses{

    NSSet *coursesSet = [NSSet setWithArray:[self.games valueForKey:@"course"]];
    return coursesSet.count;
}


-(int)getGamesPerCourse:(NSString *)course
{
    int count = 0;
    for (id obj in self.games) {
        Game *temp = obj;
        if ([temp.course isEqualToString:course])
            count ++;
    }
    return count;
}


-(Game *)getGameForIndex:(int)index andSection:(int)section
{
    NSMutableArray *gameArray = [[NSMutableArray alloc]init];
    for (id obj in self.games) {
        Game *temp = obj;
        if (temp.courseSection == section) {
            [gameArray addObject:temp];
        }
    }
    return [gameArray objectAtIndex:index];
}


-(void)decrementCourseSelectionsBeyondSection:(int)section
{
    for (int i = section+1; i <= [self getNumberOfCourses]; i++) {
        NSString *course = [self getCourseForCourseSection:i];
        for (id obj in self.games) {
            Game *temp = obj;
            if ([temp.course isEqualToString:course]) {
                temp.courseSection--;
            }
        }
    }
}



@end
