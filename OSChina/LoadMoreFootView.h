//
//  LoadMoreFootView.h
//  OSChina
//
//  Created by baxiang on 14-2-28.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadMoreFootView : UIButton

@property (nonatomic, strong) UILabel* textLabel;
@property (nonatomic, strong) UIActivityIndicatorView* activityIndicatorView;
@property (nonatomic, assign) BOOL animating;
@property (nonatomic, copy) NSString* loadingTitle;
@property (nonatomic, copy) NSString* moreTitle;
@property (nonatomic, strong) UIFont* titleFont;

+ (id)defaultMoreButton;

@end

