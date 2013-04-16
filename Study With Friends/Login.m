//
//  Login.m
//  Study With Friends
//
//  Created by Max Bucci on 4/12/13.
//  Copyright (c) 2013 Sharif Younes. All rights reserved.
//

#import "Login.h"

@interface Login()

@property (nonatomic, strong) NSMutableDictionary *loginInfo;

@end

@implementation Login

@synthesize loginInfo = _loginInfo;


- (NSMutableDictionary *)loginInfo
{
    if (!_loginInfo) {
        NSArray *userNames = [[NSArray alloc] initWithObjects:@"mbucci", @"syounes", nil];
        NSArray *passwords = [[NSArray alloc] initWithObjects:@"123", @"456", nil];
        _loginInfo = [[NSMutableDictionary alloc] initWithObjects:passwords forKeys:userNames];
    }
    return _loginInfo;
}


- (void)addToDictionaryUsername:(NSString *)username andPassword:(NSString *)password
{
    NSArray *newUsername = [[NSArray alloc] initWithObjects:username, nil];
    NSArray *newPassword = [[NSArray alloc] initWithObjects:password, nil];
    NSDictionary *tempDictionary = [[NSDictionary alloc] initWithObjects:newPassword forKeys:newUsername];
    [self.loginInfo addEntriesFromDictionary:tempDictionary];
}


- (BOOL)checkLoginForUsername:(NSString *)userName andPassword:(NSString *)password
{
    if ([password isEqual:[self.loginInfo objectForKey:userName]]) {
        return YES;
    } else {
        return NO;
    }
                    
}

@end
