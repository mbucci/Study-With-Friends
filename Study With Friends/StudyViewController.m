//
//  StudyViewController.m
//  Study With Friends
//
//  Created by Sharif Younes on 4/7/13.
//  Copyright (c) 2013 Sharif Younes. All rights reserved.
//

#import "StudyViewController.h"

@interface StudyViewController ()

@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UILabel *loginLabel;
@property (retain, nonatomic) Login *login;

@end

@implementation StudyViewController

@synthesize username = _username;
@synthesize password = _password;
@synthesize loginLabel = _loginLabel;
@synthesize login = _login;

- (void)viewDidLoad
{
    [super viewDidLoad];
    UINavigationItem *item = [[UINavigationItem alloc]init];
    [self.navigationController setNavigationBarHidden:YES];
    item = [self.navigationController.navigationBar.items lastObject];
    self.password.secureTextEntry = YES;
    
	// Do any additional setup after loading the view, typically from a nib.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    
}


- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if([Login checkLoginForUsername:self.username.text andPassword:self.password.text]) {
        return YES;
    } else {
        self.loginLabel.text = @"Invalid Login";
        return NO;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)newLogin:(id)sender {
    [self.login addToDictionaryUsername:self.username.text andPassword:self.password.text];
}
@end
