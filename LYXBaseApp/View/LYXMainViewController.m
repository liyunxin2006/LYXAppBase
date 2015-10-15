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
    
    UIViewController *controller1 = [[UIViewController alloc] init];
    UIViewController *controller2 = [[UIViewController alloc] init];
    controller2.view.backgroundColor = [UIColor lightGrayColor];
    UINavigationController *navigationController1 = [[LYXNavigationController alloc] initWithRootViewController:controller1];
    UINavigationController *navigationController2 = [[LYXNavigationController alloc] initWithRootViewController:controller2];
    navigationController1.title = @"首页";
    navigationController2.title = @"我的";
    
//    self.viewControllers = @[ self.homeViewController, self.meViewController ];
    self.viewControllers = @[ navigationController1, navigationController2];
    
//    [[[self
//       rac_signalForSelector:@selector(tabBarController:didSelectViewController:)
//       fromProtocol:@protocol(RDVTabBarControllerDelegate)]
//      startWith:RACTuplePack(self, self.homeViewController)]
//     subscribeNext:^(RACTuple *tuple) {
//         RACTupleUnpack(UITabBarController *tabBarController, UIViewController *viewController) = tuple;
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
//     }];
    self.delegate = self;
}

//- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController {
//    UIImage *finishedImage = [UIImage imageNamed:@"tabbar_selected_bg.png"];
//    UIImage *unfinishedImage = [UIImage imageNamed:@"tabbar_normal_bg.png"];
//    
//    NSInteger index = 0;
//    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
//        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
//        
//        UIImage *selectedimage;
//        UIImage *unselectedimage;
//        
//        if (index == 0) {
//            selectedimage = [UIImage imageNamed:@"tab_home_white.png"];
//            unselectedimage = [UIImage imageNamed:@"tab_home_gray.png"];
//        }else if (index == 1) {
//            selectedimage = [UIImage imageNamed:@"tab_category_white.png"];
//            unselectedimage = [UIImage imageNamed:@"tab_category_gray.png"];
//        }else if (index == 2) {
//            selectedimage = [UIImage imageNamed:@"tab_o2o_white.png"];
//            unselectedimage = [UIImage imageNamed:@"tab_o2o_gray.png"];
//        }else if (index == 3) {
//            selectedimage = [UIImage imageNamed:@"tab_cart_white.png"];
//            unselectedimage = [UIImage imageNamed:@"tab_cart_gray.png"];
//        }else if (index == 4) {
//            selectedimage = [UIImage imageNamed:@"tab_me_white.png"];
//            unselectedimage = [UIImage imageNamed:@"tab_me_gray.png"];
//        }
//        
//        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
//        
//        NSDictionary *selectedTitleAttributes = @{
//                                                  NSFontAttributeName: [UIFont systemFontOfSize:11],
//                                                  NSForegroundColorAttributeName: [UIColor whiteColor]
//                                                  };
//        item.selectedTitleAttributes = selectedTitleAttributes;
//        
//        NSDictionary *unselectedTitleAttributes = @{
//                                                    NSFontAttributeName: [UIFont systemFontOfSize:11],
//                                                    NSForegroundColorAttributeName: [UIColor grayColor]
//                                                    };
//        item.unselectedTitleAttributes = unselectedTitleAttributes;
//        
//        item.titlePositionAdjustment = UIOffsetMake(0.0f, 2.0f);
//        
//        index++;
//    }
//}

@end