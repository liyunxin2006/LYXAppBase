//
//  NSMutableAttributedString+LYXEvents.h
//  LYXBaseApp
//
//  Created by Yunxin.Li on 15/10/26.
//  Copyright © 2015年 LYX. All rights reserved.
//

#import <Foundation/Foundation.h>

// Font

#define LYXEventsNormalTitleFont    [UIFont systemFontOfSize:15]
#define LYXEventsBoldTitleFont      [UIFont boldSystemFontOfSize:16]
#define LYXEventsOcticonFont        [UIFont fontWithName:kOcticonsFamilyName size:16]
#define LYXEventsTimeFont           [UIFont systemFontOfSize:13]
#define LYXEventsNormalPullInfoFont [UIFont systemFontOfSize:12]
#define LYXEventsBoldPullInfoFont   [UIFont boldSystemFontOfSize:12]

// Foreground Color

#define LYXEventsTintedForegroundColor      HexRGB(0x4078c0)
#define LYXEventsNormalTitleForegroundColor HexRGB(0x666666)
#define LYXEventsBoldTitleForegroundColor   HexRGB(0x333333)
#define LYXEventsTimeForegroundColor        HexRGB(0xbbbbbb)
#define LYXEventsPullInfoForegroundColor    RGBAlpha(0, 0, 0, 0.5)

// Paragraph Style

#define LYXEventsParagraphStyle ({ \
NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init]; \
paragraphStyle.paragraphSpacing = 5; \
paragraphStyle; \
})

@interface NSString (LYXEvents)

- (NSMutableAttributedString *)lyx_attributedString;

@end

@interface NSMutableAttributedString (LYXEvents)

// Font

- (NSMutableAttributedString *)lyx_addNormalTitleFontAttribute;
- (NSMutableAttributedString *)lyx_addBoldTitleFontAttribute;
- (NSMutableAttributedString *)lyx_addOcticonFontAttribute;
- (NSMutableAttributedString *)lyx_addTimeFontAttribute;
- (NSMutableAttributedString *)lyx_addNormalPullInfoFontAttribute;
- (NSMutableAttributedString *)lyx_addBoldPullInfoFontAttribute;

// Foreground Color

- (NSMutableAttributedString *)lyx_addTintedForegroundColorAttribute;
- (NSMutableAttributedString *)lyx_addNormalTitleForegroundColorAttribute;
- (NSMutableAttributedString *)lyx_addBoldTitleForegroundColorAttribute;
- (NSMutableAttributedString *)lyx_addTimeForegroundColorAttribute;
- (NSMutableAttributedString *)lyx_addPullInfoForegroundColorAttribute;

// Background Color

- (NSMutableAttributedString *)lyx_addBackgroundColorAttribute;

// Paragraph Style

- (NSMutableAttributedString *)lyx_addParagraphStyleAttribute;

// Link

- (NSMutableAttributedString *)lyx_addUserLinkAttribute;
- (NSMutableAttributedString *)lyx_addRepositoryLinkAttributeWithName:(NSString *)name referenceName:(NSString *)referenceName;
- (NSMutableAttributedString *)lyx_addHTMLURLAttribute:(NSURL *)HTMLURL;

// Combination

- (NSMutableAttributedString *)lyx_addOcticonAttributes;
- (NSMutableAttributedString *)lyx_addNormalTitleAttributes;
- (NSMutableAttributedString *)lyx_addBoldTitleAttributes;

@end