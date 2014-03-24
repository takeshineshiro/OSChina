//
//  NewsViewController.m
//  OSChina
//
//  Created by baxiang on 14-1-22.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//

#import "NewsViewController.h"
#import "News.h"
#import "SVPullToRefresh.h"
#import "NewsCell.h"
#import "NewsDetailViewController.h"
#import "NewsObject.h"
@interface NewsViewController ()

@property (strong, nonatomic) UIBarButtonItem *leftButton;
@property (strong, nonatomic) UIBarButtonItem *rightButton;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *sidebarStyles;
@property (assign, nonatomic) NSInteger selectedRowCell;
@property (strong, nonatomic) UITableView *newsTableView;
@property (strong, nonatomic) NSMutableArray *newsArray;
@property (assign,   nonatomic) NSInteger currIndex;


@end

@implementation NewsViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
     self.newsArray=[NSMutableArray array];
    self.title = @"开源中国";
    [self initNewsTableView];
    self.currIndex = 0;
   
}


-(void) initNewsTableView{

    self.newsTableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStyleGrouped];
    
    self.newsTableView.delegate = self;
    self.newsTableView.dataSource = self;
    [self.view addSubview:_newsTableView];
    _newsTableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    __weak NewsViewController *weakSelf = self;
    [self.newsTableView addPullToRefreshWithActionHandler:^{
         [weakSelf requestCurrentNewsData:YES isMore:NO PageIndex:0];
    }];
    NSArray *newsArray= [NewsObject allDbObjects];
    if ([newsArray count]>0) {
        [self.newsArray addObjectsFromArray:newsArray];
        [_newsTableView reloadData];
    }
    [self.newsTableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf requestCurrentNewsData:NO isMore:YES PageIndex:weakSelf.currIndex];
    }];
    [self requestCurrentNewsData:NO isMore:NO PageIndex:_currIndex];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
-(void) requestCurrentNewsData:(BOOL)refresh isMore:(BOOL) more PageIndex:(NSInteger) pageIndex{
    __weak NewsViewController *weakSelf = self;
    [[OSAPIClient shareClient] getNewslistWithPageIndex:pageIndex RequestResult:^(id resultDatas, NSError *error) {
       
        if ([resultDatas isKindOfClass:[NSArray class]]) {
        if (pageIndex == 0 ) {
            [self.newsArray removeAllObjects];
        }
            [weakSelf.newsArray addObjectsFromArray:resultDatas];
            [_newsTableView reloadData];
        if (more) {
            _currIndex ++;
            [weakSelf.newsTableView.infiniteScrollingView stopAnimating];
        }
            if (refresh) {
                [weakSelf.newsTableView.pullToRefreshView stopAnimating];
            }
        }
    }];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section ==0) {
        return 0.001;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
   
        return 0.001;
  
}
#pragma mark UITableViewDataSource deleget
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     static NSString * cellName  = @"newsCell";
     NewsCell *cell= [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
         cell =[[NewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    NewsObject *news= _newsArray[indexPath.section];
    cell.news =news;
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;{
      return [_newsArray count];

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    return 1;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;

}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
     NewsDetailViewController *newsDetail= [[NewsDetailViewController alloc] init];
      NewsObject *currNews = [_newsArray objectAtIndexOrNil:indexPath.section];
     newsDetail.newsID = currNews.newsid;
    [self.navigationController pushViewController:newsDetail animated:YES];
}

@end
