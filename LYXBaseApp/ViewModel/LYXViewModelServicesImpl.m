//
//  LYXViewModelServicesImpl.m
//  LYXBaseApp
//
//  Created by Yunxin.Li on 15/10/15.
//  Copyright © 2015年 LYX. All rights reserved.
//

#import "LYXViewModelServicesImpl.h"
#import "LYXRepositoryServiceImpl.h"
#import "LYXAppStoreServiceImpl.h"

@implementation LYXViewModelServicesImpl

@synthesize client = _client;
@synthesize repositoryService = _repositoryService;
@synthesize appStoreService = _appStoreService;

- (instancetype)init {
    self = [super init];
    if (self) {
        _repositoryService = [[LYXRepositoryServiceImpl alloc] init];
        _appStoreService   = [[LYXAppStoreServiceImpl alloc] init];
    }
    return self;
}

- (void)pushViewModel:(id<LYXViewModelProtocol>)viewModel animated:(BOOL)animated {}

- (void)popViewModelAnimated:(BOOL)animated {}

- (void)popToRootViewModelAnimated:(BOOL)animated {}

- (void)presentViewModel:(id<LYXViewModelProtocol>)viewModel animated:(BOOL)animated completion:(VoidBlock)completion {}

- (void)dismissViewModelAnimated:(BOOL)animated completion:(VoidBlock)completion {}

- (void)resetRootViewModel:(id<LYXViewModelProtocol>)viewModel {}

@end