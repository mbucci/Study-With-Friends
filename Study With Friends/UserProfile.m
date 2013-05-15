//
//  UserProfile.m
//  Study With Friends
//
//  Created by Max Bucci on 5/14/13.
//  Copyright (c) 2013 Sharif Younes. All rights reserved.
//

#import "UserProfile.h"

@implementation UserProfile

@synthesize userName = _userName;
@synthesize userGames = _userGames;



- (StudyGames *)userGames
{
    if (!_userGames) {
        _userGames = [[StudyGames alloc]init];
    }
    return _userGames;
}


+ (UserProfile *)createNewUser:(NSString *)userName
{
    UserProfile *newProfile = [[UserProfile alloc]init];
    newProfile.userName = userName;
    
    return newProfile;
}

@end
