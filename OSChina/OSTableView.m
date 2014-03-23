//
//  OSTableView.m
//  OSChina
//
//  Created by baxiang on 14-3-22.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//

#import "OSTableView.h"

@interface OSTableView ()

@property (nonatomic, strong) EGORefreshTableHeaderView *pullRefreshView;
@property (nonatomic, strong) TableViewLoadMore *loadMoreView;
@property (nonatomic, assign) BOOL isRefresh;
@property (nonatomic, assign) BOOL isLodaMore;
@property (nonatomic, strong) UIView *viewError;

@end
@implementation OSTableView

- (EGORefreshTableHeaderView*)pullRefreshView {
    if (!_pullRefreshView) {
        _pullRefreshView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.bounds.size.height, self.frame.size.width, self.bounds.size.height)];
        _pullRefreshView.delegate = self;
    }
    return _pullRefreshView;
}

- (TableViewLoadMore*)loadMoreView {
    if (!_loadMoreView) {
        _loadMoreView = [[TableViewLoadMore alloc] initWithFrame:CGRectMake(0.f, 0.f, self.bounds.size.width, 44.f)];
        _loadMoreView.delegate = self;
    }
    return _loadMoreView;
}

- (void)setTableMode:(RefreshTableViewMode)tableMode {
    switch (tableMode) {
        case RefreshTableViewModeNormal: {
            [self addSubview:self.pullRefreshView];
            [self.pullRefreshView refreshLastUpdatedDate];
        }
            break;
            
        case RefreshTableViewModeJustLatest: {
            [self addSubview:self.pullRefreshView];
            [self.pullRefreshView refreshLastUpdatedDate];
            self.tableFooterView = nil;
        }
            break;
            
        case RefreshTableViewModeJustLast: {
            [self.pullRefreshView removeFromSuperview];
            self.tableFooterView = self.loadMoreView;
        }
            break;
            
        case RefreshTableViewModeRefreshDisabled: {
            [self.pullRefreshView removeFromSuperview];
            self.tableFooterView = nil;
        }
            break;
            
        default:
            break;
    }
}

- (void)setTableState:(RefreshTableViewState)tableState {
    switch (tableState) {
        case RefreshTableViewStateNormal: {
            [self.viewError removeFromSuperview];
            self.scrollEnabled = YES;
        }
            break;
            
        case RefreshTableViewStateError: {
            [self addSubview:self.viewError];
            self.scrollEnabled = NO;
        }
            break;
            
        default:
            break;
    }
}

- (void)setLoadOverState:(RefreshTableViewLoadedState)loadOverState {
    switch (loadOverState) {
        case RefreshTableViewLoadedStateLatest: {
            //[self doneLoadingTableViewData];
        }
            break;
            
        case RefreshTableViewLoadedStateLastEnable: {
            [self loadMoreOver];
            self.loadMoreView.state = RefreshTableViewStateNormal;
        }
            break;
            
        case RefreshTableViewLoadedStateLastDisable: {
            [self loadMoreOver];
            self.loadMoreView.state = TableViewLoadMoreStateEnd;
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - NSObject


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tableMode = RefreshTableViewModeNormal;
    }
    return self;
}



#pragma mark - Actions Public

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.pullRefreshView egoRefreshScrollViewWillBeginScroll:scrollView];
}

- (void)ScrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.tableMode == RefreshTableViewModeNormal || self.tableMode == RefreshTableViewModeJustLatest) {
        [self.pullRefreshView egoRefreshScrollViewDidScroll:scrollView];
    }
}

- (void)ScrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
   
        
        if(scrollView.contentOffset.y-65.f > ((scrollView.contentSize.height - scrollView.frame.size.height)))
        {
            if (self.loadMoreView.state != TableViewLoadMoreStateEnd) {
                [self loadMore];
            }
        }else{
           [self.pullRefreshView egoRefreshScrollViewDidEndDragging:scrollView];
        }
    
}

- (void)showLoadingLatest {
    [self setContentOffset:CGPointMake(0.f, -65.f) animated:NO];
    [self.pullRefreshView egoRefreshScrollViewDidEndDragging:self];
}

-(BOOL) setAutoRefresh{
    NSUserDefaults *defaulte= [NSUserDefaults standardUserDefaults];
    NSDate *RefreshDate= [defaulte objectForKey:@"RefreshTime"];
    NSTimeInterval currInterval= [[NSDate date] timeIntervalSinceDate:RefreshDate];
    if (currInterval>=0 ||isnan(currInterval)) {
        [self setContentOffset:CGPointMake(0.f, -65.f) animated:NO];
       
        [self.pullRefreshView egoRefreshScrollViewDidEndDragging:self];
        [defaulte setObject:[NSDate date]  forKey:@"RefreshTime"];
        [defaulte synchronize];
        return YES;
    }
    return NO;
}
- (void)showLoadingLast {
    [self loadMore];
}

//- (void)showLoadingOrigin {
//    if (!self.isLoading) {
//        if ([self.delegateRefresh respondsToSelector:@selector(RefreshTableViewWillBeginLoadingOrigin)]) {
//            [self.delegateRefresh RefreshTableViewWillBeginLoadingOrigin];
//        }
//        self.isLoading = YES;
//        self.loadMoreView.state = TableViewLoadMoreStateLoading;
//    }
//}

#pragma mark - Actions Private

- (void)loadMore {
    
        if ([self.delegateRefresh respondsToSelector:@selector(pullUpLoadMore)]) {
            [self.delegateRefresh pullUpLoadMore];
        self.loadMoreView.state = TableViewLoadMoreStateLoading;
    }
}

- (void)loadMoreOver {
    self.isLodaMore = NO;
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
    
        if ([self.delegateRefresh respondsToSelector:@selector(pullDownRefresh)]) {
            _pullRefreshView.Loading = YES;
            [self.delegateRefresh pullDownRefresh];
       }
}

#pragma mark - EGORefreshTableHeaderDelegate Methods

// 开始刷新时回调
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView *)view
{
    [self reloadTableViewDataSource];
}

// 下拉时回调
//- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView *)view
//{
//    return self.isRefresh;
//}

// 请求上次更新时间时调用
- (NSDate *)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView *)view
{
    return [NSDate date];
}


- (void)finishLoadingData{
        self.pullRefreshView.loading = NO;
        [self.pullRefreshView egoRefreshScrollViewDataSourceDidFinishedLoading:self];
   
    
}


-(void)setTableViewFootType:(TableViewFootType)tableViewFootType{
    switch (tableViewFootType) {
        case TableViewFootMoreEnableView:{
            self.tableFooterView = self.loadMoreView;
            self.loadMoreView.state = TableViewLoadMoreStateNormal;
        }
            break;
        case TableViewMoreDisableView:{
            self.tableFooterView = self.loadMoreView;
            self.loadMoreView.state = TableViewLoadMoreStateEnd;
        }
        default:
            break;
    }
}
#pragma mark - MCRefreshTableFooterViewDelegate

- (void)footerViewButtonAction {
    [self loadMore];
}

@end



