//
//  LYXRepositoryServiceImpl.m
//  LYXBaseApp
//
//  Created by Yunxin.Li on 15/10/19.
//  Copyright © 2015年 LYX. All rights reserved.
//

#import "LYXRepositoryServiceImpl.h"

@implementation LYXRepositoryServiceImpl

//- (RACSignal *)requestRepositoryReadmeHTML:(OCTRepository *)repository reference:(NSString *)reference {
//    return [[[RACSignal
//              createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//                  NSString *accessToken   = [SSKeychain accessToken];
//                  NSString *authorization = [NSString stringWithFormat:@"token %@", accessToken];
//                  
//                  MKNetworkEngine *networkEngine = [[MKNetworkEngine alloc] initWithHostName:@"api.github.com"
//                                                                          customHeaderFields:@{ @"Authorization": authorization}];
//                  
//                  NSString *path = [NSString stringWithFormat:@"repos/%@/%@/readme", repository.ownerLogin, repository.name];
//                  MKNetworkOperation *operation = [networkEngine operationWithPath:path
//                                                                            params:@{ @"ref": reference }
//                                                                        httpMethod:@"GET"
//                                                                               ssl:YES];
//                  [operation addHeaders:@{ @"Accept": @"application/vnd.github.VERSION.html" }];
//                  [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
//                      dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                          [subscriber sendNext:completedOperation.responseString];
//                          [subscriber sendCompleted];
//                      });
//                  } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
//                      dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                          [subscriber sendError:error];
//                      });
//                  }];
//                  
//                  [networkEngine enqueueOperation:operation];
//                  
//                  return [RACDisposable disposableWithBlock:^{
//                      [operation cancel];
//                  }];
//              }]
//             replayLazily]
//            setNameWithFormat:@"-requestRepositoryReadmeHTML: %@ reference: %@", repository, reference];
//}

@end