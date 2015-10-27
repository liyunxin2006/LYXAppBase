//
//  NSURL+LYXLink.h
//  LYXBaseApp
//
//  Created by Yunxin.Li on 15/10/26.
//  Copyright © 2015年 LYX. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, LYXLinkType) {
    LYXLinkTypeUnknown,
    LYXLinkTypeUser,
    LYXLinkTypeRepository
};

@interface NSURL (LYXLink)

@property (nonatomic, assign, readonly) LYXLinkType type;

+ (instancetype)lyx_userLinkWithLogin:(NSString *)login;
+ (instancetype)lyx_repositoryLinkWithName:(NSString *)name referenceName:(NSString *)referenceName;

- (NSDictionary *)lyx_dictionary;

@end

@interface OCTEvent (LYXLink)

- (NSURL *)lyx_Link;

@end