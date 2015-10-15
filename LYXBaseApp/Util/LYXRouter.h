//
//  LYXRouter.h
//  LYXBaseApp
//
//  Created by Yunxin.Li on 15/10/15.
//  Copyright © 2015年 LYX. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LYXViewProtocol;

@interface LYXRouter : NSObject

// Retrieves the shared router instance.
//
// Returns the shared router instance.
+ (instancetype)sharedInstance;

// Retrieves the view corresponding to the given view model.
//
// viewModel - The view model
//
// Returns the view corresponding to the given view model.
- (id<LYXViewProtocol>)viewControllerForViewModel:(id<LYXViewModelProtocol>)viewModel;

@end