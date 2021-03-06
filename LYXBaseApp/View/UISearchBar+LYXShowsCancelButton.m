//
//  UISearchBar+LYXShowsCancelButton.m
//  LYXBaseApp
//
//  Created by Yunxin.Li on 15/10/27.
//  Copyright © 2015年 LYX. All rights reserved.
//

#import "UISearchBar+LYXShowsCancelButton.h"

@implementation UISearchBar (LYXShowsCancelButton)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL sel1 = NSSelectorFromString(@"setShowsCancelButton:");
        SEL sel2 = NSSelectorFromString(@"mrc_setShowsCancelButton:");
        
        Method m1 = class_getInstanceMethod(class, sel1);
        Method m2 = class_getInstanceMethod(class, sel2);
        
        IMP imp1 = class_getMethodImplementation(class, sel1);
        if (imp1 != NULL) {
            method_exchangeImplementations(m1, m2);
        }
        
        SEL sel3 = NSSelectorFromString(@"setShowsCancelButton:animated:");
        SEL sel4 = NSSelectorFromString(@"mrc_setShowsCancelButton:animated:");
        
        Method m3 = class_getInstanceMethod(class, sel3);
        Method m4 = class_getInstanceMethod(class, sel4);
        
        IMP imp3 = class_getMethodImplementation(class, sel3);
        if (imp3 != NULL) {
            method_exchangeImplementations(m3, m4);
        }
    });
}

- (void)mrc_setShowsCancelButton:(BOOL)showsCancelButton {}

- (void)mrc_setShowsCancelButton:(BOOL)showsCancelButton animated:(BOOL)animated {}

@end
