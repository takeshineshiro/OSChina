//
//  BlogsViewController.m
//  OSChina
//
//  Created by baxiang on 14-2-12.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//

#import "BlogViewController.h"
#import "BlogCell.h"
#import "SVPullToRefresh.h"
#import "BlogDetailViewController.h"
#import "OSTableView.h"
@interface BlogViewController ()<RefreshTableViewDelegate>

@property (nonatomic, assign) NSInteger currPageIndex;
@property (nonatomic, strong) NSMutableArray *blogArray;
@property (nonatomic, strong) OSTableView *blogTableView;
@end

@implementation BlogViewController

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
    self.title = @"博客";
    
    _blogArray = [NSMutableArray array];
	[self initNewsTableView];
    if (![self.blogTableView setAutoRefresh]) {
        _currPageIndex = 0;
        [self requestDatareIsFresh:YES isMore:NO currPageIndex:_currPageIndex];
    }
}

-(void) initNewsTableView{
    
    self.blogTableView =[[OSTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height-60) ];
    self.blogTableView.delegate = self;
    self.blogTableView.dataSource = self;
    self.blogTableView.delegateRefresh = self;
    [self.view addSubview:_blogTableView];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    

}
-(void) requestDatareIsFresh:(BOOL)refresh isMore:(BOOL) more currPageIndex:(NSInteger)pageIndex{
    __weak BlogViewController *weakSelf = self;
    [[OSAPIClient shareClient] getBloglistWithPageIndex:pageIndex RequestResult:^(id resultDatas, NSError *error) {
        if (refresh) {
             [self.blogArray removeAllObjects];
             [weakSelf.blogTableView finishLoadingData];
        }
        _currPageIndex ++;
        [weakSelf.blogArray addObjectsFromArray:resultDatas];
        [weakSelf.blogTableView reloadData];
        [weakSelf.blogTableView setTableViewFootType:TableViewFootMoreEnableView];
    }];
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource deleget
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellName  = @"newsCell";
    BlogCell *cell= [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell =[[BlogCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        
    }
    Blog *blog= [_blogArray objectAtIndexOrNil:indexPath.row];
    cell.blog =blog;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_blogArray count];
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
    
}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([_blogArray objectAtIndexOrNil:indexPath.row]) {
       BlogDetailViewController *blogDetail = [[BlogDetailViewController alloc] init];
        Blog * currBlog = [_blogArray objectAtIndexOrNil:indexPath.row];
        blogDetail.blogID = currBlog.blogID;
        [self.navigationController pushViewController:blogDetail animated:YES];
    }
    
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.blogTableView scrollViewWillBeginDragging:scrollView];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.blogTableView ScrollViewDidScroll:scrollView];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.blogTableView ScrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}

-(void)pullDownRefresh{
    _currPageIndex = 0;
   [self requestDatareIsFresh:YES isMore:NO currPageIndex:_currPageIndex];
}

-(void)pullUpLoadMore{
  [self requestDatareIsFresh:NO isMore:YES currPageIndex:_currPageIndex];
}
- (void)RefreshTableViewWillBeginLoadingLatest{
    
}

- (void)RefreshTableViewWillBeginLoadingLast{
}
@end
