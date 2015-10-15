//
//  LYXTableViewModel.m
//  LYXBaseApp
//
//  Created by Yunxin.Li on 15/10/15.
//  Copyright © 2015年 LYX. All rights reserved.
//

#import "LYXTableViewModel.h"

@interface LYXTableViewModel ()

@property (nonatomic, strong, readwrite) RACCommand *requestRemoteDataCommand;

@end

@implementation LYXTableViewModel

- (void)initialize {
    [super initialize];
    
    self.page = 1;
    self.perPage = 30;
    
    @weakify(self)
    self.requestRemoteDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSNumber *page) {
        @strongify(self)
        return [[self requestRemoteDataSignalWithPage:page.unsignedIntegerValue] takeUntil:self.rac_willDeallocSignal];
    }];
    
    RAC(self, shouldDisplayEmptyDataSet) = [RACSignal
                                            combineLatest:@[ self.requestRemoteDataCommand.executing, RACObserve(self, dataSource) ]
                                            reduce:^(NSNumber *executing, NSArray *dataSource) {
                                                RACSequence *sequenceOfSequences = [dataSource.rac_sequence map:^(NSArray *array) {
                                                    @strongify(self)
                                                    NSParameterAssert([array isKindOfClass:[NSArray class]]);
                                                    return array.rac_sequence;
                                                }];
                                                return @(!executing.boolValue && sequenceOfSequences.flatten.array.count == 0);
                                            }];
    
    [[self.requestRemoteDataCommand.errors
      filter:[self requestRemoteDataErrorsFilter]]
     subscribe:self.errors];
}

- (BOOL (^)(NSError *error))requestRemoteDataErrorsFilter {
    return ^(NSError *error) {
        return YES;
    };
}

- (id)fetchLocalData {
    return nil;
}

- (NSUInteger)offsetForPage:(NSUInteger)page {
    return (page - 1) * self.perPage;
}

- (RACSignal *)requestRemoteDataSignalWithPage:(NSUInteger)page {
    return [RACSignal empty];
}

@end