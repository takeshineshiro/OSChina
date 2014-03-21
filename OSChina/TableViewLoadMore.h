//
//  TableViewLoadMore.h
//  OSChina
//
//  Created by baxiang on 14-3-22.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//

#import <UIKit/UIKit.h>



//load more view State
typedef enum {
    TableViewLoadMoreStateNormal = 0,//load more normal
    TableViewLoadMoreStateLoading,//loading
    TableViewLoadMoreStateEnd,//load more all
}TableViewLoadMoreState;

@protocol TableViewLoadMoreDelegate <NSObject>

- (void)footerViewButtonAction;

@end


@interface TableViewLoadMore : UIView

@property (nonatomic, weak) id <TableViewLoadMoreDelegate> delegate;
@property (nonatomic, assign) TableViewLoadMoreState state;
@property (nonatomic, strong) UIButton *buttonLoadMore;
@property (nonatomic, strong) UILabel *labelLoadEnd;

@end

