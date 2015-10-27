//
//  LYXTableViewController.m
//  LYXBaseApp
//
//  Created by Yunxin.Li on 15/10/15.
//  Copyright © 2015年 LYX. All rights reserved.
//

#import "LYXTableViewController.h"
#import "LYXTableViewModel.h"
#import "LYXTableViewCellStyleValue1.h"

@interface LYXTableViewController ()

@property (nonatomic, weak, readwrite) IBOutlet UITableView *tableView;

@property (nonatomic, strong, readonly) LYXTableViewModel *viewModel;
@property (nonatomic, strong) CBStoreHouseRefreshControl *refreshControl;

@end

@implementation LYXTableViewController

@dynamic viewModel;

- (instancetype)initWithViewModel:(id<LYXViewModelProtocol>)viewModel {
    self = [super initWithViewModel:viewModel];
    if (self) {
        if ([viewModel shouldRequestRemoteDataOnViewDidLoad]) {
            @weakify(self)
            [[self rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(id x) {
                @strongify(self)
                [self.viewModel.requestRemoteDataCommand execute:@1];
            }];
        }
    }
    return self;
}

- (void)setView:(UIView *)view {
    [super setView:view];
    if ([view isKindOfClass:UITableView.class]) self.tableView = (UITableView *)view;
}

- (UIEdgeInsets)contentInset {
    return UIEdgeInsetsMake(64, 0, 0, 0);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.contentOffset = CGPointMake(0, -self.contentInset.top);
    self.tableView.contentInset  = self.contentInset;
    self.tableView.scrollIndicatorInsets = self.contentInset;
    
    self.tableView.sectionIndexColor = [UIColor darkGrayColor];
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    self.tableView.sectionIndexMinimumDisplayRowCount = 20;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.tableView registerClass:[LYXTableViewCellStyleValue1 class] forCellReuseIdentifier:@"LYXTableViewCellStyleValue1"];
    
    @weakify(self)
    if (self.viewModel.shouldPullToRefresh) {
        self.refreshControl = [CBStoreHouseRefreshControl attachToScrollView:self.tableView
                                                                      target:self
                                                               refreshAction:@selector(refreshTriggered:)
                                                                       plist:@"storehouse"
                                                                       color:UIColor.blackColor
                                                                   lineWidth:1.5
                                                                  dropHeight:80
                                                                       scale:1
                                                        horizontalRandomness:150
                                                     reverseLoadingAnimation:YES
                                                     internalAnimationFactor:0.5];
    }
    
    if (self.viewModel.shouldInfiniteScrolling) {
        [self.tableView addInfiniteScrollingWithActionHandler:^{
            @strongify(self)
            [[[self.viewModel.requestRemoteDataCommand execute:@(self.viewModel.page + 1)] deliverOn:RACScheduler.mainThreadScheduler] subscribeNext:^(NSArray *results) {
                @strongify(self)
                self.viewModel.page += 1;
            } error:^(NSError *error) {
                @strongify(self)
                [self.tableView.infiniteScrollingView stopAnimating];
            } completed:^{
                @strongify(self)
                [self.tableView.infiniteScrollingView stopAnimating];
            }];
        }];
        
        RAC(self.tableView, showsInfiniteScrolling) = [[RACObserve(self.viewModel, dataSource)
                                                        deliverOn:RACScheduler.mainThreadScheduler]
                                                       map:^(NSArray *dataSource) {
                                                           @strongify(self)
                                                           NSUInteger count = 0;
                                                           for (NSArray *array in dataSource) {
                                                               count += array.count;
                                                           }
                                                           return @(count >= self.viewModel.perPage);
                                                       }];
    }
    
    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (void)dealloc {
    _tableView.dataSource = nil;
    _tableView.delegate = nil;
}

- (void)bindViewModel {
    [super bindViewModel];
    
    @weakify(self)
    [[RACObserve(self.viewModel, dataSource).distinctUntilChanged deliverOn:RACScheduler.mainThreadScheduler] subscribeNext:^(id x) {
        @strongify(self)
        [self.tableView reloadData];
    }];
    
    [self.viewModel.requestRemoteDataCommand.executing subscribeNext:^(NSNumber *executing) {
        @strongify(self)
        UIView *emptyDataSetView = [self.tableView.subviews.rac_sequence objectPassingTest:^(UIView *view) {
            return [NSStringFromClass(view.class) isEqualToString:@"DZNEmptyDataSetView"];
        }];
        emptyDataSetView.alpha = 1.0 - executing.floatValue;
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object {}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.dataSource ? self.viewModel.dataSource.count : 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel.dataSource[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self tableView:tableView dequeueReusableCellWithIdentifier:@"LYXTableViewCellStyleValue1" forIndexPath:indexPath];
    
    id object = self.viewModel.dataSource[indexPath.section][indexPath.row];
    [self configureCell:cell atIndexPath:indexPath withObject:(id)object];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section >= self.viewModel.sectionIndexTitles.count) return nil;
    return self.viewModel.sectionIndexTitles[section];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.viewModel.sectionIndexTitles;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.viewModel.didSelectCommand execute:indexPath];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.refreshControl scrollViewDidScroll];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self.refreshControl scrollViewDidEndDragging];
}

#pragma mark - Listening for the user to trigger a refresh

- (void)refreshTriggered:(id)sender {
    @weakify(self)
    [[[self.viewModel.requestRemoteDataCommand
       execute:@1]
     	deliverOn:RACScheduler.mainThreadScheduler]
    	subscribeNext:^(id x) {
            @strongify(self)
            self.viewModel.page = 1;
        } error:^(NSError *error) {
            @strongify(self)
            [self.refreshControl finishingLoading];
        } completed:^{
            @strongify(self)
            [self.refreshControl finishingLoading];
        }];
}

#pragma mark - DZNEmptyDataSetSource

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    return [[NSAttributedString alloc] initWithString:@"No Data"];
}

#pragma mark - DZNEmptyDataSetDelegate

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return self.viewModel.dataSource == nil;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}

- (CGPoint)offsetForEmptyDataSet:(UIScrollView *)scrollView {
    return CGPointMake(0, -(self.tableView.contentInset.top - self.tableView.contentInset.bottom) / 2);
}

@end