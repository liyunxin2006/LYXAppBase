//
//  LYXMainViewController.m
//  LYXBaseApp
//
//  Created by Yunxin.Li on 15/10/15.
//  Copyright © 2015年 LYX. All rights reserved.
//

#import "LYXMainViewController.h"
#import "LYXMainViewModel.h"
#import "LYXHomeViewController.h"
#import "LYXMeViewController.h"
#import "LYXHomeViewModel.h"
#import "LYXMeViewModel.h"
#import "LYXNavigationController.h"

@interface LYXMainViewController ()

@property (nonatomic, strong) LYXMainViewModel *viewModel;

@end

@implementation LYXMainViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINavigationController *homeNavigationController = ({
        LYXHomeViewController *homeViewController = [[LYXHomeViewController alloc] initWithViewModel:self.viewModel.homeViewModel];
        
        UIImage *newsImage = [UIImage octicon_imageWithIdentifier:@"Rss" size:CGSizeMake(25, 25)];
        homeViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"News" image:newsImage tag:1];
        
        [[LYXNavigationController alloc] initWithRootViewController:homeViewController];
    });
    
    UINavigationController *meNavigationController = ({
        LYXMeViewController *meViewController = [[LYXMeViewController alloc] initWithViewModel:self.viewModel.meViewModel];
        
        UIImage *profileImage = [UIImage octicon_imageWithIdentifier:@"Person" size:CGSizeMake(25, 25)];
        meViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Profile" image:profileImage tag:2];
        
        [[LYXNavigationController alloc] initWithRootViewController:meViewController];
    });
    
    self.tabBarController.viewControllers = @[ homeNavigationController, meNavigationController ];
    
    [LYXSharedAppDelegate.navigationControllerStack pushNavigationController:homeNavigationController];
    
    [[self
      rac_signalForSelector:@selector(tabBarController:didSelectViewController:)
      fromProtocol:@protocol(UITabBarControllerDelegate)]
     subscribeNext:^(RACTuple *tuple) {
         [LYXSharedAppDelegate.navigationControllerStack popNavigationController];
         [LYXSharedAppDelegate.navigationControllerStack pushNavigationController:tuple.second];
     }];
    self.tabBarController.delegate = self;
}

@end