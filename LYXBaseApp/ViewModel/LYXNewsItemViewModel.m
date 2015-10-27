//
//  LYXNewsItemViewModel.m
//  LYXBaseApp
//
//  Created by Yunxin.Li on 15/10/26.
//  Copyright © 2015年 LYX. All rights reserved.
//

#import "LYXNewsItemViewModel.h"
#import "TTTTimeIntervalFormatter.h"

@interface LYXNewsItemViewModel ()

@property (nonatomic, strong, readwrite) OCTEvent *event;
@property (nonatomic, copy, readwrite) NSAttributedString *attributedString;

@end

@implementation LYXNewsItemViewModel

- (instancetype)initWithEvent:(OCTEvent *)event {
    self = [super init];
    if (self) {
        self.event = event;
        self.attributedString = event.lyx_attributedString;
    }
    return self;
}

@end
