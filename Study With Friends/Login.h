//
//  Login.h
//  Study With Friends
//
//  Created by Max Bucci on 4/12/13.
//  Copyright (c) 2013 Sharif Younes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Login : NSObject

- (BOOL)checkLoginForUsername:(NSString *)userName andPassword:(NSString *)password;
- (BOOL)checkIfUsernameExists:(NSString *)userName;
- (void)addToDictionaryUsername:(NSString *)username andPassword:(NSString *)password;

@end
