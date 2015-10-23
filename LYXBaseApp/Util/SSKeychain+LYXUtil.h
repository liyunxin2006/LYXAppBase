//
//  SSKeychain+LYXUtil.h
//  LYXBaseApp
//
//  Created by Yunxin.Li on 15/10/23.
//  Copyright © 2015年 LYX. All rights reserved.
//

#import "SSKeychain.h"

@interface SSKeychain (LYXUtil)

+ (NSString *)rawLogin;
+ (NSString *)password;
+ (NSString *)accessToken;

+ (BOOL)setRawLogin:(NSString *)rawLogin;
+ (BOOL)setPassword:(NSString *)password;
+ (BOOL)setAccessToken:(NSString *)accessToken;

+ (BOOL)deleteRawLogin;
+ (BOOL)deletePassword;
+ (BOOL)deleteAccessToken;

@end

