//
//  OSTableView.h
//  OSChina
// 自定义刷新和更多的tableview
//  Created by baxiang on 14-3-22.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "EGORefreshTableHeaderView.h"
#import "TableViewLoadMore.h"


//tableview Mode
typedef enum {
    RefreshTableViewModeNormal = 0,//load latest, load last
    RefreshTableViewModeJustLatest,//just load latest
    RefreshTableViewModeJustLast,//just load last
    RefreshTableViewModeRefreshDisabled,
}RefreshTableViewMode;

//table State
typedef enum {
    RefreshTableViewStateNormal = 0,//get origin data success
    RefreshTableViewStateError,//get origin data fail
}RefreshTableViewState;

//load state
typedef enum {
    RefreshTableViewLoadedStateLatest = 0,
    RefreshTableViewLoadedStateLastEnable,
    RefreshTableViewLoadedStateLastDisable,
}RefreshTableViewLoadedState;

@protocol RefreshTableViewDelegate <NSObject>

@optional

- (void)RefreshTableViewWillBeginLoadingOrigin;

- (void)RefreshTableViewWillBeginLoadingLatest;

- (void)RefreshTableViewWillBeginLoadingLast;

- (UIView*)RefreshTableViewErrorView;

@end

@interface OSTableView : UITableView <EGORefreshTableHeaderDelegate,
TableViewLoadMoreDelegate, UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) id <RefreshTableViewDelegate> delegateRefresh;
@property (nonatomic, assign) RefreshTableViewState tableState;
@property (nonatomic, assign) RefreshTableViewMode tableMode;
@property (nonatomic, assign) RefreshTableViewLoadedState loadOverState;

- (void)ScrollViewDidScroll:(UIScrollView *)scrollView;

- (void)ScrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;

- (void)showLoadingLatest;

- (void)showLoadingLast;

- (void)showLoadingOrigin;

@end


