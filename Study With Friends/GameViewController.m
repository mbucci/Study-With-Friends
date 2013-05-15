//
//  GameViewController.m
//  StudyWithFriends
//
//  Created by Sharif Younes on 4/17/13.
//  Modified by Max Bucci 
//  Copyright (c) 2013 Sharif Younes. All rights reserved.
//

#import "GameViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface GameViewController ()
    @property (nonatomic, strong) NSMutableArray *buttonSet;
    @property (nonatomic, strong) NSMutableArray *answers;
@end

@implementation GameViewController

@synthesize gameIndex = _gameIndex;
@synthesize buttonSet;
@synthesize answers = _answers;
@synthesize gameDelegate = _gameDelegate;
@synthesize timeDisplay;
@synthesize questionNumberDisplay;
@synthesize timer;
@synthesize aButton, bButton, cButton, dButton;
@synthesize startButton, endButton, pauseButton;
@synthesize aOption, bOption, cOption, dOption;
@synthesize questionTextDisplay;

int mainInt;
int questionNumber;
BOOL inGame;
BOOL gamePaused;


-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ResultsViewController *RVC = [segue destinationViewController];

    RVC.userAnswers = self.answers;
    RVC.gamePlayed = self.gameDelegate;
    RVC.gameIndex = self.gameIndex;
}


-(int)gameIndex
{
    if (!_gameIndex){
        _gameIndex = DEFAULT_INDEX;
    }
    return _gameIndex;
}


- (NSMutableArray *)buttonSet
{
    if (!buttonSet)  {
        buttonSet = [[NSMutableArray alloc]init];
        [buttonSet addObject: aButton];
        [buttonSet addObject: bButton];
        [buttonSet addObject: cButton];
        [buttonSet addObject: dButton];
    }
    return buttonSet;
}


- (NSMutableArray *) answers
{
    if (!_answers) {
        _answers = [[NSMutableArray alloc] init];
        int i = 1;
        while (i <= self.gameDelegate.amtQuestions) {
            [_answers addObject: @""];
            i = i+1;
        }
    }
    return _answers;
}


- (void)viewDidLoad
{
    self.navigationItem.title = self.gameDelegate.title;
    [super viewDidLoad];
    inGame = FALSE;
    
    [self setLayerToButton:aButton];
    [self setLayerToButton:bButton];
    [self setLayerToButton:cButton];
    [self setLayerToButton:dButton];
    [self setLayerToButton:endButton];
    [self setLayerToButton:startButton];
    [self setLayerToButton:pauseButton];
    
    [self.startButton setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    [self.endButton setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    [self.pauseButton setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    
    [self.pauseButton setTitle:@"Pause" forState:UIControlStateNormal];
    
    NSArray *temp = [self.gameDelegate.questionSet objectAtIndex:0];
    
    if (temp.count-1 < 4) {
        self.dButton.hidden = YES;
        self.dOption.hidden = YES;
    }
    if (temp.count-1 < 3) {
        self.cButton.hidden = YES;
        self.cOption.hidden = YES;
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


- (void)viewDidAppear:(BOOL)animated
{
    if (self.gameDelegate.played) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    inGame = FALSE;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)answerPressed:(UIButton *)sender {
    //if user has hit start...
    if(inGame) {
        //gets user's answer
        NSString *answerPicked = sender.currentTitle;
        //adds it to array that stores user's answers
        [self.answers replaceObjectAtIndex:questionNumber-1 withObject:answerPicked];
        //highlights appropriate button
        for(UIButton *button in self.buttonSet){
            if([button.currentTitle isEqualToString: answerPicked]) {
                [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            }
            else {
                [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            }
        }
    }

}


-(void)highlightButton:(UIButton *)button
{
    [button setHighlighted:YES];
    [button setSelected:YES];
}


-(void)unhighlightButton:(UIButton *)button
{
    [button setHighlighted:NO];
    [button setSelected:NO];
}


- (IBAction)swipeBack:(UISwipeGestureRecognizer *)sender {
    //if user has hit start...
    if(inGame && !self.gameDelegate.played && !gamePaused){
        //user cannot hit back on question 1
        if(questionNumber > 1) {
            //moves back a question
            questionNumber = questionNumber - 1;
            [self changeQuestionsAndAnswers: questionNumber];
            
            if (sender.state == UIGestureRecognizerStateEnded ) {
                [UIView beginAnimations:nil context:NULL];
                [UIView setAnimationDuration:0.5];
                [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view cache:YES];
                [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.view cache:YES];
                [UIView commitAnimations];
            }
            
            NSArray *temp = [self.gameDelegate.questionSet objectAtIndex:questionNumber-1];
            if (temp.count-1 > 3) {
                self.dButton.hidden = NO;
                self.dOption.hidden = NO;
            }
            if (temp.count-1 < 4) {
                self.dButton.hidden = YES;
                self.dOption.hidden = YES;
            }
            if (temp.count-1 > 2) {
                self.cButton.hidden = NO;
                self.cOption.hidden = NO;
            }
            if (temp.count-1 < 3) {
                self.cButton.hidden = YES;
                self.cOption.hidden = YES;
            }
            
            //highlights appropriate button
            if(self.answers) {
                NSString *answerPicked = [self.answers objectAtIndex: questionNumber-1];
                
                for(UIButton *button in buttonSet) {
                    if([button.currentTitle isEqualToString: answerPicked]) {
                        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
                    }
                    else {
                        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                    }
                }
            }
        }
    }

}


- (IBAction)swipeNext:(UISwipeGestureRecognizer *)sender {
    //if user has hit start
    if(inGame && !self.gameDelegate.played && !gamePaused) {
        //user cannot hit next on final question
        
        if(questionNumber < self.gameDelegate.amtQuestions) {
            questionNumber = questionNumber + 1;
            [self changeQuestionsAndAnswers: questionNumber];
            
            if (sender.state == UIGestureRecognizerStateEnded) {
                [UIView beginAnimations:nil context:NULL];
                [UIView setAnimationDuration:0.5];
                [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view cache:YES];
                [UIView commitAnimations];
            }
            
            NSArray *temp = [self.gameDelegate.questionSet objectAtIndex:questionNumber-1];
            if (temp.count-1 > 3) {
                self.dButton.hidden = NO;
                self.dOption.hidden = NO;
            }
            if (temp.count-1 < 4) {
                self.dButton.hidden = YES;
                self.dOption.hidden = YES;
            }
            if (temp.count-1 > 2) {
                self.cButton.hidden = NO;
                self.cOption.hidden = NO;
            }
            if (temp.count-1 < 3) {
                self.cButton.hidden = YES;
                self.cOption.hidden = YES;
            }
            
            //highlight appropriate button
            if(self.answers) {
                NSString *answerPicked = [self.answers objectAtIndex:questionNumber-1];
                
                for(UIButton *button in buttonSet) {
                    if([button.currentTitle isEqualToString: answerPicked]) {
                        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
                    }
                    else {
                        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                    }
                }
            }
        }
    }
}


- (IBAction)startPressed:(UIButton *)sender {
    if(!inGame){
    
        //set boolean for game true
        inGame = TRUE;
    
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        //display questions and answers
        questionNumber = 1;
        [self changeQuestionsAndAnswers: questionNumber];
    
        mainInt = 0;
        if(!timer) {
            timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
        }
    }
}


- (IBAction)endPressed:(UIButton *)sender {
    //user cannot end game without starting...
    if(inGame){
        mainInt = self.gameDelegate.gameLength;
    }
    
    
    
}


- (IBAction)pausePressed:(UIButton *)sender {
    if(inGame) {
        if(!gamePaused) {
            [timer invalidate];
            gamePaused = TRUE;
            [sender setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            [sender setTitle:@"Resume" forState:UIControlStateNormal];
            self.questionTextDisplay.text = @"Paused";
            self.aOption.text = @"Paused";
            self.bOption.text = @"Paused";
            self.cOption.text = @"Paused";
            self.dOption.text = @"Paused";
        }
        else {
            timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
            gamePaused = FALSE;
            [sender setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [sender setTitle:@"Pause" forState:UIControlStateNormal];
            [self changeQuestionsAndAnswers:questionNumber];
            
        }
    }
}


- (void) countDown {
    
    int timeLeft = self.gameDelegate.gameLength - mainInt;
    if(timeLeft < 0) {
        [self endGame];
    }
    else {
        mainInt += 1;
        timeDisplay.text = [NSString stringWithFormat: @"%i", timeLeft];
        if(timeLeft <6) {
            timeDisplay.font= [timeDisplay.font fontWithSize:25.0];
            [timeDisplay setTextColor: [UIColor redColor]];
        }
    }
    
}


-(void) changeQuestionsAndAnswers:(int) questionNumber {
    
    int number = questionNumber -1;
    
    NSString *questionHeader = [NSString stringWithFormat:@"Question %i", questionNumber];
    self.questionNumberDisplay.text = questionHeader;
    
    //display question
    NSString *question = [[self.gameDelegate.questionSet objectAtIndex:number] objectAtIndex:0];
    self.questionTextDisplay.text = question;
    
    //display answer options
    NSString *aAnswer = [[self.gameDelegate.questionSet objectAtIndex:number] objectAtIndex:1];
    self.aOption.text = aAnswer;
    
    NSString *bAnswer = [[self.gameDelegate.questionSet objectAtIndex:number] objectAtIndex:2];
    self.bOption.text = bAnswer;
    
    NSArray *temp = [self.gameDelegate.questionSet objectAtIndex:questionNumber-1];
    if (temp.count-1 > 2) {
        NSString *cAnswer = [[self.gameDelegate.questionSet objectAtIndex:number] objectAtIndex:3];
        self.cOption.text = cAnswer;
        
        if (temp.count-1 > 3) {
            NSString *dAnswer = [[self.gameDelegate.questionSet objectAtIndex:number] objectAtIndex:4];
            self.dOption.text = dAnswer;
        }
    }
    
}


-(void) endGame {
    
    [timer invalidate];
    [self performSegueWithIdentifier:@"results" sender:self];
    
}


@end
