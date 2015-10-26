//
//  UIImage+LYXOcticons.m
//  LYXBaseApp
//
//  Created by Yunxin.Li on 15/10/23.
//  Copyright © 2015年 LYX. All rights reserved.
//

#import "UIImage+LYXOcticons.h"
#import "UIImage+Octicons.h"

@implementation UIImage (LYXOcticons)

+ (UIImage *)octicon_imageWithIdentifier:(NSString *)identifier size:(CGSize)size {
    return [UIImage octicon_imageWithIcon:identifier
                          backgroundColor:[UIColor clearColor]
                                iconColor:[UIColor darkGrayColor]
                                iconScale:1
                                  andSize:size];
}

@end

