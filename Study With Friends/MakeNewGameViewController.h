//
//  MakeNewGameViewController.h
//  MakeNewGame
//
//  Created by Sharif Younes on 5/12/13.
//  Copyright (c) 2013 Sharif Younes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"
#import "StudyGames.h"

@interface MakeNewGameViewController : UIViewController <UITextFieldDelegate> {
    NSString *titleString;

}



//properties for text fields on first screen
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;

@property (strong, nonatomic) NSString *titleString;
@property (strong, nonatomic) Game *model;
@property (retain, nonatomic) StudyGames *gamesDelegate;



- (IBAction)enter:(UIButton *)sender;

@end
