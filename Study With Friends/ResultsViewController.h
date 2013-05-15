//
//  ResultsViewController.h
//  StudyWithFriends
//
//  Created by Sharif Younes on 4/21/13.
//  Modified by Max Bucci
//  Copyright (c) 2013 Sharif Younes. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Game;
@interface ResultsViewController : UIViewController 

@property (weak, nonatomic) IBOutlet UILabel *gameCompletedDisplay;
@property (strong, nonatomic) IBOutlet UIScrollView *questionsDisplay;
@property (nonatomic, strong) NSMutableArray *userAnswers;
@property (nonatomic, strong) Game *gamePlayed;
@property (nonatomic) int gameIndex;
@property (weak, nonatomic) IBOutlet UIButton *mainMenuButton;

- (IBAction)mainMenuPressed:(id)sender;

@end
