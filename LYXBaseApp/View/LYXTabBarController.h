//
//  LYXTabBarController.h
//  LYXBaseApp
//
//  Created by Yunxin.Li on 15/10/15.
//  Copyright © 2015年 LYX. All rights reserved.
//

#import "LYXViewProtocol.h"
#import "LYXViewController.h"

@interface LYXTabBarController : LYXViewController <UITabBarControllerDelegate>

@property (nonatomic, strong, readonly) UITabBarController *tabBarController;

@end