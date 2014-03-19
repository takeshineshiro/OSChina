//
//  PostCell.h
//  OSChina
//
//  Created by baxiang on 14-2-16.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
@interface PostCell : UITableViewCell

@property (nonatomic,strong)  NSString *headIconUrl;
@property (nonatomic, strong) Post *post;
@end
