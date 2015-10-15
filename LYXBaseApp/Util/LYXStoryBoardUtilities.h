//
//  LYXStoryBoardUtilities.h
//  LYXBaseApp
//
//  Created by Yunxin.Li on 15/10/15.
//  Copyright © 2015年 LYX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYXStoryBoardUtilities : NSObject

+ (UIViewController*)viewControllerForStoryboardName:(NSString*)storyboardName class:(id)class;

@end