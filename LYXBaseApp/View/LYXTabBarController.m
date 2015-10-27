//
//  LYXTabBarController.m
//  LYXBaseApp
//
//  Created by Yunxin.Li on 15/10/15.
//  Copyright © 2015年 LYX. All rights reserved.
//

#import "LYXTabBarController.h"

@interface LYXTabBarController ()

@property (nonatomic, strong, readwrite) UITabBarController *tabBarController;

@end

@implementation LYXTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.view.frame = self.view.bounds;
    
    [self addChildViewController:self.tabBarController];
    [self.view addSubview:self.tabBarController.view];
}

- (BOOL)shouldAutorotate {
    return self.tabBarController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.tabBarController.supportedInterfaceOrientations;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.tabBarController.preferredStatusBarStyle;
}

#pragma mark - UITabBarControllerDelegate

- (UIInterfaceOrientationMask)tabBarControllerSupportedInterfaceOrientations:(UITabBarController *)tabBarController {
    return tabBarController.selectedViewController.supportedInterfaceOrientations;
}

@end

@interface UITabBarController (LYXStatusBarAddtions)

@end

@implementation UITabBarController (LYXStatusBarAddtions)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(preferredStatusBarStyle);
        SEL swizzledSelector = @selector(lyx_preferredStatusBarStyle);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (success) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

#pragma mark - Method Swizzling

- (UIStatusBarStyle)lyx_preferredStatusBarStyle {
    return self.selectedViewController.preferredStatusBarStyle;
}

@end
