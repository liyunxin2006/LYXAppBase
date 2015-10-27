//
//  OCTEvent+LYXAttributedString.m
//  LYXBaseApp
//
//  Created by Yunxin.Li on 15/10/26.
//  Copyright © 2015年 LYX. All rights reserved.
//

#import "OCTEvent+LYXAttributedString.h"
#import "TTTTimeIntervalFormatter.h"

@implementation OCTEvent (LYXAttributedString)

- (LYXEventOptions)options {
    LYXEventOptions options = 0;
    
    if ([self isMemberOfClass:[OCTCommitCommentEvent class]] ||
        [self isMemberOfClass:[OCTIssueCommentEvent class]] ||
        [self isMemberOfClass:[OCTIssueEvent class]] ||
        [self isMemberOfClass:[OCTPullRequestCommentEvent class]] ||
        [self isMemberOfClass:[OCTPullRequestEvent class]] ||
        [self isMemberOfClass:[OCTPushEvent class]]) {
        options |= LYXEventOptionsBoldTitle;
    }
    
    return options;
}

- (NSMutableAttributedString *)lyx_attributedString {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
    
    [attributedString appendAttributedString:self.lyx_octiconAttributedString];
    [attributedString appendAttributedString:self.lyx_actorLoginAttributedString];
    
    if ([self isMemberOfClass:[OCTCommitCommentEvent class]] ||
        [self isMemberOfClass:[OCTIssueCommentEvent class]] ||
        [self isMemberOfClass:[OCTPullRequestCommentEvent class]]) {
        if ([self isMemberOfClass:[OCTCommitCommentEvent class]]) {
            [attributedString appendAttributedString:[self lyx_commitCommentEventAttributedString]];
        } else if ([self isMemberOfClass:[OCTIssueCommentEvent class]]) {
            [attributedString appendAttributedString:[self lyx_issueCommentEventAttributedString]];
        } else if ([self isMemberOfClass:[OCTPullRequestCommentEvent class]]) {
            [attributedString appendAttributedString:[self lyx_pullRequestCommentEventAttributedString]];
        }
        
        [attributedString appendAttributedString:[@"\n" stringByAppendingString:[self valueForKeyPath:@"comment.body"]].lyx_attributedString.lyx_addNormalTitleAttributes.lyx_addParagraphStyleAttribute];
    } else if ([self isMemberOfClass:[OCTForkEvent class]]) {
        [attributedString appendAttributedString:[self lyx_forkEventAttributedString]];
    } else if ([self isMemberOfClass:[OCTIssueEvent class]]) {
        [attributedString appendAttributedString:[self lyx_issueEventAttributedString]];
    } else if ([self isMemberOfClass:[OCTMemberEvent class]]) {
        [attributedString appendAttributedString:[self lyx_memberEventAttributedString]];
    } else if ([self isMemberOfClass:[OCTPublicEvent class]]) {
        [attributedString appendAttributedString:[self lyx_publicEventAttributedString]];
    } else if ([self isMemberOfClass:[OCTPullRequestEvent class]]) {
        [attributedString appendAttributedString:[self lyx_pullRequestEventAttributedString]];
    } else if ([self isMemberOfClass:[OCTPushEvent class]]) {
        [attributedString appendAttributedString:[self lyx_pushEventAttributedString]];
    } else if ([self isMemberOfClass:[OCTRefEvent class]]) {
        [attributedString appendAttributedString:[self lyx_refEventAttributedString]];
    } else if ([self isMemberOfClass:[OCTWatchEvent class]]) {
        [attributedString appendAttributedString:[self lyx_watchEventAttributedString]];
    }
    
    [attributedString appendAttributedString:self.lyx_dateAttributedString];
    
    return attributedString;
}

- (NSMutableAttributedString *)lyx_octiconAttributedString {
    OCTIcon icon = 0;
    if ([self isMemberOfClass:[OCTCommitCommentEvent class]] ||
        [self isMemberOfClass:[OCTIssueCommentEvent class]] ||
        [self isMemberOfClass:[OCTPullRequestCommentEvent class]]) {
        icon = OCTIconCommentDiscussion;
    } else if ([self isMemberOfClass:[OCTForkEvent class]]) {
        icon = OCTIconGitBranch;
    } else if ([self isMemberOfClass:[OCTIssueEvent class]]) {
        OCTIssueEvent *concreteEvent = (OCTIssueEvent *)self;
        
        if (concreteEvent.action == OCTIssueActionOpened) {
            icon = OCTIconIssueOpened;
        } else if (concreteEvent.action == OCTIssueActionClosed) {
            icon = OCTIconIssueClosed;
        } else if (concreteEvent.action == OCTIssueActionReopened) {
            icon = OCTIconIssueReopened;
        }
    } else if ([self isMemberOfClass:[OCTMemberEvent class]]) {
        icon = OCTIconOrganization;
    } else if ([self isMemberOfClass:[OCTPublicEvent class]]) {
        icon = OCTIconRepo;
    } else if ([self isMemberOfClass:[OCTPullRequestEvent class]]) {
        icon = OCTIconGitPullRequest;
    } else if ([self isMemberOfClass:[OCTPushEvent class]]) {
        icon = OCTIconGitCommit;
    } else if ([self isMemberOfClass:[OCTRefEvent class]]) {
        OCTRefEvent *concreteEvent = (OCTRefEvent *)self;
        
        if (concreteEvent.refType == OCTRefTypeBranch) {
            icon = OCTIconGitBranch;
        } else if (concreteEvent.refType == OCTRefTypeTag) {
            icon = OCTIconTag;
        } else if (concreteEvent.refType == OCTRefTypeRepository) {
            icon = OCTIconRepo;
        }
    } else if ([self isMemberOfClass:[OCTWatchEvent class]]) {
        icon = OCTIconStar;
    }
    
    return [[NSString octicon_iconStringForEnum:icon] stringByAppendingString:@"  "].lyx_attributedString.lyx_addOcticonAttributes;
}

- (NSMutableAttributedString *)lyx_actorLoginAttributedString {
    return [self lyx_loginAttributedStringWithString:self.actorLogin];
}

- (NSMutableAttributedString *)lyx_loginAttributedStringWithString:(NSString *)string {
    NSMutableAttributedString *attributedString = string.lyx_attributedString;
    
    if (self.options & LYXEventOptionsBoldTitle) {
        [attributedString lyx_addBoldTitleFontAttribute];
    } else {
        [attributedString lyx_addNormalTitleFontAttribute];
    }
    
    [attributedString lyx_addTintedForegroundColorAttribute];
    [attributedString lyx_addUserLinkAttribute];
    
    return attributedString;
}

- (NSMutableAttributedString *)lyx_commentedCommitAttributedString {
    NSParameterAssert([self isMemberOfClass:[OCTCommitCommentEvent class]]);
    
    OCTCommitCommentEvent *concreteEvent = (OCTCommitCommentEvent *)self;
    
    NSString *target = [NSString stringWithFormat:@"%@@%@", concreteEvent.repositoryName, LYXShortSHA(concreteEvent.comment.commitSHA)];
    NSMutableAttributedString *attributedString = target.lyx_attributedString;
    
    NSURL *HTMLURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@?title=Commit", concreteEvent.comment.HTMLURL.absoluteString]];
    
    [attributedString lyx_addBoldTitleFontAttribute];
    [attributedString lyx_addTintedForegroundColorAttribute];
    [attributedString lyx_addHTMLURLAttribute:HTMLURL];
    
    return attributedString;
}

- (NSMutableAttributedString *)lyx_forkedRepositoryNameAttributedString {
    NSParameterAssert([self isMemberOfClass:[OCTForkEvent class]]);
    
    OCTForkEvent *concreteEvent = (OCTForkEvent *)self;
    
    return [self lyx_repositoryNameAttributedStringWithString:concreteEvent.forkedRepositoryName];
}

- (NSMutableAttributedString *)lyx_repositoryNameAttributedString {
    return [self lyx_repositoryNameAttributedStringWithString:self.repositoryName];
}

- (NSMutableAttributedString *)lyx_repositoryNameAttributedStringWithString:(NSString *)string {
    NSMutableAttributedString *attributedString = string.lyx_attributedString;
    
    if (self.options & LYXEventOptionsBoldTitle) {
        attributedString = attributedString.lyx_addBoldTitleFontAttribute;
    } else {
        attributedString = attributedString.lyx_addNormalTitleAttributes;
    }
    
    return [attributedString.lyx_addTintedForegroundColorAttribute lyx_addRepositoryLinkAttributeWithName:attributedString.string referenceName:nil];
}

- (NSMutableAttributedString *)lyx_issueAttributedString {
    NSParameterAssert([self isMemberOfClass:[OCTIssueCommentEvent class]] || [self isMemberOfClass:[OCTIssueEvent class]]);
    
    OCTIssue *issue = [self valueForKey:@"issue"];
    
    NSString *issueID = [issue.URL.absoluteString componentsSeparatedByString:@"/"].lastObject;
    NSURL *HTMLURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@?title=Issue-@%@", issue.HTMLURL.absoluteString, issueID]];
    
    NSMutableAttributedString *attributedString = [NSString stringWithFormat:@"%@#%@", self.repositoryName, issueID].lyx_attributedString;
    
    [attributedString lyx_addBoldTitleFontAttribute];
    [attributedString lyx_addTintedForegroundColorAttribute];
    [attributedString lyx_addHTMLURLAttribute:HTMLURL];
    
    return attributedString;
}

- (NSMutableAttributedString *)lyx_memberLoginAttributedString {
    NSParameterAssert([self isMemberOfClass:[OCTMemberEvent class]]);
    
    return [self lyx_loginAttributedStringWithString:[self valueForKey:@"memberLogin"]];
}

- (NSMutableAttributedString *)lyx_pullRequestAttributedString {
    NSParameterAssert([self isKindOfClass:[OCTPullRequestCommentEvent class]] || [self isMemberOfClass:[OCTPullRequestEvent class]]);
    
    NSString *pullRequestID = nil;
    NSURL *HTMLURL = nil;
    if ([self isKindOfClass:[OCTPullRequestCommentEvent class]]) {
        OCTPullRequestCommentEvent *concreteEvent = (OCTPullRequestCommentEvent *)self;
        
        pullRequestID = [concreteEvent.comment.pullRequestAPIURL.absoluteString componentsSeparatedByString:@"/"].lastObject;
        
        HTMLURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@?title=Pull-Request-@%@", concreteEvent.comment.HTMLURL.absoluteString, pullRequestID]];
    } else if ([self isMemberOfClass:[OCTPullRequestEvent class]]) {
        OCTPullRequestEvent *concreteEvent = (OCTPullRequestEvent *)self;
        
        pullRequestID = [concreteEvent.pullRequest.URL.absoluteString componentsSeparatedByString:@"/"].lastObject;
        
        HTMLURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@?title=Pull-Request-@%@", concreteEvent.pullRequest.HTMLURL.absoluteString, pullRequestID]];
    }
    
    NSParameterAssert(pullRequestID.length > 0);
    NSParameterAssert(HTMLURL);
    
    NSMutableAttributedString *attributedString = [NSString stringWithFormat:@"%@#%@", self.repositoryName, pullRequestID].lyx_attributedString;
    
    [attributedString lyx_addBoldTitleFontAttribute];
    [attributedString lyx_addTintedForegroundColorAttribute];
    [attributedString lyx_addHTMLURLAttribute:HTMLURL];
    
    return attributedString;
}

- (NSMutableAttributedString *)lyx_branchNameAttributedString {
    NSParameterAssert([self isMemberOfClass:[OCTPushEvent class]]);
    
    NSString *branchName = [self valueForKey:@"branchName"];
    
    NSMutableAttributedString *attributedString = branchName.lyx_attributedString;
    
    [attributedString lyx_addBoldTitleFontAttribute];
    [attributedString lyx_addTintedForegroundColorAttribute];
    [attributedString lyx_addRepositoryLinkAttributeWithName:self.repositoryName referenceName:LYXReferenceNameWithBranchName(branchName)];
    
    return attributedString;
}

- (NSMutableAttributedString *)lyx_pushedCommitAttributedStringWithSHA:(NSString *)SHA {
    NSParameterAssert([self isMemberOfClass:[OCTPushEvent class]]);
    
    NSMutableAttributedString *attributedString = [@"\n" stringByAppendingString:LYXShortSHA(SHA)].lyx_attributedString;
    
    NSURL *HTMLURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://github.com/%@/commit/%@?title=Commit", self.repositoryName, SHA]];
    
    [attributedString lyx_addNormalTitleFontAttribute];
    [attributedString lyx_addTintedForegroundColorAttribute];
    [attributedString lyx_addHTMLURLAttribute:HTMLURL];
    
    return attributedString;
}

- (NSMutableAttributedString *)lyx_pushedCommitsAttributedString {
    NSParameterAssert([self isMemberOfClass:[OCTPushEvent class]]);
    
    OCTPushEvent *concreteEvent = (OCTPushEvent *)self;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
    for (NSDictionary *dictionary in concreteEvent.commits) {
        /* {
         "sha": "6e4dc62cffe9f2d1b1484819936ee264dde36592",
         "author": {
         "email": "coderyi@foxmail.com",
         "name": "coderyi"
         },
         "message": "增加iOS开发者coderyi的博客\n\n增加iOS开发者coderyi的博客",
         "distinct": true,
         "url": "https://api.github.com/repos/tangqiaoboy/iOSBlogCN/commits/6e4dc62cffe9f2d1b1484819936ee264dde36592"
         } */
        NSMutableAttributedString *commit = [[NSMutableAttributedString alloc] init];
        
        [commit appendAttributedString:[self lyx_pushedCommitAttributedStringWithSHA:dictionary[@"sha"]]];
        [commit appendAttributedString:[@" - " stringByAppendingString:dictionary[@"message"]].lyx_attributedString.lyx_addNormalTitleAttributes];
        
        [attributedString appendAttributedString:commit];
    }
    
    return attributedString.lyx_addParagraphStyleAttribute;
}

- (NSMutableAttributedString *)lyx_refNameAttributedString {
    NSParameterAssert([self isMemberOfClass:[OCTRefEvent class]]);
    
    OCTRefEvent *concreteEvent = (OCTRefEvent *)self;
    
    if (!concreteEvent.refName) return @" ".lyx_attributedString;
    
    NSMutableAttributedString *attributedString = concreteEvent.refName.lyx_attributedString;
    
    [attributedString lyx_addNormalTitleFontAttribute];
    
    if (concreteEvent.eventType == OCTRefEventCreated) {
        [attributedString lyx_addTintedForegroundColorAttribute];
        
        if (concreteEvent.refType == OCTRefTypeBranch) {
            [attributedString lyx_addRepositoryLinkAttributeWithName:self.repositoryName referenceName:LYXReferenceNameWithBranchName(concreteEvent.refName)];
        } else if (concreteEvent.refType == OCTRefTypeTag) {
            [attributedString lyx_addRepositoryLinkAttributeWithName:self.repositoryName referenceName:LYXReferenceNameWithTagName(concreteEvent.refName)];
        }
    } else if (concreteEvent.eventType == OCTRefEventDeleted) {
        [attributedString insertAttributedString:@" ".lyx_attributedString atIndex:0];
        [attributedString appendString:@" "];
        [attributedString lyx_addNormalTitleForegroundColorAttribute];
        [attributedString lyx_addBackgroundColorAttribute];
    }
    
    return attributedString;
}

- (NSMutableAttributedString *)lyx_dateAttributedString {
    TTTTimeIntervalFormatter *timeIntervalFormatter = [[TTTTimeIntervalFormatter alloc] init];
    
    timeIntervalFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSString *date = [@"\n" stringByAppendingString:[timeIntervalFormatter stringForTimeIntervalFromDate:[NSDate date] toDate:self.date]];
    
    NSMutableAttributedString *attributedString = date.lyx_attributedString;
    
    [attributedString lyx_addTimeFontAttribute];
    [attributedString lyx_addTimeForegroundColorAttribute];
    [attributedString lyx_addParagraphStyleAttribute];
    
    return attributedString;
}

- (NSMutableAttributedString *)lyx_pullInfoAttributedString {
    NSParameterAssert([self isMemberOfClass:[OCTPullRequestEvent class]]);
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
    
    OCTPullRequestEvent *concreteEvent = (OCTPullRequestEvent *)self;
    
    NSString *octicon = [NSString stringWithFormat:@"\n %@ ", [NSString octicon_iconStringForEnum:OCTIconGitCommit]];
    
    NSString *commits   = concreteEvent.pullRequest.commits > 1 ? @" commits with " : @" commit with ";
    NSString *additions = concreteEvent.pullRequest.additions > 1 ? @" additions and " : @" addition and ";
    NSString *deletions = concreteEvent.pullRequest.deletions > 1 ? @" deletions " : @" deletion ";
    
    [attributedString appendAttributedString:octicon.lyx_attributedString.lyx_addOcticonAttributes.lyx_addParagraphStyleAttribute];
    [attributedString appendAttributedString:@(concreteEvent.pullRequest.commits).stringValue.lyx_attributedString.lyx_addBoldPullInfoFontAttribute.lyx_addPullInfoForegroundColorAttribute];
    [attributedString appendAttributedString:commits.lyx_attributedString.lyx_addNormalPullInfoFontAttribute.lyx_addPullInfoForegroundColorAttribute];
    [attributedString appendAttributedString:@(concreteEvent.pullRequest.additions).stringValue.lyx_attributedString.lyx_addBoldPullInfoFontAttribute.lyx_addPullInfoForegroundColorAttribute];
    [attributedString appendAttributedString:additions.lyx_attributedString.lyx_addNormalPullInfoFontAttribute.lyx_addPullInfoForegroundColorAttribute];
    [attributedString appendAttributedString:@(concreteEvent.pullRequest.deletions).stringValue.lyx_attributedString.lyx_addBoldPullInfoFontAttribute.lyx_addPullInfoForegroundColorAttribute];
    [attributedString appendAttributedString:deletions.lyx_attributedString.lyx_addNormalPullInfoFontAttribute.lyx_addPullInfoForegroundColorAttribute];
    [attributedString lyx_addBackgroundColorAttribute];
    
    return attributedString;
}

- (NSMutableAttributedString *)lyx_commitCommentEventAttributedString {
    NSParameterAssert([self isMemberOfClass:[OCTCommitCommentEvent class]]);
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
    
    [attributedString appendAttributedString:@" commented on commit ".lyx_attributedString.lyx_addBoldTitleAttributes];
    [attributedString appendAttributedString:self.lyx_commentedCommitAttributedString];
    
    return attributedString;
}

- (NSMutableAttributedString *)lyx_forkEventAttributedString {
    NSParameterAssert([self isMemberOfClass:[OCTForkEvent class]]);
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
    
    [attributedString appendAttributedString:@" forked ".lyx_attributedString.lyx_addNormalTitleAttributes];
    [attributedString appendAttributedString:self.lyx_repositoryNameAttributedString];
    [attributedString appendAttributedString:@" to ".lyx_attributedString.lyx_addNormalTitleAttributes];
    [attributedString appendAttributedString:self.lyx_forkedRepositoryNameAttributedString];
    
    return attributedString;
}

- (NSMutableAttributedString *)lyx_issueCommentEventAttributedString {
    NSParameterAssert([self isMemberOfClass:[OCTIssueCommentEvent class]]);
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
    
    [attributedString appendAttributedString:@" commented on issue ".lyx_attributedString.lyx_addBoldTitleAttributes];
    [attributedString appendAttributedString:self.lyx_issueAttributedString];
    
    return attributedString;
}

- (NSMutableAttributedString *)lyx_issueEventAttributedString {
    NSParameterAssert([self isMemberOfClass:[OCTIssueEvent class]]);
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
    
    OCTIssueEvent *concreteEvent = (OCTIssueEvent *)self;
    
    NSString *action = nil;
    if (concreteEvent.action == OCTIssueActionOpened) {
        action = @"opened";
    } else if (concreteEvent.action == OCTIssueActionClosed) {
        action = @"closed";
    } else if (concreteEvent.action == OCTIssueActionReopened) {
        action = @"reopened";
    }
    
    [attributedString appendAttributedString:[NSString stringWithFormat:@" %@ issue ", action].lyx_attributedString.lyx_addBoldTitleAttributes];
    [attributedString appendAttributedString:self.lyx_issueAttributedString];
    [attributedString appendAttributedString:[@"\n" stringByAppendingString:concreteEvent.issue.title].lyx_attributedString.lyx_addNormalTitleAttributes.lyx_addParagraphStyleAttribute];
    
    return attributedString;
}

- (NSMutableAttributedString *)lyx_memberEventAttributedString {
    NSParameterAssert([self isMemberOfClass:[OCTMemberEvent class]]);
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
    
    [attributedString appendAttributedString:@" added ".lyx_attributedString.lyx_addNormalTitleAttributes];
    [attributedString appendAttributedString:self.lyx_memberLoginAttributedString];
    [attributedString appendAttributedString:@" to ".lyx_attributedString.lyx_addNormalTitleAttributes];
    [attributedString appendAttributedString:self.lyx_repositoryNameAttributedString];
    
    return attributedString;
}

- (NSMutableAttributedString *)lyx_publicEventAttributedString {
    NSParameterAssert([self isMemberOfClass:[OCTPublicEvent class]]);
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
    
    [attributedString appendAttributedString:@" open sourced ".lyx_attributedString.lyx_addNormalTitleAttributes];
    [attributedString appendAttributedString:self.lyx_repositoryNameAttributedString];
    
    return attributedString;
}

- (NSMutableAttributedString *)lyx_pullRequestCommentEventAttributedString {
    NSParameterAssert([self isMemberOfClass:[OCTPullRequestCommentEvent class]]);
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
    
    [attributedString appendAttributedString:@" commented on pull request ".lyx_attributedString.lyx_addBoldTitleAttributes];
    [attributedString appendAttributedString:self.lyx_pullRequestAttributedString];
    
    return attributedString;
}

- (NSMutableAttributedString *)lyx_pullRequestEventAttributedString {
    NSParameterAssert([self isMemberOfClass:[OCTPullRequestEvent class]]);
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
    
    OCTPullRequestEvent *concreteEvent = (OCTPullRequestEvent *)self;
    
    NSString *action = nil;
    if (concreteEvent.action == OCTIssueActionOpened) {
        action = @"opened";
    } else if (concreteEvent.action == OCTIssueActionClosed) {
        action = @"closed";
    } else if (concreteEvent.action == OCTIssueActionReopened) {
        action = @"reopened";
    } else if (concreteEvent.action == OCTIssueActionSynchronized) {
        action = @"synchronized";
    }
    
    [attributedString appendAttributedString:[NSString stringWithFormat:@" %@ pull request ", action].lyx_attributedString.lyx_addBoldTitleAttributes];
    [attributedString appendAttributedString:self.lyx_pullRequestAttributedString];
    [attributedString appendAttributedString:[@"\n" stringByAppendingString:concreteEvent.pullRequest.title].lyx_attributedString.lyx_addNormalTitleAttributes.lyx_addParagraphStyleAttribute];
    [attributedString appendAttributedString:self.lyx_pullInfoAttributedString];
    
    return attributedString;
}

- (NSMutableAttributedString *)lyx_pushEventAttributedString {
    NSParameterAssert([self isMemberOfClass:[OCTPushEvent class]]);
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
    
    [attributedString appendAttributedString:@" pushed to ".lyx_attributedString.lyx_addBoldTitleAttributes];
    [attributedString appendAttributedString:self.lyx_branchNameAttributedString];
    [attributedString appendAttributedString:@" at ".lyx_attributedString.lyx_addBoldTitleAttributes];
    [attributedString appendAttributedString:self.lyx_repositoryNameAttributedString];
    [attributedString appendAttributedString:self.lyx_pushedCommitsAttributedString];
    
    return attributedString;
}

- (NSMutableAttributedString *)lyx_refEventAttributedString {
    NSParameterAssert([self isMemberOfClass:[OCTRefEvent class]]);
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
    
    OCTRefEvent *concreteEvent = (OCTRefEvent *)self;
    
    NSString *action = nil;
    if (concreteEvent.eventType == OCTRefEventCreated) {
        action = @"created";
    } else if (concreteEvent.eventType == OCTRefEventDeleted) {
        action = @"deleted";
    }
    
    NSString *type = nil;
    if (concreteEvent.refType == OCTRefTypeBranch) {
        type = @"branch";
    } else if (concreteEvent.refType == OCTRefTypeTag) {
        type = @"tag";
    } else if (concreteEvent.refType == OCTRefTypeRepository) {
        type = @"repository";
    }
    
    NSString *at = (concreteEvent.refType == OCTRefTypeBranch || concreteEvent.refType == OCTRefTypeTag ? @" at " : @"");
    
    [attributedString appendAttributedString:[NSString stringWithFormat:@" %@ %@ ", action, type].lyx_attributedString.lyx_addNormalTitleAttributes];
    [attributedString appendAttributedString:self.lyx_refNameAttributedString];
    [attributedString appendAttributedString:at.lyx_attributedString.lyx_addNormalTitleAttributes];
    [attributedString appendAttributedString:self.lyx_repositoryNameAttributedString];
    
    return attributedString;
}

- (NSMutableAttributedString *)lyx_watchEventAttributedString {
    NSParameterAssert([self isMemberOfClass:[OCTWatchEvent class]]);
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
    
    [attributedString appendAttributedString:@" starred ".lyx_attributedString.lyx_addNormalTitleAttributes];
    [attributedString appendAttributedString:self.lyx_repositoryNameAttributedString];
    
    return attributedString;
}

#pragma mark - Private

static NSString *LYXShortSHA(NSString *SHA) {
    NSCParameterAssert(SHA.length > 0);
    return [SHA substringToIndex:7];
}

@end