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
#import "LYXNavigationControllerStack.h"
#import "LYXNavigationController.h"

@interface LYXMainViewController () <UITabBarControllerDelegate>

@property (nonatomic, strong, readonly) LYXMainViewModel *viewModel;

@property (nonatomic, strong) LYXHomeViewController *homeViewController;
@property (nonatomic, strong) LYXMeViewController *meViewController;

@end

@implementation LYXMainViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.homeViewController = [[LYXHomeViewController alloc] initWithViewModel:self.viewModel.homeViewModel];
    UIImage *newsImage = [UIImage octicon_imageWithIdentifier:@"Rss" size:CGSizeMake(25, 25)];
    self.homeViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"Home", nil) image:newsImage tag:1];
    
    self.meViewController = [[LYXMeViewController alloc] initWithViewModel:self.viewModel.meViewModel];
//    UIImage *reposImage = [UIImage octicon_imageWithIdentifier:@"Repo" size:CGSizeMake(25, 25)];
    self.meViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"Me", nil) image:nil tag:2];
    
    self.viewControllers = @[self.homeViewController, self.meViewController];
    
    [[[self
       rac_signalForSelector:@selector(tabBarController:didSelectViewController:)
       fromProtocol:@protocol(UITabBarControllerDelegate)]
      startWith:RACTuplePack(self, self.homeViewController)]
     subscribeNext:^(RACTuple *tuple) {
         RACTupleUnpack(UITabBarController *tabBarController, UIViewController *viewController) = tuple;
         
         tabBarController.navigationItem.title = [((LYXViewController *)viewController).viewModel title];
         
         if (viewController.tabBarItem.tag == 1) {
             tabBarController.navigationItem.titleView = nil;
         } else if (viewController.tabBarItem.tag == 2) {
             tabBarController.navigationItem.titleView = nil;
//             tabBarController.navigationItem.titleView = ((MRCReposViewController *)viewController).segmentedControl;
         } /*else if (viewController.tabBarItem.tag == 3) {
             tabBarController.navigationItem.titleView = ((MRCSearchViewController *)viewController).searchController.searchBar;
         } else if (viewController.tabBarItem.tag == 4) {
             tabBarController.navigationItem.titleView = nil;
         }*/
     }];
    self.delegate = self;
}

@end