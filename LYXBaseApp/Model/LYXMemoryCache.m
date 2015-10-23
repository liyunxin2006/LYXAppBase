//
//  LYXMemoryCache.m
//  LYXBaseApp
//
//  Created by Yunxin.Li on 15/10/23.
//  Copyright © 2015年 LYX. All rights reserved.
//

#import "LYXMemoryCache.h"

static LYXMemoryCache *_memoryCache = nil;

@interface LYXMemoryCache ()

@property (nonatomic, strong) NSMutableDictionary *dictionary;

@end

@implementation LYXMemoryCache

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _memoryCache = [[LYXMemoryCache alloc] init];
    });
    return _memoryCache;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _dictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (id)objectForKey:(NSString *)key {
    return [self.dictionary objectForKey:key];
}

- (void)setObject:(id)object forKey:(NSString *)key {
    [self.dictionary setObject:object forKey:key];
}

- (void)removeObjectForKey:(NSString *)key {
    [self.dictionary removeObjectForKey:key];
}

@end