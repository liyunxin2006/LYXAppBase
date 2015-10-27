//
//  OCTEvent+LYXPersistence.m
//  LYXBaseApp
//
//  Created by Yunxin.Li on 15/10/26.
//  Copyright © 2015年 LYX. All rights reserved.
//

#import "OCTEvent+LYXPersistence.h"

@implementation OCTEvent (LYXPersistence)

+ (BOOL)lyx_saveUserReceivedEvents:(NSArray *)events {
    return [NSKeyedArchiver archiveRootObject:events toFile:[self receivedEventsPersistencePath]];
}

+ (BOOL)lyx_saveUserPerformedEvents:(NSArray *)events {
    return [NSKeyedArchiver archiveRootObject:events toFile:[self performedEventsPersistencePath]];
}

+ (NSArray *)lyx_fetchUserReceivedEvents {
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[self receivedEventsPersistencePath]];
}

+ (NSArray *)lyx_fetchUserPerformedEvents {
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[self performedEventsPersistencePath]];
}

#pragma mark - Private Method

+ (NSString *)persistenceDirectory {
    NSString *path = [NSString stringWithFormat:@"%@/Persistence/%@", LYX_DOCUMENT_DIRECTORY, [OCTUser lyx_currentUser].login];
    
    BOOL isDirectory;
    BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDirectory];
    if (!isExist || !isDirectory) {
        NSError *error = nil;
        BOOL success = [[NSFileManager defaultManager] createDirectoryAtPath:path
                                                 withIntermediateDirectories:YES
                                                                  attributes:nil
                                                                       error:&error];
        if (success) {
            [self addSkipBackupAttributeToItemAtPath:path];
        } else {
            LYXLogError(error);
        }
    }
    
    return path;
}

+ (NSString *)receivedEventsPersistencePath {
    return [[self persistenceDirectory] stringByAppendingPathComponent:@"ReceivedEvents"];
}

+ (NSString *)performedEventsPersistencePath {
    return [[self persistenceDirectory] stringByAppendingPathComponent:@"PerformedEvents"];
}

+ (BOOL)addSkipBackupAttributeToItemAtPath:(NSString *)filePathString {
    NSURL *URL = [NSURL fileURLWithPath:filePathString];
    
    assert([[NSFileManager defaultManager] fileExistsAtPath:URL.path]);
    
    NSError *error = nil;
    BOOL success = [URL setResourceValue:@(YES) forKey:NSURLIsExcludedFromBackupKey error:&error];
    if (error) LYXLogError(error);
    
    return success;
}

@end
