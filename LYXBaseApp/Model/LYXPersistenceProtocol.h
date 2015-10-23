//
//  LYXPersistenceProtocol.h
//  LYXBaseApp
//
//  Created by Yunxin.Li on 15/10/23.
//  Copyright © 2015年 LYX. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LYXPersistenceProtocol <NSObject>

@required

- (BOOL)lyx_saveOrUpdate;
- (BOOL)lyx_delete;

@end
