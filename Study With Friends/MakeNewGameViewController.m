//
//  MakeNewGameViewController.m
//  MakeNewGame
//
//  Created by Sharif Younes on 5/12/13.
//  Copyright (c) 2013 Sharif Younes. All rights reserved.
//

#import "MakeNewGameViewController.h"
#import "MakeNewQuestionsViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface MakeNewGameViewController ()

@end

@implementation MakeNewGameViewController

@synthesize titleTextField;
@synthesize courseText;
@synthesize lengthText;
@synthesize titleString;
@synthesize model;
@synthesize gamesDelegate = _gamesDelegate;
@synthesize questionsButton = _questionsButton;

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    MakeNewQuestionsViewController *MNQVC = [segue destinationViewController];
    MNQVC.gameTitle = titleTextField.text;
    MNQVC.courseName = courseText.text;
    MNQVC.gameLength = lengthText.text.intValue;
    MNQVC.gamesToAddTo = self.gamesDelegate;
    
}

- (QuestionsModel *)model {
    if(!model) {
        model = [[QuestionsModel alloc] init];
    }
    return model;
}


-(NSString*) titleString {
    if(!titleString) {
        titleString = [[NSString alloc] init];
    }
    return titleString;
}




-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    [titleTextField resignFirstResponder];
    [courseText resignFirstResponder];
    [lengthText resignFirstResponder];
    return YES;
}

- (IBAction)enter:(UIButton *)sender {
    //user has entered valid title,length,question number
    if([self.model enteredTitle: titleTextField.text] && [self.model enteredGameLength:self.lengthText.text] && [self.courseText.text length]) {
        //add title, game length, amount of questions to game
        self.titleString = titleTextField.text;
        [self performSegueWithIdentifier: @"enterQuestions" sender: self];
        
    }
    //otherwise
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please Fill Out All Entries."
                                                        message:@"Game length must be an integer of any size"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
}


- (void)tap:(UITapGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        [self.titleTextField resignFirstResponder];
        [self.courseText resignFirstResponder];
        [self.lengthText resignFirstResponder];
    }
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


- (void)viewDidLoad
{
    [super viewDidLoad];
    UINavigationItem *item = [self.navigationController.navigationBar.items lastObject];
    item.title = @"Create Game";
    item.leftBarButtonItem = nil;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.view addGestureRecognizer:tapGesture];
    
    [self setLayerToButton:self.questionsButton];
    [self.questionsButton setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    [self.questionsButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    self.titleTextField.placeholder = @"Title";
    
}



- (void)viewDidAppear:(BOOL)animated
{
    UINavigationItem *item = [self.navigationController.navigationBar.items lastObject];
    item.title = @"Create Game";
    item.leftBarButtonItem = nil;
    [self.titleTextField resignFirstResponder];
    [self.courseText resignFirstResponder];
    [self.lengthText resignFirstResponder];
    self.titleTextField.text = nil;
    self.courseText.text = nil;
    self.lengthText.text = nil;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
