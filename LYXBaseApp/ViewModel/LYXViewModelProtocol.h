//
//  LYXViewModelProtocol.h
//  LYXBaseApp
//
//  Created by Yunxin.Li on 15/10/14.
//  Copyright © 2015年 LYX. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, LYXTitleViewType) {
    LYXTitleViewTypeDefault,
    LYXTitleViewTypeDoubleTitle,
    LYXTitleViewTypeLoadingTitle
};

@protocol LYXViewModelServices;

// The Protocol for viewModel.
@protocol LYXViewModelProtocol <NSObject>

@required

// Initialization method. This is the preferred way to create a new viewModel.
//
// services - The service bus of Model layer.
// params   - The parameters to be passed to view model.
//
// Returns a new view model.
- (instancetype)initWithServices:(id<LYXViewModelServices>)services params:(id)params;

// The `services` parameter in `-initWithServices:params:` method.
@property (nonatomic, strong, readonly) id<LYXViewModelServices> services;

// The `params` parameter in `-initWithServices:params:` method.
@property (nonatomic, strong, readonly) id params;

@optional

@property (nonatomic, assign) LYXTitleViewType titleViewType;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

// The callback block.
@property (nonatomic, copy) VoidBlock_id callback;

// A RACSubject object, which representing all errors occurred in view model.
@property (nonatomic, strong, readonly) RACSubject *errors;

@property (nonatomic, assign) BOOL shouldFetchLocalDataOnViewModelInitialize;
@property (nonatomic, assign) BOOL shouldRequestRemoteDataOnViewDidLoad;

@property (nonatomic, strong, readonly) RACSubject *willDisappearSignal;

// An additional method, in which you can initialize data, RACCommand etc.
//
// This method will be execute after the execution of `-initWithServices:params:` method. But
// the premise is that you need to inherit `MRCViewModel`.
- (void)initialize;

@end
