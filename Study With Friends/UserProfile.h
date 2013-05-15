//
//  UserProfile.h
//  Study With Friends
//
//  Created by Max Bucci on 5/14/13.
//  Copyright (c) 2013 Sharif Younes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StudyGames.h"

@interface UserProfile : NSObject

@property (nonatomic, weak) NSString *userName;
@property (nonatomic, retain) StudyGames *userGames;


+ (UserProfile *)createNewUser:(NSString *)userName;

@end
