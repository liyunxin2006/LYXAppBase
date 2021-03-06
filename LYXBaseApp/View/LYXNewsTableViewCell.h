//
//  LYXNewsTableViewCell.h
//  LYXBaseApp
//
//  Created by Yunxin.Li on 15/10/26.
//  Copyright © 2015年 LYX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYXNewsItemViewModel.h"

@interface LYXNewsTableViewCell : UITableViewCell <LYXReactiveView>

+ (CGFloat)heightWithViewModel:(LYXNewsItemViewModel *)viewModel;

@end
