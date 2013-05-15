//
//  StudyViewController.m
//  Study With Friends
//
//  Created by Sharif Younes on 4/7/13.
//  Modifield by Max Bucci on 4/11/13
//  Copyright (c) 2013 Sharif Younes. All rights reserved.
//

#import "StudyViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface StudyViewController ()

@property (nonatomic,retain) Login *loginCheck;
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UILabel *loginLabel;
@property (retain, nonatomic) NSMutableDictionary *users;

@end

@implementation StudyViewController

@synthesize loginCheck = _loginCheck;
@synthesize username = _username;
@synthesize password = _password;
@synthesize loginLabel = _loginLabel;
@synthesize firstLoginButton = _firstLoginButton;
@synthesize loginButton = _loginButton;
@synthesize users = _users;

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
    
    [self setLayerToButton:self.loginButton];
    [self setLayerToButton:self.firstLoginButton];
    [self.loginButton setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    [self.firstLoginButton setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];

}


- (void)viewDidAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
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


- (NSMutableDictionary *)users
{
    if (!_users) {
        UserProfile *mbucci = [UserProfile createNewUser:@"mbucci"];
        UserProfile *syounes = [UserProfile createNewUser:@"syounes"];
        UserProfile *apensava = [UserProfile createNewUser:@"apensava"];
        NSArray *userArray = [NSArray arrayWithObjects:mbucci, syounes, apensava, nil];
        NSArray *keys = [NSArray arrayWithObjects:@"mbucci", @"syounes", @"apensava", nil];
        _users = [[NSMutableDictionary alloc]initWithObjects:userArray forKeys:keys];
    }
    
    return _users;
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
    StatisticsViewController *SVC = [[StatisticsViewController alloc]init];
    UITabBarController *TBC = [[UITabBarController alloc]init];
    if ([[segue destinationViewController] isKindOfClass:[UITabBarController class]]){
        TBC = [segue destinationViewController];
        UserProfile *temp = [self.users objectForKey:self.username.text];
        for (id obj in TBC.viewControllers) {
            if ([obj isKindOfClass:[CoursesTableViewController class]]) {
                CTVC = obj;
                CTVC.userDelegate = temp;
            }
            if ([obj isKindOfClass:[StatisticsViewController class]]) {
                SVC = obj;
                SVC.statisticsGamesDelegate = temp.userGames.games;
            }
        }
    }
    
}


- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if([self.loginCheck checkLoginForUsername:self.username.text andPassword:self.password.text]) {
        return YES;
    } else {
        self.loginLabel.text = @"Invalid Login";
        return NO;
    }
}


- (IBAction)unwindOnSelect:(UIStoryboardSegue *)segue{
    [self.username resignFirstResponder];
    [self.password resignFirstResponder];
    self.username.text = nil;
    self.password.text = nil;
    self.loginLabel.text = nil;
    
}


- (IBAction)newLogin:(id)sender
{
    if (self.username.text.length < 1 || self.password.text.length < 6 || self.password.text.length > 18) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Username or Password"
                                                        message:@"Username must be at least 1 character, and Password must be betweeen 6 and 18 characters"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        [alert show];
        
    } else if (![self.loginCheck checkIfUsernameExists:self.username.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"That Username Already Exists"
                                                        message:@"Please choose a different username"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        [alert show];
        
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Account Created"
                                                        message:@"Welcome to Study with Friends!"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        [alert show];
        [self.loginCheck addToDictionaryUsername:self.username.text andPassword:self.password.text];
        UserProfile *newUser = [UserProfile createNewUser:self.username.text];
        NSArray *newUsername = [[NSArray alloc] initWithObjects:newUser, nil];
        NSArray *newkey = [[NSArray alloc] initWithObjects:self.username.text, nil];
        NSDictionary *tempDictionary = [[NSDictionary alloc] initWithObjects:newUsername forKeys:newkey];
        [self.users addEntriesFromDictionary:tempDictionary];
    }
    self.loginLabel.text = nil;
}
@end
