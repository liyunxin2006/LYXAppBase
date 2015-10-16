//
//  LYXHomeViewModel.m
//  LYXBaseApp
//
//  Created by Yunxin.Li on 15/10/15.
//  Copyright © 2015年 LYX. All rights reserved.
//

#import "LYXHomeViewModel.h"

@interface LYXHomeViewModel ()

@end

@implementation LYXHomeViewModel

- (instancetype)initWithServices:(id<LYXViewModelServices>)services params:(id)params {
    self = [super initWithServices:services params:params];
    if (self) {
        
    }
    return self;
}

- (void)initialize {
    [super initialize];
    
    self.title = @"首页";
    
    self.shouldPullToRefresh = YES;
    self.shouldInfiniteScrolling = YES;
}

@end