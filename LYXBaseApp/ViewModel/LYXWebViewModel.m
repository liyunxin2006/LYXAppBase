//
//  LYXWebViewModel.m
//  LYXBaseApp
//
//  Created by Yunxin.Li on 15/10/15.
//  Copyright © 2015年 LYX. All rights reserved.
//

#import "LYXWebViewModel.h"

@implementation LYXWebViewModel

- (instancetype)initWithServices:(id<LYXViewModelServices>)services params:(id)params {
    self = [super initWithServices:services params:params];
    if (self) {
        self.request = params[@"request"];
    }
    return self;
}

@end