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
#import "AMAttributedHighlightLabel.h"
#import "TTTAttributedLabel.h"
@interface TweetCell()

@end
@implementation TweetCell{


    UIImageView *headIcon;
    UILabel * authorLable;
     UILabel * bodyLable;
     UILabel * createdLabel;
     UILabel * repliesCountLabel;
     UIImageView *separLine;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
       headIcon= [[UIImageView alloc] initWithFrame:CGRectZero];
       headIcon.layer.cornerRadius = 20.0f;
       headIcon.layer.MasksToBounds = YES;
       headIcon.layer.borderWidth = 1.0f;
        headIcon.layer.borderColor = [[UIColor grayColor] CGColor];
        //[self.contentView addSubview:headIcon];
        
        authorLable = [[UILabel alloc] initWithFrame:CGRectZero];
        authorLable.font = [UIFont systemFontOfSize:14.0f];
        authorLable.backgroundColor = [UIColor clearColor];
        authorLable.textColor = RGB(69, 176, 222);
        //[self.contentView addSubview:authorLable];
       
        bodyLable = [[UILabel alloc] initWithFrame:CGRectMake(55,40,250,200)];
        bodyLable.backgroundColor = [UIColor clearColor];
        bodyLable.numberOfLines = 0;
        bodyLable.textColor = [UIColor blackColor];
        bodyLable.lineBreakMode = NSLineBreakByCharWrapping;
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
        
//        separLine= [[UIImageView alloc] initWithFrame:CGRectZero];
//        separLine.image = [UIImage imageNamed:@"separateLine"];
//        [self.contentView addSubview:separLine];
    }
    return self;
}

-(void) layoutSubviews{
    
    
    [headIcon setImageWithURL:[NSURL URLWithString:_tweet.portrait] placeholderImage:nil];
    headIcon.frame = CGRectMake(10, 5, 40, 40);
    authorLable.frame = CGRectMake(headIcon.right+10, 10, 250, 15);
    authorLable.text =_tweet.author;
    UIFont *font = [UIFont systemFontOfSize:15.0f];
   
    CGSize size = CGSizeMake(250,CGFLOAT_MAX);
    //计算实际frame大小，并将label的frame变成实际大小
    //CGSize labelsize = [_tweet.body sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                          font, NSFontAttributeName,
                                          nil];
    CGRect frame = [_tweet.body boundingRectWithSize:size
                                            options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                         attributes:attributesDictionary
                                            context:nil];
    [bodyLable setText:_tweet.body];
    bodyLable.frame = CGRectMake(0,0,frame.size.width,frame.size.height);
    //separLine.frame = CGRectMake(20, bodyLable.bottom+10, 300, 1);
    
    
}
+(CGFloat) getCurrTweetCellHright:(Tweet*) tweet{
   
    CGSize size = CGSizeMake(250,CGFLOAT_MAX);
    //计算实际frame大小，并将label的frame变成实际大小
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
