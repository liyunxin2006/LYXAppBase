//
//  LYXLoginViewModel.m
//  LYXBaseApp
//
//  Created by Yunxin.Li on 15/10/23.
//  Copyright © 2015年 LYX. All rights reserved.
//

#import "LYXLoginViewModel.h"
#import "LYXMainViewModel.h"

@interface LYXLoginViewModel ()

@property (nonatomic, copy, readwrite) NSURL *avatarURL;

@property (nonatomic, strong, readwrite) RACSignal *validLoginSignal;
@property (nonatomic, strong, readwrite) RACCommand *loginCommand;
@property (nonatomic, strong, readwrite) RACCommand *browserLoginCommand;

@end

@implementation LYXLoginViewModel

- (void)initialize {
    [super initialize];
    
    RAC(self, avatarURL) = [[RACObserve(self, username)
                             map:^id(NSString *username) {
                                 return [[OCTUser lyx_fetchUserWithRawLogin:username] avatarURL];
                             }]
                            distinctUntilChanged];
    
    self.validLoginSignal = [[RACSignal
                              combineLatest:@[RACObserve(self, username), RACObserve(self, password)] reduce:^id(NSString *username, NSString *password) {
                                  return @(username.length > 0 && password.length > 0);
                              }]
                             distinctUntilChanged];
    
    @weakify(self)
    void (^doNext)(OCTClient *) = ^(OCTClient *authenticatedClient) {
        @strongify(self)
        [[LYXMemoryCache sharedInstance] setObject:authenticatedClient.user forKey:@"currentUser"];
        
        self.services.client = authenticatedClient;
        
        [authenticatedClient.user lyx_saveOrUpdate];
        [authenticatedClient.user lyx_updateRawLogin]; // The only place to update rawLogin, I hate the logic of rawLogin.
        
        SSKeychain.rawLogin = authenticatedClient.user.rawLogin;
        SSKeychain.password = self.password;
        SSKeychain.accessToken = authenticatedClient.token;
        
        LYXMainViewModel *viewModel = [[LYXMainViewModel alloc] initWithServices:self.services params:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.services resetRootViewModel:viewModel];
        });
    };
    
    [OCTClient setClientID:LYX_CLIENT_ID clientSecret:LYX_CLIENT_SECRET];
    
    self.loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSString *oneTimePassword) {
        @strongify(self)
        OCTUser *user = [OCTUser userWithRawLogin:self.username server:OCTServer.dotComServer];
        return [[OCTClient
                 signInAsUser:user password:self.password oneTimePassword:oneTimePassword scopes:OCTClientAuthorizationScopesUser | OCTClientAuthorizationScopesRepository note:nil noteURL:nil fingerprint:nil]
                doNext:doNext];
    }];
    
    self.browserLoginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [[OCTClient
                 signInToServerUsingWebBrowser:OCTServer.dotComServer scopes:OCTClientAuthorizationScopesUser | OCTClientAuthorizationScopesRepository]
                doNext:doNext];
    }];    
}

@end