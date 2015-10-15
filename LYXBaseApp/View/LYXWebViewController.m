//
//  LYXWebViewController.m
//  LYXBaseApp
//
//  Created by Yunxin.Li on 15/10/15.
//  Copyright © 2015年 LYX. All rights reserved.
//

#import "LYXWebViewController.h"
#import "LYXWebViewModel.h"

@interface LYXWebViewController ()

@property (nonatomic, weak, readwrite) IBOutlet UIWebView *webView;

@property (nonatomic, strong, readonly) LYXWebViewModel *viewModel;
@property (nonatomic, assign) BOOL showProgressHUD;

@end

@implementation LYXWebViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    RACSignal *didFinishLoadSignal   = [self rac_signalForSelector:@selector(webViewDidFinishLoad:) fromProtocol:@protocol(UIWebViewDelegate)];
//    RACSignal *didFailLoadLoadSignal = [self rac_signalForSelector:@selector(webView:didFailLoadWithError:) fromProtocol:@protocol(UIWebViewDelegate)];
//    
//    MRCTitleViewType type = self.viewModel.titleViewType;
//    RAC(self.viewModel, titleViewType) = [[RACSignal merge:@[ didFinishLoadSignal, didFailLoadLoadSignal ]] mapReplace:@(type)];
    
    NSParameterAssert(self.viewModel.request);
    
    [self.webView loadRequest:self.viewModel.request];
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if (navigationType == UIWebViewNavigationTypeOther) {
        if ([request.URL.scheme isEqualToString:@"http"] || [request.URL.scheme isEqualToString:@"https"]) {
//            self.viewModel.titleViewType = MRCTitleViewTypeLoadingTitle;
        }
        return YES;
    } else {
        [UIApplication.sharedApplication openURL:request.URL];
        return NO;
    }
}

- (void)webViewDidStartLoad:(UIWebView *)webView {}

- (void)webViewDidFinishLoad:(UIWebView *)webView {}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {}

@end