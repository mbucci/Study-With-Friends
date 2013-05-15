//
//  GameViewController.h
//  StudyWithFriends
//
//  Created by Sharif Younes on 4/17/13.
//  Modified by Max Bucci
//  Copyright (c) 2013 Sharif Younes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"
#import "ResultsViewController.h"


#define DEFAULT_INDEX 0

@interface GameViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *timeDisplay;
@property (weak, nonatomic) IBOutlet UILabel *questionNumberDisplay;
@property (strong, nonatomic) NSTimer *timer;
@property (weak, nonatomic) IBOutlet UIButton *aButton;
@property (weak, nonatomic) IBOutlet UIButton *bButton;
@property (weak, nonatomic) IBOutlet UIButton *cButton;
@property (weak, nonatomic) IBOutlet UIButton *dButton;
@property (weak, nonatomic) IBOutlet UILabel *aOption;
@property (weak, nonatomic) IBOutlet UILabel *bOption;
@property (weak, nonatomic) IBOutlet UILabel *cOption;
@property (weak, nonatomic) IBOutlet UILabel *dOption;
@property (weak, nonatomic) IBOutlet UILabel *questionTextDisplay;
@property (nonatomic) int gameIndex;
@property (nonatomic, strong) Game *gameDelegate;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *endButton;
@property (weak, nonatomic) IBOutlet UIButton *pauseButton;



- (IBAction)answerPressed:(UIButton*)sender;
- (IBAction)swipeBack:(UISwipeGestureRecognizer *)sender;
- (IBAction)swipeNext:(UISwipeGestureRecognizer *)sender;
- (IBAction)startPressed:(UIButton *)sender;
- (IBAction)endPressed:(UIButton *)sender;
- (IBAction)pausePressed:(UIButton *)sender;


-(void) countDown;
-(void) changeQuestionsAndAnswers:(int)i;
-(void) endGame;


@end
