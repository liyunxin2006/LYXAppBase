//
//  LYXSegmentedControlController.h
//  LYXBaseApp
//
//  Created by Yunxin.Li on 15/10/15.
//  Copyright © 2015年 LYX. All rights reserved.
//

#import "LYXViewController.h"

@class LYXSegmentedControlController;

@protocol LYXSegmentedControlControllerDelegate <NSObject>

@optional

- (void)segmentedControlController:(LYXSegmentedControlController *)segmentedControlController didSelectViewController:(UIViewController *)viewController;

@end

@interface LYXSegmentedControlController : LYXViewController

@property (nonatomic, copy) NSArray *viewControllers;
@property (nonatomic, strong, readonly) UISegmentedControl *segmentedControl;
@property (nonatomic, assign) id<LYXSegmentedControlControllerDelegate> delegate;

@end

@interface UIViewController (LYXSegmentedControlItem)

@property (nonatomic, copy) NSString *segmentedControlItem;

@end