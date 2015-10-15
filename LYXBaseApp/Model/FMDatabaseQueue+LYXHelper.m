//
//  FMDatabaseQueue+LYXHelper.m
//  LYXBaseApp
//
//  Created by Yunxin.Li on 15/10/15.
//  Copyright © 2015年 LYX. All rights reserved.
//

#import "FMDatabaseQueue+LYXHelper.h"

@implementation FMDatabaseQueue (LYXHelper)

+ (instancetype)sharedInstance {
    static FMDatabaseQueue *databaseQueue = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        databaseQueue = [FMDatabaseQueue databaseQueueWithPath:LYX_FMDB_PATH];
    });
    return databaseQueue;
}

@end
