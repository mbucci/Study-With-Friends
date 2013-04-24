//
//  StudyViewController.m
//  Study With Friends
//
//  Created by Sharif Younes on 4/7/13.
//  Copyright (c) 2013 Sharif Younes. All rights reserved.
//

#import "StudyViewController.h"

@interface StudyViewController ()

@property (nonatomic,retain) Login *loginCheck;
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UILabel *loginLabel;

@end

@implementation StudyViewController

@synthesize loginCheck = _loginCheck;
@synthesize username = _username;
@synthesize password = _password;
@synthesize loginLabel = _loginLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
    UINavigationItem *item = [[UINavigationItem alloc]init];
    [self.navigationController setNavigationBarHidden:YES];
    item = [self.navigationController.navigationBar.items lastObject];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.view addGestureRecognizer:tapGesture];
    
    self.password.secureTextEntry = YES;
    self.username.placeholder = @"Username";
    self.password.placeholder = @"Password";
    self.username.clearsOnBeginEditing = YES;
    self.password.clearsOnBeginEditing = YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)tap:(UITapGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        [self.username resignFirstResponder];
        [self.password resignFirstResponder];
    }
}

- (Login *)loginCheck
{
    if (!_loginCheck)
        _loginCheck = [[Login alloc]init];
    return _loginCheck;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    CoursesTableViewController *CTVC = [[CoursesTableViewController alloc] init];
    if ([[segue destinationViewController] isKindOfClass:[CoursesTableViewController class]]){
        CTVC = [segue destinationViewController];
        CTVC.segueType = [segue identifier];
    }
    
}


- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([identifier isEqualToString:@"Student"]) {
        if([self.loginCheck checkLoginForUsername:self.username.text andPassword:self.password.text forCredentials:@"Student"]) {
            return YES;
        } else {
            self.loginLabel.text = @"Invalid Login";
            return NO;
        }
    }
    
    if ([identifier isEqualToString:@"Teacher"]) {
        if([self.loginCheck checkLoginForUsername:self.username.text andPassword:self.password.text forCredentials:@"Teacher"]) {
            return YES;
        } else {
            self.loginLabel.text = @"Invalid Login";
            return NO;
        }
    }
    return NO;
}


- (IBAction)newLogin:(id)sender
{
    [self.loginCheck addToDictionaryUsername:self.username.text andPassword:self.password.text];
}
@end
