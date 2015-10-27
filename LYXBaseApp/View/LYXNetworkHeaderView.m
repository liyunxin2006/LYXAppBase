//
//  LYXNetworkHeaderView.m
//  LYXBaseApp
//
//  Created by Yunxin.Li on 15/10/26.
//  Copyright © 2015年 LYX. All rights reserved.
//

#import "LYXNetworkHeaderView.h"

@interface LYXNetworkHeaderView ()

@property (nonatomic, weak) IBOutlet UIImageView *imageView;

@end

@implementation LYXNetworkHeaderView

- (void)awakeFromNib {
    self.backgroundColor = HexRGB(0xFED6D7);
    self.imageView.image = [UIImage octicon_imageWithIcon:@"IssueOpened"
                                          backgroundColor:UIColor.clearColor
                                                iconColor:HexRGB(0xF1494D)
                                                iconScale:1
                                                  andSize:CGSizeMake(29, 29)];
}

@end
