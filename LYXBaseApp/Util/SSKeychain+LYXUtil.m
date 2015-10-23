//
//  SSKeychain+LYXUtil.m
//  LYXBaseApp
//
//  Created by Yunxin.Li on 15/10/23.
//  Copyright © 2015年 LYX. All rights reserved.
//

#import "SSKeychain+LYXUtil.h"

@implementation SSKeychain (LYXUtil)

+ (NSString *)rawLogin {
    NSString *rawLogin = [[NSUserDefaults standardUserDefaults] objectForKey:LYX_RAW_LOGIN];
    if (rawLogin == nil) NSLog(@"+rawLogin: %@", rawLogin);
    return rawLogin;
}

+ (NSString *)password {
    return [self passwordForService:LYX_SERVICE_NAME account:LYX_PASSWORD];
}

+ (NSString *)accessToken {
    return [self passwordForService:LYX_SERVICE_NAME account:LYX_ACCESS_TOKEN];
}

+ (BOOL)setRawLogin:(NSString *)rawLogin {
    if (rawLogin == nil) NSLog(@"+setRawLogin: %@", rawLogin);
    
    [[NSUserDefaults standardUserDefaults] setObject:rawLogin forKey:LYX_RAW_LOGIN];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    return YES;
}

+ (BOOL)setPassword:(NSString *)password {
    return [self setPassword:password forService:LYX_SERVICE_NAME account:LYX_PASSWORD];
}

+ (BOOL)setAccessToken:(NSString *)accessToken {
    return [self setPassword:accessToken forService:LYX_SERVICE_NAME account:LYX_ACCESS_TOKEN];
}

+ (BOOL)deleteRawLogin {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:LYX_RAW_LOGIN];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    return YES;
}

+ (BOOL)deletePassword {
    return [self deletePasswordForService:LYX_SERVICE_NAME account:LYX_PASSWORD];
}

+ (BOOL)deleteAccessToken {
    return [self deletePasswordForService:LYX_SERVICE_NAME account:LYX_ACCESS_TOKEN];
}

@end
