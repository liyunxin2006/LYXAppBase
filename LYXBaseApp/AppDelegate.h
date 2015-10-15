//
//  AppDelegate.h
//  LYXBaseApp
//
//  Created by Yunxin.Li on 15/9/23.
//  Copyright © 2015年 LYX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"

@class LYXNavigationControllerStack;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

// The window of current application.
@property (nonatomic, strong) UIWindow *window;

@property (nonatomic, strong, readonly) LYXNavigationControllerStack *navigationControllerStack;
@property (nonatomic, assign, readonly) NetworkStatus networkStatus;

//@property (nonatomic, copy, readonly) NSString *adURL;

@end