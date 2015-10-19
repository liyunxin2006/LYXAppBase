//
//  LYXViewModelServices.h
//  LYXBaseApp
//
//  Created by Yunxin.Li on 15/10/15.
//  Copyright © 2015年 LYX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LYXNavigationProtocol.h"
#import "LYXRepositoryService.h"
#import "LYXAppStoreService.h"

@protocol LYXViewModelServices <NSObject, LYXNavigationProtocol>

@required

// A reference to OCTClient instance.
//@property (nonatomic, strong) OCTClient *client;
//
@property (nonatomic, strong, readonly) id<LYXRepositoryService> repositoryService;
@property (nonatomic, strong, readonly) id<LYXAppStoreService> appStoreService;

@end
