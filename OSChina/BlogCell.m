//
//  BlogCell.m
//  OSChina
//
//  Created by baxiang on 14-2-13.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//

#import "BlogCell.h"

@interface BlogCell()

@end
@implementation BlogCell{

    UIImageView *separLine;
    UILabel *titleLable;
    UILabel *createdLabel;
    UILabel *repliesCountLabel;
    UIImageView *feedBack;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        titleLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, 40)];
        titleLable.font = [UIFont boldSystemFontOfSize:16];
        titleLable.backgroundColor = [UIColor clearColor];
        titleLable.textColor = [UIColor blackColor];
        [self.contentView addSubview:titleLable];
        separLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, 320, 0.5)];
        separLine.image = [[UIImage imageNamed:@"separateLine"] stretchableImageWithLeftCapWidth:0 topCapHeight:0];
        [self.contentView addSubview:separLine];
        createdLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLable.left, separLine.bottom+10, 200, 20)];
        createdLabel.font = [UIFont systemFontOfSize:14.f];
        createdLabel.backgroundColor = [UIColor clearColor];
        createdLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:createdLabel];
        feedBack = [[UIImageView alloc] initWithFrame:CGRectMake(250, separLine.bottom+15, 17, 15)];
        feedBack.image = [UIImage imageNamed:@"icon_feedback"];
        [self.contentView addSubview:feedBack];
        repliesCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(feedBack.right+5, feedBack.top, 40, 14)];
        repliesCountLabel.font = [UIFont systemFontOfSize:14.f];
        repliesCountLabel.backgroundColor = [UIColor clearColor];
        repliesCountLabel.textColor = RGB(74, 171, 218);
        repliesCountLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:repliesCountLabel];
    }
    return self;
}
-(void)layoutSubviews{
    
    [super layoutSubviews];
    titleLable.text =_blog.blogTitle;
    createdLabel.text = [NSString stringWithFormat:@"%@发表于%@",_blog.authorname,[_blog.pubDate intervalSinceNow]];
    repliesCountLabel.text =_blog.commentCount ;
}
-(void)setFrame:(CGRect)frame

{
    
    frame.origin.x += 5;
    frame.size.width -= 10;
    [super setFrame:frame];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
