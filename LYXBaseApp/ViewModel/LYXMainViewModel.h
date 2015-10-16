//
//  LYXMainViewModel.h
//  LYXBaseApp
//
//  Created by Yunxin.Li on 15/10/15.
//  Copyright © 2015年 LYX. All rights reserved.
//

#import "LYXTabBarViewModel.h"
#import "LYXHomeViewModel.h"
#import "LYXMeViewModel.h"

@interface LYXMainViewModel : LYXTabBarViewModel

// The view model of `Home` interface.
@property (nonatomic, strong, readonly) LYXHomeViewModel *homeViewModel;

// The view model of `Me` interface.
@property (nonatomic, strong, readonly) LYXMeViewModel *meViewModel;

@end