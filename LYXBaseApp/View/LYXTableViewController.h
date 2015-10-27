//
//  LYXTableViewController.h
//  LYXBaseApp
//
//  Created by Yunxin.Li on 15/10/15.
//  Copyright © 2015年 LYX. All rights reserved.
//

#import "LYXViewController.h"

@interface LYXTableViewController : LYXViewController <UITableViewDataSource, UITableViewDelegate, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

// The table view for tableView controller.
@property (nonatomic, weak, readonly) UITableView *tableView;
@property (nonatomic, assign, readonly) UIEdgeInsets contentInset;

- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath;
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object;

@end