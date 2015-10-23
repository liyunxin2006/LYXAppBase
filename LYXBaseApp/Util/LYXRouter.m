//
//  LYXRouter.m
//  LYXBaseApp
//
//  Created by Yunxin.Li on 15/10/15.
//  Copyright © 2015年 LYX. All rights reserved.
//

#import "LYXRouter.h"
#import "LYXViewProtocol.h"

static LYXRouter *_sharedInstance = nil;

@interface LYXRouter ()

@property (nonatomic, copy) NSDictionary *viewModelViewMappings; // viewModel到view的映射

@end

@implementation LYXRouter

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[super allocWithZone:NULL] init];
    });
    return _sharedInstance;
}

- (id<LYXViewProtocol>)viewControllerForViewModel:(id<LYXViewModelProtocol>)viewModel {
    NSString *viewController = [self.viewModelViewMappings valueForKey:NSStringFromClass(((NSObject *)viewModel).class)];
    
    NSParameterAssert([NSClassFromString(viewController) conformsToProtocol:@protocol(LYXViewProtocol)]);
    NSParameterAssert([NSClassFromString(viewController) instancesRespondToSelector:@selector(initWithViewModel:)]);
    
    return [[NSClassFromString(viewController) alloc] initWithViewModel:viewModel];
}

- (NSDictionary *)viewModelViewMappings {
    return @{
             @"LYXLoginViewModel": @"LYXLoginViewController",
             @"LYXMainViewModel": @"LYXMainViewController",
             @"LYXHomeViewModel": @"LYXHomeViewController",
             @"LYXMeViewModel": @"LYXMeViewController",
             };
}

@end