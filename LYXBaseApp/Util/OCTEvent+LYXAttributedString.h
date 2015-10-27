//
//  OCTEvent+LYXAttributedString.h
//  LYXBaseApp
//
//  Created by Yunxin.Li on 15/10/26.
//  Copyright © 2015年 LYX. All rights reserved.
//

#import "OctoKit.h"

typedef NS_OPTIONS(NSUInteger, LYXEventOptions) {
    LYXEventOptionsBoldTitle = 1 << 0
};

@interface OCTEvent (LYXAttributedString)

@property (nonatomic, assign, readonly) LYXEventOptions options;

- (NSMutableAttributedString *)lyx_attributedString;

- (NSMutableAttributedString *)lyx_commitCommentEventAttributedString;
- (NSMutableAttributedString *)lyx_forkEventAttributedString;
- (NSMutableAttributedString *)lyx_issueCommentEventAttributedString;
- (NSMutableAttributedString *)lyx_issueEventAttributedString;
- (NSMutableAttributedString *)lyx_memberEventAttributedString;
- (NSMutableAttributedString *)lyx_publicEventAttributedString;
- (NSMutableAttributedString *)lyx_pullRequestCommentEventAttributedString;
- (NSMutableAttributedString *)lyx_pullRequestEventAttributedString;
- (NSMutableAttributedString *)lyx_pushEventAttributedString;
- (NSMutableAttributedString *)lyx_refEventAttributedString;
- (NSMutableAttributedString *)lyx_watchEventAttributedString;

- (NSMutableAttributedString *)lyx_octiconAttributedString;
- (NSMutableAttributedString *)lyx_actorLoginAttributedString;
- (NSMutableAttributedString *)lyx_commentedCommitAttributedString;
- (NSMutableAttributedString *)lyx_forkedRepositoryNameAttributedString;
- (NSMutableAttributedString *)lyx_repositoryNameAttributedString;
- (NSMutableAttributedString *)lyx_issueAttributedString;
- (NSMutableAttributedString *)lyx_memberLoginAttributedString;
- (NSMutableAttributedString *)lyx_pullRequestAttributedString;
- (NSMutableAttributedString *)lyx_branchNameAttributedString;
- (NSMutableAttributedString *)lyx_pushedCommitAttributedStringWithSHA:(NSString *)SHA;
- (NSMutableAttributedString *)lyx_pushedCommitsAttributedString;
- (NSMutableAttributedString *)lyx_refNameAttributedString;
- (NSMutableAttributedString *)lyx_dateAttributedString;
- (NSMutableAttributedString *)lyx_pullInfoAttributedString;

@end
