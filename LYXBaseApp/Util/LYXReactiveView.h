//
//  LYXReactiveView.h
//  LYXBaseApp
//
//  Created by Yunxin.Li on 15/10/26.
//  Copyright © 2015年 LYX. All rights reserved.
//

#import <Foundation/Foundation.h>

// A protocol which is adopted by views which are backed by view models.
@protocol LYXReactiveView <NSObject>

// Binds the given view model to the view.
//
// viewModel - The view model
- (void)bindViewModel:(id)viewModel;

@end
