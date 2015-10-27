//
//  LYXWebViewController.h
//  LYXBaseApp
//
//  Created by Yunxin.Li on 15/10/27.
//  Copyright © 2015年 LYX. All rights reserved.
//

#import "LYXViewController.h"

@interface LYXWebViewController : LYXViewController <UIWebViewDelegate>

@property (nonatomic, weak, readonly) UIWebView *webView;

@end
