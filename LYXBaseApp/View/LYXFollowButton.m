//
//  LYXFollowButton.m
//  LYXBaseApp
//
//  Created by Yunxin.Li on 15/10/23.
//  Copyright © 2015年 LYX. All rights reserved.
//

#import "LYXFollowButton.h"

#define LYX_FOLLOW_BUTTON_IMAGE_SIZE CGSizeMake(16, 16)

static UIImage *_image = nil;
static UIImage *_selectedImage = nil;

@implementation LYXFollowButton

- (id)init {
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _image = [UIImage octicon_imageWithIcon:@"Person"
                                backgroundColor:[UIColor clearColor]
                                      iconColor:HexRGB(0xffffff)
                                      iconScale:1
                                        andSize:LYX_FOLLOW_BUTTON_IMAGE_SIZE];
        _selectedImage = [UIImage octicon_imageWithIcon:@"Person"
                                        backgroundColor:[UIColor clearColor]
                                              iconColor:HexRGB(0x333333)
                                              iconScale:1
                                                andSize:LYX_FOLLOW_BUTTON_IMAGE_SIZE];
    });
    
    self.layer.borderColor = HexRGB(0xd5d5d5).CGColor;
    self.layer.cornerRadius = 5;
    self.clipsToBounds = YES;
    
    self.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    self.contentEdgeInsets = UIEdgeInsetsMake(7, 1, 7, 3);
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    if (!selected) {
        [self setImage:_image forState:UIControlStateNormal];
        [self setTitle:@"Follow" forState:UIControlStateNormal];
        [self setTitleColor:HexRGB(0xffffff) forState:UIControlStateNormal];
        
        self.backgroundColor = HexRGB(0x569e3d);
        self.layer.borderWidth = 0;
    } else {
        [self setImage:_selectedImage forState:UIControlStateNormal];
        [self setTitle:@"Unfollow" forState:UIControlStateNormal];
        [self setTitleColor:HexRGB(0x333333) forState:UIControlStateNormal];
        
        self.backgroundColor = HexRGB(0xeeeeee);
        self.layer.borderWidth = 1;
    }
}

@end