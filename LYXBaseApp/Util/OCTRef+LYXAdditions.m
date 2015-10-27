//
//  OCTRef+LYXAdditions.m
//  LYXBaseApp
//
//  Created by Yunxin.Li on 15/10/26.
//  Copyright © 2015年 LYX. All rights reserved.
//

#import "OCTRef+LYXAdditions.h"

#define LYXRefBranchReferenceNamePrefix @"refs/heads/"
#define LYXRefTagReferenceNamePrefix    @"refs/tags/"

@implementation OCTRef (LYXAdditions)

NSString *LYXDefaultReferenceName() {
    return [LYXRefBranchReferenceNamePrefix stringByAppendingString:@"master"];
}

NSString *LYXReferenceNameWithBranchName(NSString *branchName) {
    NSCParameterAssert(branchName.length > 0);
    return [NSString stringWithFormat:@"%@%@", LYXRefBranchReferenceNamePrefix, branchName];
}

NSString *LYXReferenceNameWithTagName(NSString *tagName) {
    NSCParameterAssert(tagName.length > 0);
    return [NSString stringWithFormat:@"%@%@", LYXRefTagReferenceNamePrefix, tagName];
}

@end
