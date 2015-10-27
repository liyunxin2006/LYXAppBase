//
//  OCTRef+LYXAdditions.h
//  LYXBaseApp
//
//  Created by Yunxin.Li on 15/10/26.
//  Copyright © 2015年 LYX. All rights reserved.
//

#import "OctoKit.h"

@interface OCTRef (LYXAdditions)

NSString *LYXDefaultReferenceName();
NSString *LYXReferenceNameWithBranchName(NSString *branchName);
NSString *LYXReferenceNameWithTagName(NSString *tagName);

@end
