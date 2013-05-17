//
//  ReviewGameViewController.m
//  MakeNewGame
//
//  Created by Sharif Younes on 5/16/13.
//  Copyright (c) 2013 Sharif Younes. All rights reserved.
//

#import "ReviewGameViewController.h"
#import "MakeNewQuestionsViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ReviewGameViewController ()

@end

@implementation ReviewGameViewController

@synthesize reviewGameDisplay;
@synthesize gameDisplay;
@synthesize gameTitle;
@synthesize courseTitle;
@synthesize gameLength;
@synthesize answerKey;
@synthesize questionSet;
@synthesize createOutlet;

#define QUESTION_HEIGHT 220.0

NSArray *lettersForNumbers;

- (NSArray *)lettersForNumbers
{
    if (!lettersForNumbers)  {
        lettersForNumbers = [NSArray arrayWithObjects:@"", @"A", @"B", @"C", @"D", nil];
    }
    return lettersForNumbers;
}

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
	// Do any additional setup after loading the view.
    
    //design create button
    [self setLayerToButton:createOutlet];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationItem.hidesBackButton = YES;
    

    NSString *gameReview = [NSString stringWithFormat:@"You've created a new quiz: %@.", self.gameTitle];
    self.reviewGameDisplay.text = gameReview;
    
    [self.gameDisplay setScrollEnabled:TRUE];
    [self.gameDisplay setContentSize:CGSizeMake(320,QUESTION_HEIGHT*[self.answerKey count])];
    [self.gameDisplay setBackgroundColor:[UIColor clearColor]];
    self.gameDisplay.opaque = NO;
    
    for (int i = 0; i < [self.answerKey count]; i++) {
        UILabel *question;
        question = [[UILabel alloc] initWithFrame: CGRectMake(0, QUESTION_HEIGHT*i, 320, QUESTION_HEIGHT)];
        question.numberOfLines = [[self.questionSet objectAtIndex:i] count] + 1;
        question.font = [UIFont fontWithName:@"STHeitiTC-Medium" size:17.0];
        
        NSString *answer = [NSString stringWithFormat: @"Correct answer: %@.",
                                       [self.answerKey objectAtIndex: i]];
        question.text = [self returnStringForQuestionSet:[self.questionSet objectAtIndex:i] andQuestionAssesment:answer];
        [self.gameDisplay addSubview: question];
        question.opaque = NO;
        question.textColor = self.reviewGameDisplay.textColor;
        [question setBackgroundColor:[UIColor clearColor]];
    }
}


-(void)viewDidAppear:(BOOL)animated
{
    self.navigationItem.title = @"Review Game";
    [self.gameDisplay flashScrollIndicators];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


- (IBAction)create:(UIButton *)sender {
    NSArray *controllers = self.navigationController.viewControllers;
    for (id obj in controllers){
        if ([obj isKindOfClass:[MakeNewQuestionsViewController class]]) {
            MakeNewQuestionsViewController *MNQVC = [[MakeNewQuestionsViewController alloc]init];
            MNQVC = obj;
            MNQVC.gameCreated = YES;
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}
@end
