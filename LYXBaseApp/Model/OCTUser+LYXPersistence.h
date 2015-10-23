//
//  OCTUser+LYXPersistence.h
//  LYXBaseApp
//
//  Created by Yunxin.Li on 15/10/23.
//  Copyright © 2015年 LYX. All rights reserved.
//

#import "OctoKit.h"
#import "LYXPersistenceProtocol.h"

typedef NS_ENUM(NSUInteger, OCTUserFollowerStatus) {
    OCTUserFollowerStatusUnknown,
    OCTUserFollowerStatusYES,
    OCTUserFollowerStatusNO
};

typedef NS_ENUM(NSUInteger, OCTUserFollowingStatus) {
    OCTUserFollowingStatusUnknown,
    OCTUserFollowingStatusYES,
    OCTUserFollowingStatusNO
};

@interface OCTUser (LYXPersistence) <LYXPersistenceProtocol>

@property (nonatomic, assign) OCTUserFollowerStatus  followerStatus;
@property (nonatomic, assign) OCTUserFollowingStatus followingStatus;

- (BOOL)lyx_updateRawLogin;

+ (BOOL)lyx_saveOrUpdateUsers:(NSArray *)users;
+ (BOOL)lyx_saveOrUpdateFollowerStatusWithUsers:(NSArray *)users;
+ (BOOL)lyx_saveOrUpdateFollowingStatusWithUsers:(NSArray *)users;

+ (NSString *)lyx_currentUserId;

+ (instancetype)lyx_userWithRawLogin:(NSString *)rawLogin server:(OCTServer *)server;
+ (instancetype)lyx_currentUser;
+ (instancetype)lyx_fetchUserWithRawLogin:(NSString *)rawLogin;
+ (instancetype)lyx_fetchUser:(OCTUser *)user;

+ (BOOL)lyx_followUser:(OCTUser *)user;
+ (BOOL)lyx_unfollowUser:(OCTUser *)user;

+ (NSArray *)lyx_fetchFollowersWithPage:(NSUInteger)page perPage:(NSUInteger)perPage;
+ (NSArray *)lyx_fetchFollowingWithPage:(NSUInteger)page perPage:(NSUInteger)perPage;

@end