//
//  LYXNavigationControllerStack.h
//  LYXBaseApp
//
//  Created by Yunxin.Li on 15/10/15.
//  Copyright © 2015年 LYX. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LYXViewModelServices;

@interface LYXNavigationControllerStack : NSObject

// Initialization method. This is the preferred way to create a new navigation controller stack.
//
// services - The service bus of Model layer.
//
// Returns a new navigation controller stack.
- (instancetype)initWithServices:(id<LYXViewModelServices>)services;

// Pushes the navigation controller.
//
// navigationController - the navigation controller
- (void)pushNavigationController:(UINavigationController *)navigationController;

// Pops the top navigation controller in the stack.
//
// Returns the popped navigation controller.
- (UINavigationController *)popNavigationController;

// Retrieves the top navigation controller in the stack.
//
// Returns the top navigation controller in the stack.
- (UINavigationController *)topNavigationController;

@end