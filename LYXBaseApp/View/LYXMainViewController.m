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

@interface LYXMainViewController () <RDVTabBarControllerDelegate>

@property (nonatomic, strong, readonly) LYXMainViewModel *viewModel;

@property (nonatomic, strong) LYXHomeViewController *homeViewController;
@property (nonatomic, strong) LYXMeViewController *meViewController;

@end

@implementation LYXMainViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
//    self.homeViewController = [[LYXHomeViewController alloc] initWithViewModel:self.viewModel.homeViewModel];
//    UIImage *newsImage = [UIImage octicon_imageWithIdentifier:@"Rss" size:CGSizeMake(25, 25)];
//    self.homeViewController.rdv_tabBarItem = [[UITabBarItem alloc] initWithTitle:@"News" image:newsImage tag:1];
    
//    self.meViewController = [[LYXMeViewController alloc] initWithViewModel:self.viewModel.meViewModel];
//    UIImage *profileImage = [UIImage octicon_imageWithIdentifier:@"Person" size:CGSizeMake(25, 25)];
//    self.meViewController.rdv_tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Profile" image:profileImage tag:4];
    
    LYXMeViewController *homeViewController = (LYXMeViewController *)[LYXStoryBoardUtilities viewControllerForStoryboardName:@"Me" class:[LYXMeViewController class]];
    UINavigationController *homeNavController = [[LYXNavigationController alloc] initWithRootViewController:homeViewController];
    homeNavController.title = @"首页";
    
    LYXMeViewController *categoryViewController = (LYXMeViewController *)[LYXStoryBoardUtilities viewControllerForStoryboardName:@"Me" class:[LYXMeViewController class]];
    UINavigationController *categoryNavController = [[LYXNavigationController alloc] initWithRootViewController:categoryViewController];
    categoryNavController.title = @"分类";
    
    LYXMeViewController *discoveryViewController = (LYXMeViewController *)[LYXStoryBoardUtilities viewControllerForStoryboardName:@"Me" class:[LYXMeViewController class]];
    UINavigationController *discoveryNavController = [[LYXNavigationController alloc] initWithRootViewController:discoveryViewController];
    discoveryNavController.title = @"发现";
    
    LYXMeViewController *cartViewController = (LYXMeViewController *)[LYXStoryBoardUtilities viewControllerForStoryboardName:@"Me" class:[LYXMeViewController class]];
    UINavigationController *cartNavController = [[LYXNavigationController alloc] initWithRootViewController:cartViewController];
    cartNavController.title = @"购物车";
    
    LYXMeViewController *meViewController = (LYXMeViewController *)[LYXStoryBoardUtilities viewControllerForStoryboardName:@"Me" class:[LYXMeViewController class]];
    UINavigationController *meNavController = [[LYXNavigationController alloc] initWithRootViewController:meViewController];
    meNavController.title = @"我的";
    
//    self.viewControllers = @[ self.homeViewController, self.meViewController ];
    self.viewControllers = @[homeNavController, categoryNavController, discoveryNavController, cartNavController, meNavController];
    
//    [[[self
//       rac_signalForSelector:@selector(tabBarController:didSelectViewController:)
//       fromProtocol:@protocol(RDVTabBarControllerDelegate)]
//      startWith:RACTuplePack(self, self.homeViewController)]
//     subscribeNext:^(RACTuple *tuple) {
//         RACTupleUnpack(RDVTabBarController *tabBarController, UIViewController *viewController) = tuple;
//         
//         tabBarController.navigationItem.title = [((MRCViewController *)viewController).viewModel title];
//         
//         if (viewController.tabBarItem.tag == 1) {
//             tabBarController.navigationItem.titleView = nil;
//         } else if (viewController.tabBarItem.tag == 2) {
//             tabBarController.navigationItem.titleView = ((MRCReposViewController *)viewController).segmentedControl;
//         } else if (viewController.tabBarItem.tag == 3) {
//             tabBarController.navigationItem.titleView = ((MRCSearchViewController *)viewController).searchController.searchBar;
//         } else if (viewController.tabBarItem.tag == 4) {
//             tabBarController.navigationItem.titleView = nil;
//         }
//         
//         if (tabBarController.selectedIndex == 0) {
//             NSLog(@"0");
//         }else if (tabBarController.selectedIndex == 1) {
//             NSLog(@"1");
//         }
//     }];
    self.delegate = self;
    [self customizeTabBar];
}

- (void)customizeTabBar {
    UIImage *finishedImage = [UIImage imageNamed:@"tabbar_selected_bg.png"];
    UIImage *unfinishedImage = [UIImage imageNamed:@"tabbar_normal_bg.png"];
    
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[self tabBar] items]) {
        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
        
        UIImage *selectedimage;
        UIImage *unselectedimage;
        
        if (index == 0) {
            selectedimage = [UIImage imageNamed:@"tab_home_white.png"];
            unselectedimage = [UIImage imageNamed:@"tab_home_gray.png"];
        }else if (index == 1) {
            selectedimage = [UIImage imageNamed:@"tab_category_white.png"];
            unselectedimage = [UIImage imageNamed:@"tab_category_gray.png"];
        }else if (index == 2) {
            selectedimage = [UIImage imageNamed:@"tab_o2o_white.png"];
            unselectedimage = [UIImage imageNamed:@"tab_o2o_gray.png"];
        }else if (index == 3) {
            selectedimage = [UIImage imageNamed:@"tab_cart_white.png"];
            unselectedimage = [UIImage imageNamed:@"tab_cart_gray.png"];
        }else if (index == 4) {
            selectedimage = [UIImage imageNamed:@"tab_me_white.png"];
            unselectedimage = [UIImage imageNamed:@"tab_me_gray.png"];
        }
        
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        
        NSDictionary *selectedTitleAttributes = @{
                                                  NSFontAttributeName: [UIFont systemFontOfSize:11],
                                                  NSForegroundColorAttributeName: [UIColor whiteColor]
                                                  };
        item.selectedTitleAttributes = selectedTitleAttributes;
        
        NSDictionary *unselectedTitleAttributes = @{
                                                    NSFontAttributeName: [UIFont systemFontOfSize:11],
                                                    NSForegroundColorAttributeName: [UIColor grayColor]
                                                    };
        item.unselectedTitleAttributes = unselectedTitleAttributes;
        
        item.titlePositionAdjustment = UIOffsetMake(0.0f, 2.0f);
        
        index++;
    }
}

@end