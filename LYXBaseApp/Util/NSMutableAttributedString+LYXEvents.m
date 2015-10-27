//
//  NSMutableAttributedString+LYXEvents.m
//  LYXBaseApp
//
//  Created by Yunxin.Li on 15/10/26.
//  Copyright © 2015年 LYX. All rights reserved.
//

#import "NSMutableAttributedString+LYXEvents.h"

@implementation NSString (LYXEvents)

- (NSMutableAttributedString *)lyx_attributedString {
    return [[NSMutableAttributedString alloc] initWithString:self];
}

@end

@implementation NSMutableAttributedString (LYXEvents)

#pragma mark - Font

- (NSMutableAttributedString *)lyx_addNormalTitleFontAttribute {
    [self addAttribute:NSFontAttributeName value:LYXEventsNormalTitleFont range:[self.string rangeOfString:self.string]];
    return self;
}

- (NSMutableAttributedString *)lyx_addBoldTitleFontAttribute {
    [self addAttribute:NSFontAttributeName value:LYXEventsBoldTitleFont range:[self.string rangeOfString:self.string]];
    return self;
}

- (NSMutableAttributedString *)lyx_addOcticonFontAttribute {
    [self addAttribute:NSFontAttributeName value:LYXEventsOcticonFont range:[self.string rangeOfString:self.string]];
    return self;
}

- (NSMutableAttributedString *)lyx_addTimeFontAttribute {
    [self addAttribute:NSFontAttributeName value:LYXEventsTimeFont range:[self.string rangeOfString:self.string]];
    return self;
}

- (NSMutableAttributedString *)lyx_addNormalPullInfoFontAttribute {
    [self addAttribute:NSFontAttributeName value:LYXEventsNormalPullInfoFont range:[self.string rangeOfString:self.string]];
    return self;
}

- (NSMutableAttributedString *)lyx_addBoldPullInfoFontAttribute {
    [self addAttribute:NSFontAttributeName value:LYXEventsBoldPullInfoFont range:[self.string rangeOfString:self.string]];
    return self;
}

#pragma mark - Foreground Color

- (NSMutableAttributedString *)lyx_addTintedForegroundColorAttribute {
    [self addAttribute:NSForegroundColorAttributeName value:LYXEventsTintedForegroundColor range:[self.string rangeOfString:self.string]];
    return self;
}

- (NSMutableAttributedString *)lyx_addNormalTitleForegroundColorAttribute {
    [self addAttribute:NSForegroundColorAttributeName value:LYXEventsNormalTitleForegroundColor range:[self.string rangeOfString:self.string]];
    return self;
}

- (NSMutableAttributedString *)lyx_addBoldTitleForegroundColorAttribute {
    [self addAttribute:NSForegroundColorAttributeName value:LYXEventsBoldTitleForegroundColor range:[self.string rangeOfString:self.string]];
    return self;
}

- (NSMutableAttributedString *)lyx_addTimeForegroundColorAttribute {
    [self addAttribute:NSForegroundColorAttributeName value:LYXEventsTimeForegroundColor range:[self.string rangeOfString:self.string]];
    return self;
}

- (NSMutableAttributedString *)lyx_addPullInfoForegroundColorAttribute {
    [self addAttribute:NSForegroundColorAttributeName value:LYXEventsPullInfoForegroundColor range:[self.string rangeOfString:self.string]];
    return self;
}

#pragma mark - Background Color

- (NSMutableAttributedString *)lyx_addBackgroundColorAttribute {
    [self addAttribute:NSBackgroundColorAttributeName value:HexRGB(0xe8f1f6) range:[self.string rangeOfString:self.string]];
    return self;
}

#pragma mark - Paragraph Style

- (NSMutableAttributedString *)lyx_addParagraphStyleAttribute {
    [self addAttribute:NSParagraphStyleAttributeName value:LYXEventsParagraphStyle range:NSMakeRange(0, 1)];
    return self;
}

#pragma mark - Link

- (NSMutableAttributedString *)lyx_addUserLinkAttribute {
    [self addAttribute:NSLinkAttributeName value:[NSURL lyx_userLinkWithLogin:self.string] range:[self.string rangeOfString:self.string]];
    return self;
}

- (NSMutableAttributedString *)lyx_addRepositoryLinkAttributeWithName:(NSString *)name referenceName:(NSString *)referenceName {
    [self addAttribute:NSLinkAttributeName value:[NSURL lyx_repositoryLinkWithName:name referenceName:referenceName] range:[self.string rangeOfString:self.string]];
    return self;
}

- (NSMutableAttributedString *)lyx_addHTMLURLAttribute:(NSURL *)HTMLURL {
    [self addAttribute:NSLinkAttributeName value:HTMLURL range:[self.string rangeOfString:self.string]];
    return self;
}

#pragma mark - Combination

- (NSMutableAttributedString *)lyx_addOcticonAttributes {
    return [[self lyx_addOcticonFontAttribute] lyx_addTimeForegroundColorAttribute];
}

- (NSMutableAttributedString *)lyx_addNormalTitleAttributes {
    return [[self lyx_addNormalTitleFontAttribute] lyx_addNormalTitleForegroundColorAttribute];
}

- (NSMutableAttributedString *)lyx_addBoldTitleAttributes {
    return [[self lyx_addBoldTitleFontAttribute] lyx_addBoldTitleForegroundColorAttribute];
}

@end
