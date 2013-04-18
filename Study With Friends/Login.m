//
//  Login.m
//  Study With Friends
//
//  Created by Max Bucci on 4/12/13.
//  Copyright (c) 2013 Sharif Younes. All rights reserved.
//

#import "Login.h"

@interface Login()

@property (nonatomic, strong) NSMutableDictionary *studentLoginInfo;
@property (nonatomic, strong) NSMutableDictionary *teacherLoginInfo;

@end

@implementation Login

@synthesize studentLoginInfo = _studentLoginInfo;
@synthesize teacherLoginInfo = _teacherLoginInfo;


- (NSMutableDictionary *)studentLoginInfo
{
    if (!_studentLoginInfo) {
        NSArray *userNames = [[NSArray alloc] initWithObjects:@"mbucci", @"syounes", nil];
        NSArray *passwords = [[NSArray alloc] initWithObjects:@"123", @"456", nil];
        _studentLoginInfo = [[NSMutableDictionary alloc] initWithObjects:passwords forKeys:userNames];
    }
    return _studentLoginInfo;
}

- (NSMutableDictionary *)teacherLoginInfo
{
    if (!_teacherLoginInfo) {
        NSArray *userNames = [[NSArray alloc] initWithObjects:@"apensava", nil];
        NSArray *passwords = [[NSArray alloc] initWithObjects:@"789", nil];
        _teacherLoginInfo = [[NSMutableDictionary alloc] initWithObjects:passwords forKeys:userNames];
    }
    return _teacherLoginInfo;
}


- (void)addToDictionaryUsername:(NSString *)username andPassword:(NSString *)password
{
    NSArray *newUsername = [[NSArray alloc] initWithObjects:username, nil];
    NSArray *newPassword = [[NSArray alloc] initWithObjects:password, nil];
    NSDictionary *tempDictionary = [[NSDictionary alloc] initWithObjects:newPassword forKeys:newUsername];
    [self.studentLoginInfo addEntriesFromDictionary:tempDictionary];
}


- (BOOL)checkLoginForUsername:(NSString *)userName andPassword:(NSString *)password forCredentials:(NSString *)creds
{
    if ([creds isEqualToString:@"Student"]) {
        if ([password isEqual:[self.studentLoginInfo objectForKey:userName]]) {
            return YES;
        } else {
            return NO;
        }
    }
    
    if ([creds isEqualToString:@"Teacher"]) {
        if ([password isEqual:[self.teacherLoginInfo objectForKey:userName]]) {
            return YES;
        } else {
            return NO;
        }
    }
    return NO;
}

@end
