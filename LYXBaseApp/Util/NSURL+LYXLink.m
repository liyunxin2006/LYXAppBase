//
//  NSURL+LYXLink.m
//  LYXBaseApp
//
//  Created by Yunxin.Li on 15/10/26.
//  Copyright © 2015年 LYX. All rights reserved.
//

#import "NSURL+LYXLink.h"

#define LYXLinkUserScheme @"user"
#define LYXLinkRepositoryScheme @"repository"

@implementation NSURL (LYXLink)

- (LYXLinkType)type {
    if ([self.scheme isEqualToString:LYXLinkUserScheme]) {
        return LYXLinkTypeUser;
    } else if ([self.scheme isEqualToString:LYXLinkRepositoryScheme]) {
        return LYXLinkTypeRepository;
    }
    return LYXLinkTypeUnknown;
}

+ (instancetype)lyx_userLinkWithLogin:(NSString *)login {
    NSParameterAssert(login.length > 0);
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@://%@", LYXLinkUserScheme, login]];;
}

+ (instancetype)lyx_repositoryLinkWithName:(NSString *)name referenceName:(NSString *)referenceName {
    NSParameterAssert(name.length > 0);
    
    referenceName = referenceName ?: LYXDefaultReferenceName(); // FIXME
    
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@://%@?referenceName=%@", LYXLinkRepositoryScheme, name, referenceName]];
}

- (NSDictionary *)lyx_dictionary {
    if (self.type == LYXLinkTypeUser) {
        return @{
                 @"user": @{
                         @"login": self.host ?: @""
                         }
                 };
    } else if (self.type == LYXLinkTypeRepository) {
        return @{
                 @"repository": @{
                         @"ownerLogin": self.host ?: @"",
                         @"name": [self.path substringFromIndex:1] ?: @"",
                         },
                 @"referenceName": [self.query componentsSeparatedByString:@"="].lastObject ?: @""
                 };
    }
    return nil;
}

@end

@implementation OCTEvent (LYXLink)

- (NSURL *)lyx_Link {
    NSMutableAttributedString *attributedString = nil;
    
    if ([self isMemberOfClass:[OCTCommitCommentEvent class]]) {
        attributedString = self.lyx_commentedCommitAttributedString;
    } else if ([self isMemberOfClass:[OCTForkEvent class]]) {
        attributedString = self.lyx_forkedRepositoryNameAttributedString;
    } else if ([self isMemberOfClass:[OCTIssueCommentEvent class]]) {
        attributedString = self.lyx_issueAttributedString;
    } else if ([self isMemberOfClass:[OCTIssueEvent class]]) {
        attributedString = self.lyx_issueAttributedString;
    } else if ([self isMemberOfClass:[OCTMemberEvent class]]) {
        attributedString = self.lyx_memberLoginAttributedString;
    } else if ([self isMemberOfClass:[OCTPublicEvent class]]) {
        attributedString = self.lyx_repositoryNameAttributedString;
    } else if ([self isMemberOfClass:[OCTPullRequestCommentEvent class]]) {
        attributedString = self.lyx_pullRequestAttributedString;
    } else if ([self isMemberOfClass:[OCTPullRequestEvent class]]) {
        attributedString = self.lyx_pullRequestAttributedString;
    } else if ([self isMemberOfClass:[OCTPushEvent class]]) {
        attributedString = self.lyx_branchNameAttributedString;
    } else if ([self isMemberOfClass:[OCTRefEvent class]]) {
        if ([self.lyx_refNameAttributedString attribute:NSLinkAttributeName atIndex:0 effectiveRange:NULL]) {
            attributedString = self.lyx_refNameAttributedString;
        } else {
            attributedString = self.lyx_repositoryNameAttributedString;
        }
    } else if ([self isMemberOfClass:[OCTWatchEvent class]]) {
        attributedString = self.lyx_repositoryNameAttributedString;
    }
    
    return [attributedString attribute:NSLinkAttributeName atIndex:0 effectiveRange:NULL];
}

@end
