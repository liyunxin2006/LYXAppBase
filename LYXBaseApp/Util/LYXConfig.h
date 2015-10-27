//
//  LYXConfig.h
//  LYXBaseApp
//
//  Created by Yunxin.Li on 15/10/14.
//  Copyright © 2015年 LYX. All rights reserved.
//

#ifndef LYXBaseApp_LYXConfig_h
#define LYXBaseApp_LYXConfig_h

///------------
/// AppDelegate
///------------

#define LYXSharedAppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

///------------
/// Client Info
///------------

#define LYX_CLIENT_ID     @"ef5834ea86b53233dc41"
#define LYX_CLIENT_SECRET @"6eea860464609635567d001b1744a052f8568a99"

///-----------
/// SSKeychain
///-----------

#define LYX_SERVICE_NAME @"com.leichunfeng.MVVMReactiveCocoa"
#define LYX_RAW_LOGIN    @"RawLogin"
#define LYX_PASSWORD     @"Password"
#define LYX_ACCESS_TOKEN @"AccessToken"

///-----------
/// URL Scheme
///-----------

#define LYX_URL_SCHEME @"mvvmreactivecocoa"

///----------------------
/// Persistence Directory
///----------------------

#define LYX_DOCUMENT_DIRECTORY NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject

#endif
