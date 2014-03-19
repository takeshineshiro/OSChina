//
//  TweetCell.m
//  OSChina
//
//  Created by baxiang on 14-2-27.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//

#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"
#import "RTLabel.h"
@interface TweetCell()
@property (nonatomic, strong) UIImageView *headIcon;
@property (nonatomic, strong) UILabel * authorLable;
@property (nonatomic, strong) RTLabel * bodyLable;
@property (nonatomic, strong) UILabel * createdLabel;
@property (nonatomic, strong) UILabel * repliesCountLabel;
@end
@implementation TweetCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _headIcon= [[UIImageView alloc] initWithFrame:CGRectZero];
        _headIcon.layer.cornerRadius = 20.0f;
        _headIcon.layer.MasksToBounds = YES;
        _headIcon.layer.borderWidth = 1;
        _headIcon.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        [self.contentView addSubview:_headIcon];
        
        self.authorLable = [[UILabel alloc] initWithFrame:CGRectZero];
        self.authorLable.font = [UIFont systemFontOfSize:14.0f];
        self.authorLable.backgroundColor = [UIColor clearColor];
        self.authorLable.textColor = RGB(69, 176, 222);
        [self.contentView addSubview:self.authorLable];
       
        _bodyLable = [[RTLabel alloc] initWithFrame:CGRectMake(60,40,250,100)];
        _bodyLable.backgroundColor = [UIColor clearColor];
        _bodyLable .font = [UIFont systemFontOfSize:15.0f];
		[self.contentView addSubview:_bodyLable];
        
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
    
    _headIcon.frame = CGRectMake(10, 5, 40, 40);
    [_headIcon setImageWithURL:[NSURL URLWithString:_tweet.portrait] placeholderImage:nil];
    
    self.authorLable.frame = CGRectMake(_headIcon.right+10, 5, 250, 15);
    self.authorLable.text =_tweet.author;
    
    _bodyLable.text = _tweet.body;
    CGSize optimumSize = [_bodyLable optimumSize];
	CGRect frame = _bodyLable.frame;
	frame.size.height = (int)optimumSize.height+5; // +5 to fix height issue, this should be automatically fixed in iOS5
	[_bodyLable setFrame:frame];
    
}
+(CGFloat) getCurrTweetCellHright:(Tweet*) tweet{
    
    RTLabel *content =[[RTLabel alloc] initWithFrame:CGRectMake(60,40,250,100)];
    [content setParagraphReplacement:@""];
    //content.lineSpacing = 20.0;
    content.text = tweet.body;
    
    CGSize optimumSize = [content optimumSize];
	
    
    return optimumSize.height+50;

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
