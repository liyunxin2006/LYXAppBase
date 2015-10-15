//
//  LYXViewProtocol.h
//  LYXBaseApp
//
//  Created by Yunxin.Li on 15/10/15.
//  Copyright © 2015年 LYX. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LYXViewModelProtocol;

@protocol LYXViewProtocol <NSObject>

@required

// Initialization method. This is the preferred way to create a new view.
//
// viewModel - corresponding view model
//
// Returns a new view.
- (instancetype)initWithViewModel:(id<LYXViewModelProtocol>)viewModel;

// The `viewModel` parameter in `-initWithViewModel:` method.
@property (nonatomic, strong, readonly) id<LYXViewModelProtocol> viewModel;

@optional

// Binds the corresponding view model to the view.
- (void)bindViewModel;

@end
