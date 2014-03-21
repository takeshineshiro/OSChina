//
//  TwetViewController.m
//  OSChina
//
//  Created by baxiang on 14-1-25.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//

#import "TweetViewController.h"
#import "SliderSwitch.h"
#import "Tweet.h"
#import "TweetCell.h"
#import "LoadMoreFootView.h"
@interface TweetViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic)   SliderSwitch *segementControl;
@property (strong, nonatomic)   UITableView *tweetTableView;
@property (strong, nonatomic)   NSMutableArray *latestTweetsArray;
@property (strong, nonatomic)   NSMutableArray *hotTweetsArray;
@property (assign, nonatomic)   NSInteger  currSelectIndex;
@property (assign, nonatomic)   NSInteger  latestPageIndex;
@property (assign, nonatomic)   NSInteger  hotPageIndex;
@property (assign, nonatomic)   NSInteger  latestPageCount;
@property (assign, nonatomic)   NSInteger  hotPageCount;
@property (assign, nonatomic)   BOOL reloading;
@property (strong, nonatomic)   LoadMoreFootView* loadMoreFooterView;
@end

@implementation TweetViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _latestPageIndex = 0;
    _currSelectIndex = 0;
    self.view.backgroundColor = [UIColor whiteColor];
    _latestTweetsArray = [NSMutableArray array];
    _hotTweetsArray = [NSMutableArray array];
    [self initSegementControl];
    [self getTweetDataWithID:0 PageIndex:[_latestTweetsArray count]/20];
}
-(void )initSegementControl{
    
    _segementControl = [[SliderSwitch alloc] initWithFrame:CGRectMake(0, 0, 166, 29)];
    [_segementControl setTitles:[NSArray arrayWithObjects:@"最新动弹",@"热门动弹", nil]];
    [_segementControl addTarget:self action:@selector(segmentedControlIndexChanged:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = _segementControl;
    
    _tweetTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height-60) style:UITableViewStylePlain];
    _tweetTableView.dataSource = self;
    _tweetTableView.delegate = self;
    _tweetTableView.backgroundColor = [UIColor clearColor];
    _tweetTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tweetTableView];
    
}

-(void) initLoadMoreFootView{
    _loadMoreFooterView = [LoadMoreFootView defaultMoreButton];
    [_loadMoreFooterView addTarget:self action:@selector(loadMoreAction)
                  forControlEvents:UIControlEventTouchUpInside];
    _tweetTableView.tableFooterView = _loadMoreFooterView;
}
-(void) getTweetDataWithID:(NSInteger) currID PageIndex:(NSInteger)currPageIndex{
    __weak TweetViewController *weakSelf = self;
    
   [[OSAPIClient shareClient] getTweetListWithID:currID PageIndex:currPageIndex RequestResult:^(id resultDatas,NSInteger tweetCount, NSError *error) {
       if (resultDatas&& [resultDatas isKindOfClass:[NSArray class]]) {
           if (_currSelectIndex == 0) {
               _latestPageCount = tweetCount;
               [_latestTweetsArray addObjectsFromArray:resultDatas];
               [_tweetTableView reloadData];
               [weakSelf initLoadMoreFootView];
           }
           if (_currSelectIndex == 1) {
               _hotPageCount = tweetCount;
               [_hotTweetsArray addObjectsFromArray:resultDatas];
               [_tweetTableView reloadData];
               [weakSelf initLoadMoreFootView];
           }
       }
   }];

}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_currSelectIndex == 0) {
        return [_latestTweetsArray count];
    }else{
        return [_hotTweetsArray count];
    }
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat result = 0;
    if (_currSelectIndex == 0) {
        Tweet *tweet= _latestTweetsArray[indexPath.row];
        result= [TweetCell getCurrTweetCellHright:tweet];
        NSLog(@"%d---%f",indexPath.row,result);
        return result;
    }
    if (_currSelectIndex == 1) {
        Tweet *tweet= _hotTweetsArray[indexPath.row];
        result= [TweetCell getCurrTweetCellHright:tweet];
        return result;
    }
     return 0;
}


-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * newCellIdentifier= @"newCellIdentifier";
    static NSString * hotCellIdentifier= @"hotCellIdentifier";
    if (_currSelectIndex == 0) {
        TweetCell *cell= [tableView dequeueReusableCellWithIdentifier:newCellIdentifier];
        if (!cell) {
        cell= [[TweetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:newCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }

        Tweet *tweet= _latestTweetsArray[indexPath.row];
        cell.tweet = tweet;
        return cell;
    }
    if (_currSelectIndex == 1) {
        TweetCell *cell= [tableView dequeueReusableCellWithIdentifier:hotCellIdentifier];
        if (!cell) {
        cell= [[TweetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hotCellIdentifier];
        //cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        Tweet *tweet= _hotTweetsArray[indexPath.row];
        cell.tweet = tweet;
        return cell;
    }
    return nil;
}
- (void)segmentedControlIndexChanged:(id)sender{
    SliderSwitch * segement  = (SliderSwitch*)sender;
    _currSelectIndex = segement.selectedIndex;
    if (_currSelectIndex ==1 &&![_hotTweetsArray count]) {
        _tweetTableView.tableFooterView = nil;
        [self getTweetDataWithID:-1 PageIndex:[_hotTweetsArray count]/20];
    }
    [_tweetTableView reloadData];

}


#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

//- (void)reloadTableViewDataSource{
//	
//	_reloading = YES;
//	
//}
//
//- (void)doneLoadingTableViewData{
//	
//	_reloading = NO;
//	[_refreshTableHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tweetTableView];
//	
//}
//
//
#pragma mark -
#pragma mark UIScrollViewDelegate Methods


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	if (self.loadMoreFooterView) {
        CGFloat endScrolling = scrollView.contentOffset.y + scrollView.height;
        if (scrollView.contentSize.height > scrollView.height
            && endScrolling >= scrollView.contentSize.height + DEFAULT_DRAG_UP_BOTTOM_OFFSET) {
            [self loadMoreAction];
        }
    }
}



-(void)loadMoreAction{
    if (_currSelectIndex ==0&& [_latestTweetsArray count]<_latestPageCount) {
        [self getTweetDataWithID:0 PageIndex:[_latestTweetsArray count]/20];
        [self.loadMoreFooterView setAnimating:YES];
    }
    if (_currSelectIndex ==1 &&[_latestTweetsArray count]<_hotPageCount) {
      [self getTweetDataWithID:-1 PageIndex:[_hotTweetsArray count]/20];
       [self.loadMoreFooterView setAnimating:YES];
    }else{
        _tweetTableView.tableFooterView = nil;
       // [self.loadMoreFooterView setAnimating:NO];
    }
    
}
#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

//- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
//	
//	[self reloadTableViewDataSource];
//	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
//	
//}
//
//- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
//	
//	return _reloading;
//	
//}
//
//- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
//	
//	return [NSDate date];
//	
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
