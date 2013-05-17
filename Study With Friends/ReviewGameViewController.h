//
//  ReviewGameViewController.h
//  MakeNewGame
//
//  Created by Sharif Younes on 5/16/13.
//  Copyright (c) 2013 Sharif Younes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReviewGameViewController : UIViewController


@property (weak, nonatomic) IBOutlet UILabel *reviewGameDisplay;
@property (strong, nonatomic) IBOutlet UIScrollView *gameDisplay;
@property (strong, nonatomic) NSString *gameTitle;
@property (strong, nonatomic) NSString *courseTitle;
@property (nonatomic) int gameLength;
@property (strong, nonatomic) NSArray *answerKey;
@property (strong, nonatomic) NSArray *questionSet;

@property (weak, nonatomic) IBOutlet UIButton *createOutlet;
- (IBAction)create:(UIButton *)sender;

@end
