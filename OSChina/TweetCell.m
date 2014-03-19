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

@end
@implementation TweetCell{


    UIImageView *headIcon;
    UILabel * authorLable;
     RTLabel * bodyLable;
     UILabel * createdLabel;
     UILabel * repliesCountLabel;
     UIImageView *separLine;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
       headIcon= [[UIImageView alloc] initWithFrame:CGRectMake(10, -5, 40, 40)];
       headIcon.layer.cornerRadius = 20.0f;
       headIcon.layer.MasksToBounds = YES;
       headIcon.layer.borderWidth = 1;
        headIcon.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        [self.contentView addSubview:headIcon];
        
        authorLable = [[UILabel alloc] initWithFrame:CGRectZero];
        authorLable.font = [UIFont systemFontOfSize:14.0f];
        authorLable.backgroundColor = [UIColor clearColor];
        authorLable.textColor = RGB(69, 176, 222);
        [self.contentView addSubview:authorLable];
       
        bodyLable = [[RTLabel alloc] initWithFrame:CGRectMake(50,40,250,200)];
        bodyLable.backgroundColor = [UIColor clearColor];
        bodyLable.font = [UIFont systemFontOfSize:15.0f];
		[self.contentView addSubview:bodyLable];
        
        createdLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        createdLabel.font = [UIFont systemFontOfSize:15.f];
        createdLabel.backgroundColor = [UIColor clearColor];
        createdLabel.textColor = [UIColor blackColor];
        
        [self.contentView addSubview:createdLabel];
        
        repliesCountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        repliesCountLabel.font = [UIFont systemFontOfSize:15.f];
        repliesCountLabel.backgroundColor = [UIColor clearColor];
        repliesCountLabel.textColor = [UIColor whiteColor];
        repliesCountLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:repliesCountLabel];
        
        separLine= [[UIImageView alloc] initWithFrame:CGRectZero];
        separLine.image = [UIImage imageNamed:@"separateLine"];
        [self.contentView addSubview:separLine];
    }
    return self;
}

-(void) layoutSubviews{
    
    [headIcon setImageWithURL:[NSURL URLWithString:_tweet.portrait] placeholderImage:nil];
    
    authorLable.frame = CGRectMake(headIcon.right+10, 10, 250, 15);
    authorLable.text =_tweet.author;
    bodyLable.text = _tweet.body;
    CGSize optimumSize = [bodyLable optimumSize];
	CGRect frame = bodyLable.frame;
	frame.size.height = (int)optimumSize.height+5;
	[bodyLable setFrame:frame];
    separLine.frame = CGRectMake(20, bodyLable.bottom+5, 300, 1);
    
    
}
+(CGFloat) getCurrTweetCellHright:(Tweet*) tweet{
   
    RTLabel *content =[[RTLabel alloc] initWithFrame:CGRectMake(50,40,250,100)];
    [content setParagraphReplacement:@""];
    content.text = tweet.body;
    CGSize optimumSize = [content optimumSize];
    return optimumSize.height+65;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
