//
//  PostCell.m
//  OSChina
//
//  Created by baxiang on 14-2-16.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//

#import "PostCell.h"
#import "UIImageView+AFNetworking.h"
#import "UIImage+BxExtension.h"

@interface PostCell()
@property (nonatomic, strong) UIImageView *headIcon;
@property (nonatomic, strong) UILabel * titleLable;
@property (nonatomic, strong) UILabel * createdLabel;
@property (nonatomic, strong) UILabel * repliesCountLabel;
@end
@implementation PostCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _headIcon= [[UIImageView alloc] initWithFrame:CGRectZero];
        _headIcon.layer.cornerRadius = 20.0f;
        _headIcon.layer.MasksToBounds = YES;
        _headIcon.layer.borderWidth = 1;
        _headIcon.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        [self.contentView addSubview:_headIcon];
        
        self.titleLable = [[UILabel alloc] initWithFrame:CGRectZero];
        self.titleLable.font = [UIFont boldSystemFontOfSize:15];
        self.titleLable.backgroundColor = [UIColor clearColor];
        self.titleLable.textColor = [UIColor blackColor];
        //self.titleLable.numberOfLines = 2;
        self.titleLable.lineBreakMode = NSLineBreakByCharWrapping;
        self.titleLable.numberOfLines = 0;
        [self.contentView addSubview:self.titleLable];
        
        self.createdLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.createdLabel.font = [UIFont systemFontOfSize:15.f];
        self.createdLabel.backgroundColor = [UIColor clearColor];
        self.createdLabel.textColor = [UIColor blackColor];
        
        [self.contentView addSubview:self.createdLabel];
        
        self.repliesCountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.repliesCountLabel.font = [UIFont systemFontOfSize:15.f];
        self.repliesCountLabel.backgroundColor = [UIColor clearColor];
        self.repliesCountLabel.textColor = [UIColor whiteColor];
        self.repliesCountLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.repliesCountLabel];
        
    }
    return self;
}
-(void) layoutSubviews{
    
    _headIcon.frame = CGRectMake(10, 10, 40, 40);
    [_headIcon setImageWithURL:[NSURL URLWithString:_post.portrait] placeholderImage:nil];
    
    self.titleLable.frame = CGRectMake(_headIcon.right+10, 5, self.width-90, 40);
    self.titleLable.text =_post.title;
    self.createdLabel.frame = CGRectMake(self.titleLable.left, self.titleLable.bottom+5, 200, 20);
    self.createdLabel.text = [NSString stringWithFormat:@"%@发表于%@",_post.author,[_post.pubDate intervalSinceNow]];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
