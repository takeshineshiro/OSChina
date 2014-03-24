//
//  TweetCell.m
//  OSChina
//
//  Created by baxiang on 14-2-27.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//

#import "TweetCell.h"
//#import "UIImageView+AFNetworking.h"
#import "RTLabel.h"
#import "AMAttributedHighlightLabel.h"
#import "TTTAttributedLabel.h"
#import "UIImageView+WebCache.h"
@interface TweetCell()

@end
@implementation TweetCell{


     UIImageView *headIcon;
     UIImageView *replyCountIcon;
     UILabel * authorLable;
     TTTAttributedLabel * bodyLable;
     UILabel * createdTime;
     UILabel * repliesCountLabel;
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        headIcon= [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 40, 40)];
        [self.contentView addSubview:headIcon];
        authorLable = [[UILabel alloc] initWithFrame:CGRectZero];
        authorLable.font = [UIFont systemFontOfSize:14.0f];
        authorLable.backgroundColor = [UIColor clearColor];
        authorLable.textColor = RGB(69, 176, 222);
        [self.contentView addSubview:authorLable];
       
        bodyLable = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(55,40,250,200)];
        bodyLable.backgroundColor = [UIColor clearColor];
        bodyLable.numberOfLines = 0;
        bodyLable.textColor = [UIColor blackColor];
        bodyLable.lineBreakMode = NSLineBreakByCharWrapping;
        bodyLable.font = [UIFont systemFontOfSize:15.0f];
		[self.contentView addSubview:bodyLable];
        
        createdTime = [[UILabel alloc] initWithFrame:CGRectZero];
        createdTime.textColor = [UIColor lightGrayColor];
        createdTime.font = [UIFont systemFontOfSize:12.0f];
        createdTime.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:createdTime];
       
        replyCountIcon= [[UIImageView alloc] initWithFrame:CGRectMake(270, 5, 20, 20)];
        replyCountIcon.image = [UIImage imageNamed:@"icon_feedback"];
        [self.contentView addSubview:replyCountIcon];
        repliesCountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        repliesCountLabel.font = [UIFont systemFontOfSize:14.f];
        repliesCountLabel.backgroundColor = [UIColor clearColor];
        repliesCountLabel.textColor = RGB(69, 176, 222);
        repliesCountLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:repliesCountLabel];
        
    }
    return self;
}

-(void) layoutSubviews{
    [super layoutSubviews];
    
    [headIcon setImageWithURL:[NSURL URLWithString:_tweet.portrait] placeholderImage:nil];
    headIcon.frame = CGRectMake(10, 5, 40, 40);
    headIcon.layer.cornerRadius = 20.0f;
    headIcon.layer.MasksToBounds = YES;
    headIcon.layer.borderWidth = 1.0f;
    headIcon.layer.borderColor = [[UIColor grayColor] CGColor];
    authorLable.frame = CGRectMake(55, 5, 250, 15);
    authorLable.text =_tweet.author;
    createdTime.frame = CGRectMake(55, authorLable.bottom+5, 250, 15);
    createdTime.text = [_tweet.pubDate intervalSinceNow] ;
    repliesCountLabel.frame =CGRectMake(replyCountIcon.right, replyCountIcon.top, 20, 20);
    repliesCountLabel.text = _tweet.commentCount;
    bodyLable.numberOfLines = 0;
    bodyLable.lineBreakMode = NSLineBreakByCharWrapping;
    UIFont *font = [UIFont systemFontOfSize:15.0f];
    CGSize size = CGSizeMake(260,MAXFLOAT);
    //CGSize labelsize = [_tweet.body sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                          font, NSFontAttributeName,
                                          nil];
    CGRect frame = [_tweet.body boundingRectWithSize:size
                                            options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                         attributes:attributesDictionary
                                            context:nil];
    bodyLable.frame = CGRectMake(headIcon.right,headIcon.bottom+5,frame.size.width,frame.size.height);
    [bodyLable setText:_tweet.body];
   
    
    
}
+(CGFloat) getCurrTweetCellHeight:(Tweet*) tweet{
   
    CGSize size = CGSizeMake(260,MAXFLOAT);
    UIFont *font = [UIFont systemFontOfSize:15.0f];
    //CGSize optimumSize = [tweet.body sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                          font, NSFontAttributeName,
                                          nil];
    CGRect frame = [tweet.body boundingRectWithSize:size
                                      options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                   attributes:attributesDictionary
                                      context:nil];
    
    // This contains both height and width, but we really care about height.
    
    return frame.size.height+55;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
   
}

@end
