//
//  LYXHomeViewController.m
//  LYXBaseApp
//
//  Created by Yunxin.Li on 15/10/26.
//  Copyright © 2015年 LYX. All rights reserved.
//

#import "LYXHomeViewController.h"
#import "LYXHomeViewModel.h"
#import "LYXNewsTableViewCell.h"
#import "LYXNewsItemViewModel.h"
#import "LYXNetworkHeaderView.h"
//#import "LYXSearchViewModel.h"

@interface LYXHomeViewController ()

@property (nonatomic, strong, readonly) LYXHomeViewModel *viewModel;

@end

@implementation LYXHomeViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LYXNewsTableViewCell" bundle:nil] forCellReuseIdentifier:@"LYXNewsTableViewCell"];
    
    if (self.viewModel.type == LYXNewsViewModelTypeNews) {
        UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        
        LYXNetworkHeaderView *networkHeaderView = [NSBundle.mainBundle loadNibNamed:@"LYXNetworkHeaderView" owner:nil options:nil].firstObject;
        networkHeaderView.frame = tableHeaderView.bounds;
        [tableHeaderView addSubview:networkHeaderView];
        
        RAC(self.tableView, tableHeaderView) = [RACObserve(LYXSharedAppDelegate, networkStatus) map:^(NSNumber *networkStatus) {
            return networkStatus.integerValue == NotReachable ? tableHeaderView : nil;
        }];
    }
    
    @weakify(self)
    [self.viewModel.requestRemoteDataCommand.executing subscribeNext:^(NSNumber *executing) {
        @strongify(self)
        if (executing.boolValue && self.viewModel.dataSource == nil) {
            [MBProgressHUD showHUDAddedTo:self.view animated:YES].labelText = MBPROGRESSHUD_LABEL_TEXT;
        } else {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
    }];
    
    RAC(self.viewModel, dataSource) = [[RACObserve(self.viewModel, events)
                                        map:^(NSArray *events) {
                                            @strongify(self)
                                            return [self.viewModel dataSourceWithEvents:events];
                                        }]
                                       map:^(NSArray *viewModels) {
                                           for (LYXNewsItemViewModel *viewModel in viewModels.firstObject) {
                                               viewModel.height = [LYXNewsTableViewCell heightWithViewModel:viewModel];
                                           }
                                           return viewModels;
                                       }];
}

- (UIEdgeInsets)contentInset {
    return self.viewModel.type == LYXNewsViewModelTypeNews ? UIEdgeInsetsMake(64, 0, 49, 0) : [super contentInset];
}

- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:@"LYXNewsTableViewCell" forIndexPath:indexPath];
}

- (void)configureCell:(LYXNewsTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(LYXNewsItemViewModel *)viewModel {
    [cell bindViewModel:viewModel];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.viewModel.dataSource[indexPath.section][indexPath.row] height];
}

@end
