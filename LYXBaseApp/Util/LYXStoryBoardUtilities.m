//
//  LYXStoryBoardUtilities.m
//  LYXBaseApp
//
//  Created by Yunxin.Li on 15/10/15.
//  Copyright © 2015年 LYX. All rights reserved.
//

#import "LYXStoryBoardUtilities.h"

@implementation LYXStoryBoardUtilities

+ (UIViewController*)viewControllerForStoryboardName:(NSString*)storyboardName class:(id)class
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    NSString* className = nil;
    
    if ([class isKindOfClass:[NSString class]])
        className = [NSString stringWithFormat:@"%@", class];
    else
        className = [NSString stringWithFormat:@"%s", class_getName([class class])];
    
    UIViewController* viewController = [storyboard instantiateViewControllerWithIdentifier:[NSString stringWithFormat:@"%@", className]];
    return viewController;
}

@end