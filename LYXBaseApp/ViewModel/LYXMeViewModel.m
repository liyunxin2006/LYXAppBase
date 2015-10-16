//
//  LYXMeViewModel.m
//  LYXBaseApp
//
//  Created by Yunxin.Li on 15/10/15.
//  Copyright © 2015年 LYX. All rights reserved.
//

#import "LYXMeViewModel.h"

@interface LYXMeViewModel ()

@end

@implementation LYXMeViewModel

- (instancetype)initWithServices:(id<LYXViewModelServices>)services params:(id)params {
    self = [super initWithServices:services params:params];
    if (self) {
        
    }
    return self;
}

- (void)initialize {
    [super initialize];
    
    self.title = NSLocalizedString(@"Me", nil);
}

@end