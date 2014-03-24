//
//  TweetCell.h
//  OSChina
//
//  Created by baxiang on 14-2-27.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
@interface TweetCell : UITableViewCell

@property (nonatomic, strong) Tweet *tweet;
+(CGFloat) getCurrTweetCellHeight:(Tweet*) tweet;
@end
