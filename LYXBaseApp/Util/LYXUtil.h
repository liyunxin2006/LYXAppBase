//
//  LYXUtil.h
//  LYXBaseApp
//
//  Created by Yunxin.Li on 15/10/23.
//  Copyright © 2015年 LYX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYXUtil : NSObject

@end

@interface NSString (Util)

// Judging the string is not nil or empty.
//
// Returns YES or NO.
- (BOOL)isExist;

- (NSString *)firstLetter;

- (BOOL)isMarkdown;

@end

@interface UIColor (Util)

// Generating a new image by the color.
//
// Returns a new image.
- (UIImage *)color2Image;

- (UIImage *)color2ImageSized:(CGSize)size;

@end

@interface NSMutableArray (LYXSafeAdditions)

- (void)lyx_addObject:(id)object;

@end