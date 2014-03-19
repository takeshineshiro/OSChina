//
//  NewsCell.m
//  OSChina
//
//  Created by baxiang on 14-2-11.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//

#import "NewsCell.h"

@interface NewsCell()

@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) UILabel *createdLabel;
@property (nonatomic, strong) UILabel *repliesCountLabel;
@end
@implementation NewsCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.titleLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, self.width-40, 20)];
        self.titleLable.font = [UIFont boldSystemFontOfSize:15];
        self.titleLable.backgroundColor = [UIColor clearColor];
        self.titleLable.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.titleLable];
        
        self.createdLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLable.left, self.titleLable.bottom+10, 200, 20)];
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

-(void)layoutSubviews{

    //self.titleLable.frame = CGRectMake(20, 10, self.width-40, 20);
    self.titleLable.text =_news.title;
    //self.createdLabel.frame = CGRectMake(self.titleLable.left, self.titleLable.bottom+10, 200, 20);
    self.createdLabel.text = [NSString stringWithFormat:@"%@发表于%@",_news.author,[_news.pubDate intervalSinceNow]];

}
-(void) setsContent:(NewsObject *)news{

    //self.titleLable.frame = CGRectMake(20, 10, self.width-40, 20);
    self.titleLable.text =_news.title;
    //self.createdLabel.frame = CGRectMake(self.titleLable.left, self.titleLable.bottom+10, 200, 20);
    self.createdLabel.text = [NSString stringWithFormat:@"%@发表于%@",_news.author,[_news.pubDate intervalSinceNow]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
