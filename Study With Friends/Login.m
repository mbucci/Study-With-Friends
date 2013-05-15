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
@property (nonatomic, strong) NSMutableArray *userNamesSet;

@end

@implementation Login

@synthesize studentLoginInfo = _studentLoginInfo;
@synthesize userNamesSet = _userNamesSet;


- (NSMutableDictionary *)studentLoginInfo
{
    if (!_studentLoginInfo) {
        NSArray *userNames = [[NSArray alloc] initWithObjects:@"mbucci", @"syounes", @"apensava", nil];
        NSArray *passwords = [[NSArray alloc] initWithObjects:@"123", @"456", @"789", nil];
        _studentLoginInfo = [[NSMutableDictionary alloc] initWithObjects:passwords forKeys:userNames];
    }
    return _studentLoginInfo;
}


- (NSMutableArray *)userNamesSet
{
    if (!_userNamesSet) {
        _userNamesSet = [[NSMutableArray alloc]initWithObjects:@"mbucci", @"syounes", @"apensava", nil];
    }
    return _userNamesSet;
}


- (void)addToDictionaryUsername:(NSString *)username andPassword:(NSString *)password
{
    NSArray *newUsername = [[NSArray alloc] initWithObjects:username, nil];
    NSArray *newPassword = [[NSArray alloc] initWithObjects:password, nil];
    NSDictionary *tempDictionary = [[NSDictionary alloc] initWithObjects:newPassword forKeys:newUsername];
    [self.userNamesSet addObject:username];
    [self.studentLoginInfo addEntriesFromDictionary:tempDictionary];
}


- (BOOL)checkLoginForUsername:(NSString *)userName andPassword:(NSString *)password
{
    if ([password isEqual:[self.studentLoginInfo objectForKey:userName]]) {
        return YES;
    } else {
        return NO;
    }
    return NO;
}


- (BOOL)checkIfUsernameExists:(NSString *)userName
{
    for (id obj in self.userNamesSet) {
        if ([obj isEqualToString:userName]) {
            return NO;
        }
    }
    return YES;
}


@end
