//
//  AppDelegate.m
//  LYXBaseApp
//
//  Created by Yunxin.Li on 15/9/23.
//  Copyright © 2015年 LYX. All rights reserved.
//

#import "AppDelegate.h"
#import "LYXViewModelServicesImpl.h"
#import "LYXLoginViewModel.h"
#import "LYXLoginViewController.h"
#import "LYXMainViewModel.h"
#import "LYXMainViewController.h"
#import "LYXNavigationControllerStack.h"
#import "LYXNavigationController.h"

@interface AppDelegate ()

@property (nonatomic, strong) LYXViewModelServicesImpl *services;
@property (nonatomic, strong) id<LYXViewModelProtocol> viewModel;
@property (nonatomic, strong) Reachability *reachability;

@property (nonatomic, strong, readwrite) LYXNavigationControllerStack *navigationControllerStack;
@property (nonatomic, assign, readwrite) NetworkStatus networkStatus;
//@property (nonatomic, copy, readwrite) NSString *adURL;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self initializeFMDB];
    
    AFNetworkActivityIndicatorManager.sharedManager.enabled = YES;
    //[[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    self.services = [[LYXViewModelServicesImpl alloc] init];
    self.navigationControllerStack = [[LYXNavigationControllerStack alloc] initWithServices:self.services];
    
    UINavigationController *navigationController = [[LYXNavigationController alloc] initWithRootViewController:self.createInitialViewController];
    [self.navigationControllerStack pushNavigationController:navigationController];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    
    [self configureAppearance];
    [self configureKeyboardManager];
    [self configureReachability];
    [self configureUMengSocial];
    
    // Save the application version info.
    [[NSUserDefaults standardUserDefaults] setValue:LYX_APP_VERSION forKey:LYXApplicationVersionKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {}

- (void)applicationDidEnterBackground:(UIApplication *)application {}

- (void)applicationWillEnterForeground:(UIApplication *)application {}

- (void)applicationDidBecomeActive:(UIApplication *)application {}

- (void)applicationWillTerminate:(UIApplication *)application {}

- (UIViewController *)createInitialViewController {
    // The user has logged-in.
    if ([SSKeychain rawLogin].isExist && [SSKeychain accessToken].isExist) {
        // Some OctoKit APIs will use the `login` property of `OCTUser`.
        OCTUser *user = [OCTUser lyx_userWithRawLogin:[SSKeychain rawLogin] server:OCTServer.dotComServer];
        
        OCTClient *authenticatedClient = [OCTClient authenticatedClientWithUser:user token:[SSKeychain accessToken]];
        self.services.client = authenticatedClient;
        self.viewModel = [[LYXMainViewModel alloc] initWithServices:self.services params:nil];
        
        return [[LYXMainViewController alloc] initWithViewModel:self.viewModel];
    } else {
        self.viewModel = [[LYXLoginViewModel alloc] initWithServices:self.services params:nil];
        return [[LYXLoginViewController alloc] initWithViewModel:self.viewModel];
    }
}

- (void)configureAppearance {
    self.window.backgroundColor = UIColor.whiteColor;
    
    // 0x2F434F
    [UINavigationBar appearance].barTintColor = [UIColor colorWithRed:(48 - 40) / 215.0 green:(67 - 40) / 215.0 blue:(78 - 40) / 215.0 alpha:1];
    [UINavigationBar appearance].barStyle  = UIBarStyleBlack;
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    
    [UISegmentedControl appearance].tintColor = [UIColor whiteColor];
    
    [UITabBar appearance].tintColor = HexRGB(colorI2);
}

- (void)configureKeyboardManager {
    IQKeyboardManager.sharedManager.enableAutoToolbar = NO;
    IQKeyboardManager.sharedManager.shouldResignOnTouchOutside = YES;
}

- (void)configureReachability {
    self.reachability = Reachability.reachabilityForInternetConnection;
    
    RAC(self, networkStatus) = [[[[NSNotificationCenter.defaultCenter
                                   rac_addObserverForName:kReachabilityChangedNotification object:nil]
                                  map:^id(NSNotification *notification) {
                                      return @([notification.object currentReachabilityStatus]);
                                  }]
                                 startWith:@(self.reachability.currentReachabilityStatus)]
                                distinctUntilChanged];
    
    @weakify(self)
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @strongify(self)
        [self.reachability startNotifier];
    });
}

- (void)configureUMengSocial {
//    [UMSocialData setAppKey:MRC_UM_APP_KEY];
//    
//    [UMSocialConfig hiddenNotInstallPlatforms:@[ UMShareToWechatSession, UMShareToWechatTimeline, UMShareToQQ/*, UMShareToQzone */]];
//    
//    [UMSocialWechatHandler setWXAppId:MRC_WX_APP_ID appSecret:MRC_WX_APP_SECRET url:MRC_UM_SHARE_URL];
//    [UMSocialSinaHandler openSSOWithRedirectURL:MRC_WEIBO_REDIRECT_URL];
//    [UMSocialQQHandler setQQWithAppId:MRC_QQ_APP_ID appKey:MRC_QQ_APP_KEY url:MRC_UM_SHARE_URL];
}

- (void)initializeFMDB {
    [[FMDatabaseQueue sharedInstance] inDatabase:^(FMDatabase *db) {
        NSString *version = [[NSUserDefaults standardUserDefaults] valueForKey:LYXApplicationVersionKey];
        if (![version isEqualToString:LYX_APP_VERSION]) {
            if (version == nil) {
                [SSKeychain deleteAccessToken];
                
                NSString *path = [[NSBundle mainBundle] pathForResource:@"update_v1_0_0" ofType:@"sql"];
                NSString *sql  = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
                
                if (![db executeStatements:sql]) {
                    LYXLogLastError(db);
                }
            }
        }
    }];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
//    if ([url.scheme isEqual:MRC_URL_SCHEME]) {
//        [OCTClient completeSignInWithCallbackURL:url];
//        return YES;
//    }
//    return [UMSocialSnsService handleOpenURL:url];
    return YES;
}

@end
