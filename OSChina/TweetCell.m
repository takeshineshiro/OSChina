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
@property (strong,nonatomic) UIImageView *contentImage;
@end

#define MAX_WIDTH  200.0
#define MAX_HEIGHT 120.0
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
        _contentImage= [[UIImageView alloc] initWithFrame:CGRectZero];
        _contentImage.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_contentImage];
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
    bodyLable.lineBreakMode = NSLineBreakByWordWrapping;
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
    
    if (_tweet.imgSmall&&[_tweet.imgSmall isKindOfClass:[NSString class]]) {
        _contentImage.hidden = NO;
        [self addImageviewHandle:_tweet.imgSmall imagetop:bodyLable.bottom+5];
    }else{
        _contentImage.hidden = YES;
    }
    
    
}

-(void) addImageviewHandle:(NSString*) imageUrl imagetop:(CGFloat) top{

    __weak TweetCell *weakSelf = self;
    [_contentImage setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        if(image==nil)return;
        CGSize size=image.size;
        float scale=size.height/size.width;
        float width=MAX_HEIGHT/scale,height=MAX_HEIGHT;
        if(scale<=(MAX_HEIGHT/MAX_WIDTH)&&width>=MAX_WIDTH)
        {
            width=MAX_WIDTH;
            height=width*scale;
        }
        scale= width/size.width;
        if(scale!=1){
            image=[UIImage imageWithCGImage:image.CGImage scale:scale orientation:UIImageOrientationUp];
        }
        size=image.size;
        weakSelf.contentImage.frame=CGRectMake(20,top, width, height);
        weakSelf.contentImage.image=image;
        UITapGestureRecognizer * tap=[[UITapGestureRecognizer alloc]initWithTarget:weakSelf action:@selector(lookImageAction)];
        weakSelf.contentImage.userInteractionEnabled=YES;
        [weakSelf.contentImage addGestureRecognizer:tap];
    }];

}

-(void)lookImageAction{


}
+(CGFloat) getCurrTweetCellHeight:(Tweet*) tweet{
    CGFloat cellHeight = 55;
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
    if (tweet.imgSmall&&[tweet.imgSmall isKindOfClass:[NSString class]]) {
       cellHeight+=150;
    }
    return frame.size.height+cellHeight;
    
}

+(CGFloat) getImageHeight:(NSString*) url{
    UIImageView *image = [[UIImageView alloc] init];
    __block CGSize imageSize ;
    [image setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        if(image==nil)return;
        CGSize size=image.size;
        float scale=size.height/size.width;
        float width=MAX_HEIGHT/scale,height=MAX_HEIGHT;
        if(scale<=(MAX_HEIGHT/MAX_WIDTH)&&width>=MAX_WIDTH)
        {
            width=MAX_WIDTH;
            height=width*scale;
        }
        scale= width/size.width;
        if(scale!=1){
            image=[UIImage imageWithCGImage:image.CGImage scale:scale orientation:UIImageOrientationUp];
        }
        imageSize=image.size;
        
    }];
    return imageSize.height;

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
   
}

@end
