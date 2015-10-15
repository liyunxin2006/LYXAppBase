//
//  LYXMeViewController.m
//  LYXBaseApp
//
//  Created by Yunxin.Li on 15/10/15.
//  Copyright © 2015年 LYX. All rights reserved.
//

#import "LYXMeViewController.h"
#import "LYXMeViewModel.h"

@interface LYXMeViewController ()

@property (nonatomic, weak) IBOutlet UITextView *textView;
@property (nonatomic, strong, readonly) LYXMeViewModel *viewModel;

@end

@implementation LYXMeViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)bindViewModel {
    [super bindViewModel];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

@end
