//
//  LYXMainViewModel.m
//  LYXBaseApp
//
//  Created by Yunxin.Li on 15/10/15.
//  Copyright © 2015年 LYX. All rights reserved.
//

#import "LYXMainViewModel.h"

@interface LYXMainViewModel ()

@property (nonatomic, strong, readwrite) LYXHomeViewModel    *homeViewModel;
//@property (nonatomic, strong, readwrite) MRCReposViewModel   *reposViewModel;
//@property (nonatomic, strong, readwrite) MRCSearchViewModel  *searchViewModel;
@property (nonatomic, strong, readwrite) LYXMeViewModel *meViewModel;

@end

@implementation LYXMainViewModel

- (void)initialize {
    [super initialize];
    
    self.homeViewModel    = [[LYXHomeViewModel alloc] initWithServices:self.services params:nil];
//    self.reposViewModel   = [[MRCReposViewModel alloc] initWithServices:self.services params:nil];
//    self.searchViewModel  = [[MRCSearchViewModel alloc] initWithServices:self.services params:nil];
    self.meViewModel = [[LYXMeViewModel alloc] initWithServices:self.services params:nil];
}

@end