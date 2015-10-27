//
//  LYXHomeViewModel.h
//  LYXBaseApp
//
//  Created by Yunxin.Li on 15/10/15.
//  Copyright © 2015年 LYX. All rights reserved.
//

#import "LYXTableViewModel.h"

typedef NS_ENUM(NSUInteger, LYXNewsViewModelType) {
    LYXNewsViewModelTypeNews,
    LYXNewsViewModelTypePublicActivity
};

@interface LYXHomeViewModel : LYXTableViewModel

@property (nonatomic, copy, readonly) NSArray *events;
@property (nonatomic, assign, readonly) BOOL isCurrentUser;
@property (nonatomic, assign, readonly) LYXNewsViewModelType type;
@property (nonatomic, strong, readonly) RACCommand *didClickLinkCommand;

- (NSArray *)dataSourceWithEvents:(NSArray *)events;

@end