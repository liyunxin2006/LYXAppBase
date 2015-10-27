//
//  LYXHomeViewModel.m
//  LYXBaseApp
//
//  Created by Yunxin.Li on 15/10/15.
//  Copyright © 2015年 LYX. All rights reserved.
//

#import "LYXHomeViewModel.h"
#import "LYXNewsItemViewModel.h"
//#import "LYXUserDetailViewModel.h"
//#import "LYXRepoDetailViewModel.h"
//#import "LYXWebViewModel.h"

@interface LYXHomeViewModel ()

@property (nonatomic, strong) OCTUser *user;

@property (nonatomic, copy, readwrite) NSArray *events;
@property (nonatomic, assign, readwrite) BOOL isCurrentUser;
@property (nonatomic, assign, readwrite) LYXNewsViewModelType type;
@property (nonatomic, strong, readwrite) RACCommand *didClickLinkCommand;

@end

@implementation LYXHomeViewModel

- (instancetype)initWithServices:(id<LYXViewModelServices>)services params:(id)params {
    self = [super initWithServices:services params:params];
    if (self) {
        self.type = [params[@"type"] unsignedIntegerValue];
        self.user = params[@"user"] ?: [OCTUser lyx_currentUser];
    }
    return self;
}

- (void)initialize {
    [super initialize];
    
    self.isCurrentUser = [self.user.objectID isEqualToString:[OCTUser lyx_currentUserId]];
    
    if (self.type == LYXNewsViewModelTypeNews) {
        self.title = @"News";
    } else if (self.type == LYXNewsViewModelTypePublicActivity) {
        self.title = @"Public Activity";
    }
    
    self.shouldPullToRefresh = YES;
    self.shouldInfiniteScrolling = YES;
    
    @weakify(self)
//    self.didClickLinkCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSURL *URL) {
//        @strongify(self)
//        
//        NSString *title = [[[[URL.absoluteString componentsSeparatedByString:@"?"].lastObject componentsSeparatedByString:@"="].lastObject stringByReplacingOccurrencesOfString:@"-" withString:@" "] stringByReplacingOccurrencesOfString:@"@" withString:@"#"];
//        NSLog(@"didClickLinkCommand: %@, title: %@", URL, title);
//        
//        if (URL.type == LYXLinkTypeUser) {
//            LYXUserDetailViewModel *viewModel = [[LYXUserDetailViewModel alloc] initWithServices:self.services params:URL.lyx_dictionary];
//            [self.services pushViewModel:viewModel animated:YES];
//        } else if (URL.type == LYXLinkTypeRepository) {
//            LYXRepoDetailViewModel *viewModel = [[LYXRepoDetailViewModel alloc] initWithServices:self.services params:URL.lyx_dictionary];
//            [self.services pushViewModel:viewModel animated:YES];
//        } else {
//            NSURLRequest *request = [NSURLRequest requestWithURL:URL];
//            
//            LYXWebViewModel *viewModel = [[LYXWebViewModel alloc] initWithServices:self.services
//                                                                            params:@{ @"title": title ?: @"",
//                                                                                      @"request": request ?: @"" }];
//            [self.services pushViewModel:viewModel animated:YES];
//        }
//        
//        return [RACSignal empty];
//    }];
    
    self.didSelectCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSIndexPath *indexPath) {
        @strongify(self)
        LYXNewsItemViewModel *viewModel = self.dataSource[indexPath.section][indexPath.row];
        return [self.didClickLinkCommand execute:viewModel.event.lyx_Link];
    }];
    
    RAC(self, events) = [self.requestRemoteDataCommand.executionSignals.switchToLatest startWith:self.fetchLocalData];
}

- (BOOL (^)(NSError *))requestRemoteDataErrorsFilter {
    return ^BOOL(NSError *error) {
        if ([error.domain isEqual:OCTClientErrorDomain] && error.code == OCTClientErrorServiceRequestFailed) {
            LYXLogError(error);
            return NO;
        }
        return YES;
    };
}

- (id)fetchLocalData {
    NSArray *events = nil;
    
    if (self.isCurrentUser) {
        if (self.type == LYXNewsViewModelTypeNews) {
            events = [OCTEvent lyx_fetchUserReceivedEvents];
        } else if (self.type == LYXNewsViewModelTypePublicActivity) {
            events = [OCTEvent lyx_fetchUserPerformedEvents];
        }
    }
    
    return events;
}

- (RACSignal *)requestRemoteDataSignalWithPage:(NSUInteger)page {
    RACSignal *fetchSignal = [RACSignal empty];
    
    if (self.type == LYXNewsViewModelTypeNews) {
        fetchSignal = [[self.services client] fetchUserReceivedEventsWithOffset:[self offsetForPage:page] perPage:self.perPage];
    } else if (self.type == LYXNewsViewModelTypePublicActivity) {
        fetchSignal = [[self.services client] fetchPerformedEventsForUser:self.user offset:[self offsetForPage:page] perPage:self.perPage];
    }
    
    return [[[[fetchSignal
               take:self.perPage]
              collect]
             doNext:^(NSArray *events) {
                 if (self.isCurrentUser && page == 1) { // Cache the first page
                     dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                         if (self.type == LYXNewsViewModelTypeNews) {
                             [OCTEvent lyx_saveUserReceivedEvents:events];
                         } else if (self.type == LYXNewsViewModelTypePublicActivity) {
                             [OCTEvent lyx_saveUserPerformedEvents:events];
                         }
                     });
                 }
             }]
            map:^(NSArray *events) {
                if (page != 1) {
                    events = @[ (self.events ?: @[]).rac_sequence, events.rac_sequence ].rac_sequence.flatten.array;
                }
                return events;
            }];
}

- (NSArray *)dataSourceWithEvents:(NSArray *)events {
    if (events.count == 0) return nil;
    
    @weakify(self)
    NSArray *viewModels = [events.rac_sequence map:^(OCTEvent *event) {
        @strongify(self)
        LYXNewsItemViewModel *viewModel = [[LYXNewsItemViewModel alloc] initWithEvent:event];
        viewModel.didClickLinkCommand = self.didClickLinkCommand;
        return viewModel;
    }].array;
    
    return @[ viewModels ];
}

@end
