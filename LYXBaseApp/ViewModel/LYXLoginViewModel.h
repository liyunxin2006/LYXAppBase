//
//  LYXLoginViewModel.h
//  LYXBaseApp
//
//  Created by Yunxin.Li on 15/10/23.
//  Copyright © 2015年 LYX. All rights reserved.
//

#import "LYXViewModel.h"

@interface LYXLoginViewModel : LYXViewModel

// The avatar URL of the user.
@property (nonatomic, copy, readonly) NSURL *avatarURL;

// The username entered by the user.
@property (nonatomic, copy) NSString *username;

// The password entered by the user.
@property (nonatomic, copy) NSString *password;

@property (nonatomic, strong, readonly) RACSignal *validLoginSignal;

// The command of login button.
@property (nonatomic, strong, readonly) RACCommand *loginCommand;

// The command of uses browser to login button.
@property (nonatomic, strong, readonly) RACCommand *browserLoginCommand;

@end
