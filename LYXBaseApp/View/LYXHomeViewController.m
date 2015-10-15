//
//  LYXHomeViewController.m
//  LYXBaseApp
//
//  Created by Yunxin.Li on 15/10/15.
//  Copyright © 2015年 LYX. All rights reserved.
//

#import "LYXHomeViewController.h"
#import "LYXHomeViewModel.h"
//#import "MRCNewsTableViewCell.h"
//#import "MRCNewsItemViewModel.h"
//#import "MRCNetworkHeaderView.h"

@interface LYXHomeViewController ()

@property (nonatomic, strong, readonly) LYXHomeViewModel *viewModel;

@end

@implementation LYXHomeViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.tableView registerNib:[UINib nibWithNibName:@"MRCNewsTableViewCell" bundle:nil] forCellReuseIdentifier:@"MRCNewsTableViewCell"];
    
//    if (self.viewModel.type == MRCNewsViewModelTypeNews) {
//        UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
//        
//        MRCNetworkHeaderView *networkHeaderView = [NSBundle.mainBundle loadNibNamed:@"MRCNetworkHeaderView" owner:nil options:nil].firstObject;
//        networkHeaderView.frame = tableHeaderView.bounds;
//        [tableHeaderView addSubview:networkHeaderView];
//        
//        RAC(self.tableView, tableHeaderView) = [RACObserve(MRCSharedAppDelegate, networkStatus) map:^(NSNumber *networkStatus) {
//            return networkStatus.integerValue == NotReachable ? tableHeaderView : nil;
//        }];
//    }
    
    @weakify(self)
    [self.viewModel.requestRemoteDataCommand.executing subscribeNext:^(NSNumber *executing) {
        @strongify(self)
        if (executing.boolValue && self.viewModel.dataSource == nil) {
            [MBProgressHUD showHUDAddedTo:self.view animated:YES].labelText = MBPROGRESSHUD_LABEL_TEXT;
        } else {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
    }];
    
//    RAC(self.viewModel, dataSource) = [[RACObserve(self.viewModel, events)
//                                        map:^(NSArray *events) {
//                                            @strongify(self)
//                                            return [self.viewModel dataSourceWithEvents:events];
//                                        }]
//                                       map:^(NSArray *viewModels) {
//                                           for (MRCNewsItemViewModel *viewModel in viewModels.firstObject) {
//                                               viewModel.height = [MRCNewsTableViewCell heightWithViewModel:viewModel];
//                                           }
//                                           return viewModels;
//                                       }];
}

//- (UIEdgeInsets)contentInset {
//    return self.viewModel.type == MRCNewsViewModelTypeNews ? UIEdgeInsetsMake(64, 0, 49, 0) : UIEdgeInsetsZero;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
//    return [tableView dequeueReusableCellWithIdentifier:@"MRCNewsTableViewCell" forIndexPath:indexPath];
    return [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
}

//- (void)configureCell:(MRCNewsTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(MRCNewsItemViewModel *)viewModel {
//    [cell bindViewModel:viewModel];
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return [self.viewModel.dataSource[indexPath.section][indexPath.row] height];
    return 40.f;
}

@end