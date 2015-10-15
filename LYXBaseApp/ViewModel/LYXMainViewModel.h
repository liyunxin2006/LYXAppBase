//
//  LYXMainViewModel.h
//  LYXBaseApp
//
//  Created by Yunxin.Li on 15/10/15.
//  Copyright © 2015年 LYX. All rights reserved.
//

#import "LYXTabBarViewModel.h"
#import "LYXHomeViewModel.h"
//#import "MRCReposViewModel.h"
//#import "MRCSearchViewModel.h"
#import "LYXMeViewModel.h"

@interface LYXMainViewModel : LYXTabBarViewModel

// The view model of `Home` interface.
@property (nonatomic, strong, readonly) LYXHomeViewModel *homeViewModel;

//// The view model of `Repositories` interface.
//@property (nonatomic, strong, readonly) MRCReposViewModel *reposViewModel;
//
//// The view model of `Search` interface.
//@property (nonatomic, strong, readonly) MRCSearchViewModel *searchViewModel;

// The view model of `Me` interface.
@property (nonatomic, strong, readonly) LYXMeViewModel *meViewModel;

@end