//
//  OCTEvent+LYXPersistence.h
//  LYXBaseApp
//
//  Created by Yunxin.Li on 15/10/26.
//  Copyright © 2015年 LYX. All rights reserved.
//

#import "OctoKit.h"

@interface OCTEvent (LYXPersistence)

+ (BOOL)lyx_saveUserReceivedEvents:(NSArray *)events;
+ (BOOL)lyx_saveUserPerformedEvents:(NSArray *)events;

+ (NSArray *)lyx_fetchUserReceivedEvents;
+ (NSArray *)lyx_fetchUserPerformedEvents;

@end
