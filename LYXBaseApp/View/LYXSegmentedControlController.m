//
//  LYXSegmentedControlController.m
//  LYXBaseApp
//
//  Created by Yunxin.Li on 15/10/15.
//  Copyright © 2015年 LYX. All rights reserved.
//

#import "LYXSegmentedControlController.h"

@interface LYXSegmentedControlController ()

@property (nonatomic, strong, readwrite) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) UIViewController *currentViewController;

@end

@implementation LYXSegmentedControlController

- (void)initialize {
    for (UIViewController *viewController in self.viewControllers) {
        viewController.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self addChildViewController:viewController];
    }
    
    self.currentViewController = self.viewControllers.firstObject;
    [self.view addSubview:self.currentViewController.view];
    
    NSArray *items = [self.viewControllers.rac_sequence map:^id(UIViewController *viewController) {
        return viewController.segmentedControlItem;
    }].array;
    
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:items];
    self.segmentedControl.selectedSegmentIndex = 0;
    
    @weakify(self)
    [[self.segmentedControl
      rac_newSelectedSegmentIndexChannelWithNilValue:@0]
    	subscribeNext:^(NSNumber *selectedSegmentIndex) {
            @strongify(self)
            UIViewController *toViewController = self.viewControllers[selectedSegmentIndex.integerValue];
            [self transitionFromViewController:self.currentViewController
                              toViewController:toViewController
                                      duration:0
                                       options:0
                                    animations:NULL
                                    completion:^(BOOL finished) {
                                        @strongify(self)
                                        self.currentViewController = toViewController;
                                        if ([self.delegate respondsToSelector:@selector(segmentedControlController:didSelectViewController:)]) {
                                            [self.delegate segmentedControlController:self didSelectViewController:self.currentViewController];
                                        }
                                    }];
        }];
}

- (void)setViewControllers:(NSArray *)viewControllers {
    _viewControllers = viewControllers;
    [self initialize];
}

@end

static void *LYXSegmentedControlItemKey = &LYXSegmentedControlItemKey;

@implementation UIViewController (LYXSegmentedControlItem)

- (NSString *)segmentedControlItem {
    return objc_getAssociatedObject(self, LYXSegmentedControlItemKey);
}

- (void)setSegmentedControlItem:(NSString *)segmentedControlItem {
    objc_setAssociatedObject(self, LYXSegmentedControlItemKey, segmentedControlItem, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end