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
@interface BlogViewController ()

@property (nonatomic, assign) NSInteger currPageIndex;
@property (nonatomic, strong) NSMutableArray *blogArray;
@property (nonatomic, strong) UITableView *blogTableView;
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
    _currPageIndex = 0;
    _blogArray = [NSMutableArray array];
	[self initNewsTableView];
}

-(void) initNewsTableView{
    
    self.blogTableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height-30) style:UITableViewStylePlain];
    self.blogTableView.delegate = self;
    self.blogTableView.dataSource = self;
    [self.view addSubview:_blogTableView];
    [self.blogTableView addPullToRefreshWithActionHandler:^{
        
    }];
    __weak BlogViewController *weakSelf = self;
    [self.blogTableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf requestCurrentNewsData:NO isMore:YES];
    }];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestCurrentNewsData:NO isMore:NO];

}
-(void) requestCurrentNewsData:(BOOL)refresh isMore:(BOOL) more{
    __weak BlogViewController *weakSelf = self;
    [[OSAPIClient shareClient] getBloglistWithPageIndex:_currPageIndex RequestResult:^(id resultDatas, NSError *error) {
        _currPageIndex ++;
        [self.blogArray addObjectsFromArray:resultDatas];
        [_blogTableView reloadData];
        if (more) {
            [weakSelf.blogTableView.infiniteScrollingView stopAnimating];
        }
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
@end
