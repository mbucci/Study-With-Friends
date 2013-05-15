//
//  StudyViewController.h
//  Study With Friends
//
//  Created by Sharif Younes on 4/7/13.
//  Copyright (c) 2013 Sharif Younes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Login.h"
#import "CoursesTableViewController.h"
#import "UserProfile.h"
#import "StatisticsViewController.h"

@interface StudyViewController : UIViewController

- (IBAction)newLogin:(id)sender;
- (IBAction)unwindOnSelect:(UIStoryboardSegue *)segue;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *firstLoginButton;

@end
