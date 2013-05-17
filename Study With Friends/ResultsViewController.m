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

@property (strong, nonatomic) NSArray *lettersForNumbers;

@end

@implementation ResultsViewController

#define QUESTION_HEIGHT 220.0

@synthesize gameCompletedDisplay;
@synthesize gamePlayed;
@synthesize userAnswers;
@synthesize questionsDisplay;
@synthesize gameIndex = _gameIndex;
@synthesize mainMenuButton = _mainMenuButton;
@synthesize lettersForNumbers = _lettersForNumbers;

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
        question.numberOfLines = [[self.gamePlayed.questionSet objectAtIndex:i] count] + 2;
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


-(void)viewDidAppear:(BOOL)animated
{
    self.navigationItem.title = @"Results";
    [questionsDisplay flashScrollIndicators];
}


- (NSArray *)lettersForNumbers
{
    if (!_lettersForNumbers)  {
        _lettersForNumbers = [NSArray arrayWithObjects:@"", @"A", @"B", @"C", @"D", nil];
    }
    return _lettersForNumbers;
}




-(NSString *)returnStringForQuestionSet:(NSArray *)questions andQuestionAssesment:(NSString *)assesment
{
    NSString *returnString;
    returnString = [[NSString alloc] init];
    for(int i = 0; i < [questions count]; i++) {
        NSString *string = [questions objectAtIndex:i];
        //question
        if(i == 0) {
            returnString = [returnString stringByAppendingFormat:@"%@ \n", string];
        }
        //option
        else {
            returnString = [returnString stringByAppendingFormat:@"(%@) %@ \n", [self.lettersForNumbers objectAtIndex: i], string];
        }
    }
    /*
     for(NSString *string in questions) {
     returnString = [returnString stringByAppendingFormat:@"%@ \n", string];
     }
     */
    returnString = [returnString stringByAppendingFormat: @"%@", assesment];
    return returnString;
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
