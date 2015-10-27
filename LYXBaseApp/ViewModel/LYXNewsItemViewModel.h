//
//  LYXNewsItemViewModel.h
//  LYXBaseApp
//
//  Created by Yunxin.Li on 15/10/26.
//  Copyright © 2015年 LYX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYXNewsItemViewModel : NSObject

@property (nonatomic, strong, readonly) OCTEvent *event;
@property (nonatomic, copy, readonly) NSAttributedString *attributedString;

@property (nonatomic, assign) CGFloat height;
@property (nonatomic, strong) RACCommand *didClickLinkCommand;

- (instancetype)initWithEvent:(OCTEvent *)event;

@end

