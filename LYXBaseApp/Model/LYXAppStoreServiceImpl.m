//
//  LYXAppStoreServiceImpl.m
//  LYXBaseApp
//
//  Created by Yunxin.Li on 15/10/19.
//  Copyright © 2015年 LYX. All rights reserved.
//

#import "LYXAppStoreServiceImpl.h"

@implementation LYXAppStoreServiceImpl

//- (RACSignal *)requestAppInfoFromAppStoreWithAppID:(NSString *)appID {
//    return [[[RACSignal
//              createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//                  MKNetworkEngine *networkEngine = [[MKNetworkEngine alloc] initWithHostName:@"itunes.apple.com"];
//                  
//                  MKNetworkOperation *operation = [networkEngine operationWithPath:@"lookup"
//                                                                            params:@{ @"id": appID }
//                                                                        httpMethod:@"GET"];
//                  
//                  [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
//                      [subscriber sendNext:completedOperation.responseJSON];
//                      [subscriber sendCompleted];
//                  } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
//                      [subscriber sendError:error];
//                  }];
//                  
//                  [networkEngine enqueueOperation:operation];
//                  
//                  return [RACDisposable disposableWithBlock:^{
//                      [operation cancel];
//                  }];
//              }]
//             replayLazily]
//            setNameWithFormat:@"-requestAppInfoFromAppStoreWithAppID: %@", appID];
//}

@end