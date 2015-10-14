//
//  LYXNavigationProtocol.h
//  LYXBaseApp
//
//  Created by Yunxin.Li on 15/10/14.
//  Copyright © 2015年 LYX. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LYXViewModelProtocol;

@protocol LYXNavigationProtocol <NSObject>

// Pushes the corresponding view controller.
//
// Uses a horizontal slide transition.
// Has no effect if the corresponding view controller is already in the stack.
//
// viewModel - the view model
// animated  - use animation or not
- (void)pushViewModel:(id<LYXViewModelProtocol>)viewModel animated:(BOOL)animated;

// Pops the top view controller in the stack.
//
// animated - use animation or not
- (void)popViewModelAnimated:(BOOL)animated;

// Pops until there's only a single view controller left on the stack.
//
// animated - use animation or not
- (void)popToRootViewModelAnimated:(BOOL)animated;

// Present the corresponding view controller.
//
// viewModel  - the view model
// animated   - use animation or not
// completion - the completion handler
- (void)presentViewModel:(id<LYXViewModelProtocol>)viewModel animated:(BOOL)animated completion:(VoidBlock)completion;

// Dismiss the presented view controller.
//
// animated   - use animation or not
// completion - the completion handler
- (void)dismissViewModelAnimated:(BOOL)animated completion:(VoidBlock)completion;

// Reset the corresponding view controller as the root view controller of the application's window.
//
// viewModel - the view model
- (void)resetRootViewModel:(id<LYXViewModelProtocol>)viewModel;

@end