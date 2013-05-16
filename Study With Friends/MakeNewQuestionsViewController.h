//
//  MakeNewQuestionsViewController.h
//  MakeNewGame
//
//  Created by Sharif Younes on 5/12/13.
//  Copyright (c) 2013 Sharif Younes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"
#import "StudyGames.h"


@interface MakeNewQuestionsViewController : UIViewController <UITextViewDelegate> {
    NSString *gameTitle;
}


@property (strong, nonatomic) NSString *gameTitle;

//buttons
@property (weak, nonatomic) IBOutlet UIBarButtonItem *back;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *next;

//buttons associated with adding/removing options
- (IBAction)addOptionC:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *addOptionCOutlet;

- (IBAction)addOptionD:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *addOptionDOutlet;

@property (weak, nonatomic) IBOutlet UIButton *deleteOptionCOutlet;

@property (weak, nonatomic) IBOutlet UIButton *deleteOptionDOutlet;
- (IBAction)deleteOptionC:(UIButton *)sender;
- (IBAction)deleteOptionD:(UIButton *)sender;


//text views
@property (weak, nonatomic) IBOutlet UITextView *question;
@property (weak, nonatomic) IBOutlet UITextView *optionA;
@property (weak, nonatomic) IBOutlet UITextView *optionB;
@property (weak, nonatomic) IBOutlet UITextView *optionC;
@property (weak, nonatomic) IBOutlet UITextView *optionD;
@property (weak, nonatomic) IBOutlet UITextView *correctResponse;


//buttons
@property (weak, nonatomic) IBOutlet UIButton *deleteOutlet;
@property (weak, nonatomic) IBOutlet UIButton *revertOutlet;
@property (weak, nonatomic) IBOutlet UIButton *saveOutlet;
@property (weak, nonatomic) IBOutlet UIButton *makeOutlet;

@property (retain, nonatomic) StudyGames *gamesToAddToo;

- (IBAction)makeGame:(UIButton *)sender;

- (IBAction)saveQuestion:(UIButton *)sender;
- (IBAction)revertQuestion:(UIButton *)sender;
- (IBAction)backButton:(UIBarButtonItem *)sender;
- (IBAction)nextButton:(UIBarButtonItem *)sender;


//"question saved" label
@property (weak, nonatomic) IBOutlet UILabel *questionSavedMessage;


@end
