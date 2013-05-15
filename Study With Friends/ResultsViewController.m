//
//  ResultsViewController.m
//  StudyWithFriends
//
//  Created by Sharif Younes on 4/21/13.
//  Modified by Max Bucci
//  Copyright (c) 2013 Sharif Younes. All rights reserved.
//

#import "ResultsViewController.h"
#import "CoursesTableViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface ResultsViewController () 


@end

@implementation ResultsViewController

#define QUESTION_HEIGHT 220.0

@synthesize gameCompletedDisplay;
@synthesize gamePlayed;
@synthesize userAnswers;
@synthesize questionsDisplay;
@synthesize gameIndex = _gameIndex;
@synthesize mainMenuButton = _mainMenuButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationItem.hidesBackButton = YES;
    
    [self setLayerToButton:self.mainMenuButton];
    [self.mainMenuButton setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    
    int amtCorrect = [self.gamePlayed getAmountCorrect:self.userAnswers];
    NSString *gameOver = [NSString stringWithFormat:@"You completed the %@ quiz!\nYou got %d/%d correct!", self.gamePlayed.title, amtCorrect, self.gamePlayed.amtQuestions];
    self.gameCompletedDisplay.text = gameOver;
    
    [self.questionsDisplay setScrollEnabled:TRUE];
    [self.questionsDisplay setContentSize:CGSizeMake(320,QUESTION_HEIGHT*self.gamePlayed.amtQuestions)];
    [self.questionsDisplay setBackgroundColor:[UIColor clearColor]];
    self.questionsDisplay.opaque = NO;
    
    for (int i = 0; i < self.gamePlayed.amtQuestions; i++) {
        UILabel *question;
        question = [[UILabel alloc] initWithFrame: CGRectMake(0, QUESTION_HEIGHT*i, 320, QUESTION_HEIGHT)];
        question.numberOfLines = self.gamePlayed.amtQuestions + 2;
        question.font = [UIFont fontWithName:@"STHeitiTC-Medium" size:17.0];
        
        NSString *questionAssesment = [NSString stringWithFormat: @"You chose %@; the correct answer is %@.",
                                       [userAnswers objectAtIndex: i],
                                       [self.gamePlayed.answerKey objectAtIndex: i]];
        question.text = [self returnStringForQuestionSet:[self.gamePlayed.questionSet objectAtIndex:i]
                                    andQuestionAssesment:questionAssesment];
        
        [self.questionsDisplay addSubview: question];
        question.opaque = NO;
        question.textColor = self.gameCompletedDisplay.textColor;
        [question setBackgroundColor:[UIColor clearColor]];
    }
}


-(NSString *)returnStringForQuestionSet:(NSArray *)questions andQuestionAssesment:(NSString *)assesment
{
    NSString *returnString;
    
    if (questions.count-1 >= 4){
        returnString =  [NSString stringWithFormat:@"%@ \n (A) %@ \n (B) %@ \n (C) %@ \n (D) %@ \n %@",
                        [questions objectAtIndex: 0],
                        [questions objectAtIndex: 1],
                        [questions objectAtIndex: 2],
                        [questions objectAtIndex: 3],
                        [questions objectAtIndex: 4],
                        assesment];
    } else if (questions.count-1 >= 3) {
        returnString =  [NSString stringWithFormat:@"%@ \n (A) %@ \n (B) %@ \n (C) %@ \n %@",
                        [questions objectAtIndex: 0],
                        [questions objectAtIndex: 1],
                        [questions objectAtIndex: 2],
                        [questions objectAtIndex: 3],
                        assesment];
    } else {
        returnString =  [NSString stringWithFormat:@"%@ \n (A) %@ \n (B) %@ \n %@",
                        [questions objectAtIndex: 0],
                        [questions objectAtIndex: 1],
                        [questions objectAtIndex: 2],
                        assesment];
    }

    return returnString;
}


-(void)viewDidAppear:(BOOL)animated
{
    [questionsDisplay flashScrollIndicators];
}

- (void)setLayerToButton:(UIButton *)button
{
    [button setBackgroundColor:[UIColor whiteColor]];
    button.layer.cornerRadius = 3.0f;
    button.layer.masksToBounds = NO;
    button.layer.borderWidth = 1.0f;
    button.layer.shadowColor = [UIColor blackColor].CGColor;
    button.layer.borderColor = [UIColor grayColor].CGColor;
    button.layer.shadowOpacity = 0.8;
    button.layer.shadowRadius = 3;
    button.layer.shadowOffset = CGSizeMake(0.0f, 2.0f);
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)mainMenuPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
