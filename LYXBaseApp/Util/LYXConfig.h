//
//  LYXConfig.h
//  LYXBaseApp
//
//  Created by Yunxin.Li on 15/10/14.
//  Copyright © 2015年 LYX. All rights reserved.
//

#ifndef LYXConfig_h
#define LYXConfig_h

///------------
/// AppDelegate
///------------

#define LYXSharedAppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

///------------
/// Client Info
///------------

#define MRC_CLIENT_ID     @"ef5834ea86b53233dc41"
#define MRC_CLIENT_SECRET @"6eea860464609635567d001b1744a052f8568a99"

///-----------
/// SSKeychain
///-----------

#define MRC_SERVICE_NAME @"com.leichunfeng.MVVMReactiveCocoa"
#define MRC_RAW_LOGIN    @"RawLogin"
#define MRC_PASSWORD     @"Password"
#define MRC_ACCESS_TOKEN @"AccessToken"

///-----------
/// URL Scheme
///-----------

#define MRC_URL_SCHEME @"mvvmreactivecocoa"

///----------------------
/// Persistence Directory
///----------------------

#define MRC_DOCUMENT_DIRECTORY NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject

#endif
