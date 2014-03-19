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

    self.newsTableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height-30) style:UITableViewStylePlain];
    
    self.newsTableView.delegate = self;
    self.newsTableView.dataSource = self;
    [self.view addSubview:_newsTableView];
    [self.newsTableView addPullToRefreshWithActionHandler:^{
        
    }];
    NSArray *newsArray= [NewsObject allDbObjects];
    if ([newsArray count]>0) {
        [self.newsArray addObjectsFromArray:newsArray];
        [_newsTableView reloadData];
    }
    __weak NewsViewController *weakSelf = self;
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
        NSArray *currData = resultDatas;
        if (refresh) {

        }
        _currIndex ++;
        if (pageIndex == 0 &&[self.newsArray count]) {
            [self.newsArray removeAllObjects];
        }
        [self.newsArray addObjectsFromArray:resultDatas];
        [_newsTableView reloadData];
        if (more) {
            [weakSelf.newsTableView.infiniteScrollingView stopAnimating];
        }
    }];
    
}
#pragma mark UITableViewDataSource deleget
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     static NSString * cellName  = @"newsCell";
     NewsCell *cell= [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
         cell =[[NewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        
    }
    NewsObject *news= _newsArray[indexPath.row];
    cell.news =news;
    //[cell setsContent:news];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    return [_newsArray count];
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 69;

}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
     NewsDetailViewController *newsDetail= [[NewsDetailViewController alloc] init];
      NewsObject *currNews = [_newsArray objectAtIndexOrNil:indexPath.row];
     newsDetail.newsID = currNews.newsid;
    [self.navigationController pushViewController:newsDetail animated:YES];
}

@end
