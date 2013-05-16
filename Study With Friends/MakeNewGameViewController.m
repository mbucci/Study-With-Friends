//
//  MakeNewGameViewController.m
//  MakeNewGame
//
//  Created by Sharif Younes on 5/12/13.
//  Copyright (c) 2013 Sharif Younes. All rights reserved.
//

#import "MakeNewGameViewController.h"
#import "MakeNewQuestionsViewController.h"

@interface MakeNewGameViewController ()

@end

@implementation MakeNewGameViewController

@synthesize titleTextField;
@synthesize titleString;
@synthesize model;
@synthesize gamesDelegate = _gamesDelegate;

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    MakeNewQuestionsViewController *MNQVC = [segue destinationViewController];
    MNQVC.gameTitle = titleTextField.text;
    MNQVC.gamesToAddToo = self.gamesDelegate;
    
}

- (Game *)model {
    if(!model) {
        model = [[Game alloc] init];
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
    return YES;
}

- (IBAction)enter:(UIButton *)sender {
    //user has entered valid title,length,question number
    if([self.model enteredTitle: titleTextField.text]) {
        //add title, game length, amount of questions to game
        self.titleString = titleTextField.text;
        //segue
        [self performSegueWithIdentifier: @"enterQuestions" sender: self];
        
    }
    //otherwise
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please enter game title." message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}


- (void)tap:(UITapGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        [self.titleTextField resignFirstResponder];
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    UINavigationItem *item = [self.navigationController.navigationBar.items lastObject];
    item.title = @"Create Game";
    item.leftBarButtonItem = nil;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.view addGestureRecognizer:tapGesture];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    UINavigationItem *item = [self.navigationController.navigationBar.items lastObject];
    item.title = @"Create Game";
    item.leftBarButtonItem = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
