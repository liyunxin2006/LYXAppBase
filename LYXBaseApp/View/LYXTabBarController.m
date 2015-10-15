//
//  LYXTabBarController.m
//  LYXBaseApp
//
//  Created by Yunxin.Li on 15/10/15.
//  Copyright © 2015年 LYX. All rights reserved.
//

#import "LYXTabBarController.h"

@implementation LYXTabBarController

@synthesize viewModel = _viewModel;

- (id<LYXViewProtocol>)initWithViewModel:(id)viewModel {
    _viewModel = viewModel;
    self = [super init];
    if (self) {
    }
    return self;
}

- (BOOL)shouldAutorotate {
    return self.selectedViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.selectedViewController.supportedInterfaceOrientations;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.selectedViewController.preferredStatusBarStyle;
}

@end