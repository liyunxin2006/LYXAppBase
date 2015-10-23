//
//  UIImage+LYXOcticons.h
//  LYXBaseApp
//
//  Created by Yunxin.Li on 15/10/23.
//  Copyright © 2015年 LYX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (LYXOcticons)

// Generating icon image using the GitHub's icons font.
//
// identifier - The identifier of GitHub's icons font
// size       - The size of icon image
//
// Returns the icon image.
+ (UIImage *)octicon_imageWithIdentifier:(NSString *)identifier size:(CGSize)size;

@end
