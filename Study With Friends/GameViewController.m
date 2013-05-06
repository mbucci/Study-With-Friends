//
//  GameViewController.m
//  StudyWithFriends
//
//  Created by Sharif Younes on 4/17/13.
//  Copyright (c) 2013 Sharif Younes. All rights reserved.
//

#import "GameViewController.h"


@interface GameViewController ()
    //@property (nonatomic, strong) Game *game;
    @property (nonatomic, strong) NSMutableArray *buttonSet;
    @property (nonatomic, strong) NSMutableArray *answers;
@end

@implementation GameViewController

//@synthesize game;
@synthesize gameIndex = _gameIndex;
@synthesize buttonSet;
@synthesize answers = _answers;
@synthesize gameDelegate = _gameDelegate;

@synthesize timeDisplay;
@synthesize questionNumberDisplay;
@synthesize timer;

@synthesize aButton, bButton, cButton, dButton, eButton;
@synthesize aOption, bOption, cOption, dOption, eOption;
@synthesize questionTextDisplay;

int mainInt;
int questionNumber;
BOOL inGame;
BOOL gamePaused;
BOOL gameover = FALSE;

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ResultsViewController *RVC = [segue destinationViewController];

    RVC.userAnswers = self.answers;
    RVC.gamePlayed = self.gameDelegate;
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
        [buttonSet addObject: eButton];
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
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
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
        for(UIButton *button in self.buttonSet) {
            if([button.currentTitle isEqualToString: answerPicked]) {
                [button setBackgroundColor:[UIColor redColor]];
            }
            else {
                [button setBackgroundColor:[UIColor whiteColor]];
            }
        }
    }


}

- (IBAction)swipeBack:(UISwipeGestureRecognizer *)sender {
    //if user has hit start...
    if(inGame && !gameover){
        //user cannot hit back on question 1
        if(questionNumber > 1) {
            //moves back a question
            questionNumber = questionNumber - 1;
            [self changeQuestionsAndAnswers: questionNumber];
            
            if (sender.state == UIGestureRecognizerStateEnded) {
                [UIView beginAnimations:nil context:NULL];
                [UIView setAnimationDuration:0.55];
                [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.view cache:YES];
                [UIView commitAnimations];
            }
            
            //highlights appropriate button
            if(self.answers) {
                NSString *answerPicked = [self.answers objectAtIndex: questionNumber-1];
                
                for(UIButton *button in buttonSet) {
                    if([button.currentTitle isEqualToString: answerPicked]) {
                        [button setBackgroundColor:[UIColor redColor]];
                    }
                    else {
                        [button setBackgroundColor:[UIColor whiteColor]];
                    }
                }
            }
        }
    }

}

- (IBAction)swipeNext:(UISwipeGestureRecognizer *)sender {
    //if user has hit start
    if(inGame && !gameover) {
        //user cannot hit next on final question
        
        if( questionNumber < self.gameDelegate.amtQuestions) {
            questionNumber = questionNumber + 1;
            [self changeQuestionsAndAnswers: questionNumber];
            
            if (sender.state == UIGestureRecognizerStateEnded) {
                [UIView beginAnimations:nil context:NULL];
                [UIView setAnimationDuration:0.55];
                [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view cache:YES];
                [UIView commitAnimations];
            }
            //highlight appropriate button
            if(self.answers) {
                NSString *answerPicked = [self.answers objectAtIndex:questionNumber-1];
                
                for(UIButton *button in buttonSet) {
                    if([button.currentTitle isEqualToString: answerPicked]) {
                        [button setBackgroundColor:[UIColor redColor]];
                    }
                    else {
                        [button setBackgroundColor:[UIColor whiteColor]];
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
        
        self.navigationController.navigationBar.topItem.title = self.gameDelegate.title;
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
            [sender setBackgroundImage: [UIImage imageNamed:@"playButton.png"] forState:UIControlStateNormal];
        }
        else {
            timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
            gamePaused = FALSE;
            [sender setBackgroundImage: [UIImage imageNamed:@"pauseButton.jpg"] forState:UIControlStateNormal];
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


-(void) changeQuestionsAndAnswers : (int) questionNumber {
    
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
    
    NSString *cAnswer = [[self.gameDelegate.questionSet objectAtIndex:number] objectAtIndex:3];
    self.cOption.text = cAnswer;
    
    NSString *dAnswer = [[self.gameDelegate.questionSet objectAtIndex:number] objectAtIndex:4];
    self.dOption.text = dAnswer;
    
    NSString *eAnswer = [[self.gameDelegate.questionSet objectAtIndex:number] objectAtIndex:5];
    self.eOption.text = eAnswer;
    
}

-(void) endGame {
    
    gameover = TRUE;
    [timer invalidate];
    [self performSegueWithIdentifier:@"results" sender:self];
    
}


@end
