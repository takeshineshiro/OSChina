//
//  CommunityViewController.m
//  OSChina
//
//  Created by baxiang on 14-2-16.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//

#import "CommunityViewController.h"
#import "HMSegmentedControl.h"
#import "Post.h"
#import "PostCell.h"
typedef NS_ENUM(NSInteger, CurrSelectedCommunitType) {
      AskingSelectedTableView    = 1,
      ShareSelectedTableView     = 2,
      ITSelectedTableView        = 3,
      CareerSelectedTableView    = 4,
      SuggestSelectedTableView   = 5
};
@interface CommunityViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UIScrollView *coummutityScrollView;
@property (nonatomic, strong) UITableView *centerTableView;

@property (nonatomic, strong) NSMutableArray *askArrays;
@property (nonatomic, strong) NSMutableArray *ShareArrays;
@property (nonatomic, strong) NSMutableArray *ITArrays;
@property (nonatomic, strong) NSMutableArray *CareerArrays;
@property (nonatomic, strong) NSMutableArray *SuggestArrays;
@property (nonatomic, assign) CurrSelectedCommunitType  currCommunityType;
@property (nonatomic, strong) HMSegmentedControl *segmentedControl;
@end

@implementation CommunityViewController

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
    self.title = @"开源社区";
    _currCommunityType = AskingSelectedTableView;

	self.segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"问答", @"分享", @"大杂烩",@"职业",@"站务"]];
    self.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    self.segmentedControl.scrollEnabled = YES;
    self.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    [self.segmentedControl setFrame:CGRectMake(0, 0, 320, 35)];
    [self.segmentedControl setFont:[UIFont boldSystemFontOfSize:15]];
    [self.segmentedControl setBackgroundColor:RGB(238, 238, 238)];
    [self.segmentedControl setSelectionIndicatorHeight:2.0f];
    [self.segmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    self.segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.segmentedControl];
    
    self.coummutityScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _segmentedControl.bottom, 320, self.view.height-self.segmentedControl.bottom)];
    self.coummutityScrollView.delegate = self;
    [self.coummutityScrollView setPagingEnabled:YES];
    [self.coummutityScrollView setShowsHorizontalScrollIndicator:NO];
    [self.coummutityScrollView setContentSize:CGSizeMake(320*5, self.view.height-_segmentedControl.bottom)];
    [self.coummutityScrollView setDelegate:self];
    [self.view addSubview:self.coummutityScrollView];
    
    self.centerTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.height)];
    self.centerTableView.dataSource = self;
    self.centerTableView.delegate = self;
    [self.coummutityScrollView addSubview:_centerTableView];
    _askArrays = [NSMutableArray array];
    _ShareArrays = [NSMutableArray array];
    _ITArrays = [NSMutableArray array];
    _SuggestArrays = [NSMutableArray array];
    _CareerArrays = [NSMutableArray array];
    [self currDataRefresh:_currCommunityType PageIndex:0];
}

-(void) segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    _currCommunityType = segmentedControl.selectedSegmentIndex+1;
    [self swichCurrentType];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([scrollView isKindOfClass:[UITableView class]]) {
        
    }else{
        CGFloat pageWidth = scrollView.frame.size.width;
        int pageIndex = floor((scrollView.contentOffset.x - pageWidth/2)/pageWidth) + 1;
        
        _currCommunityType =pageIndex+1;
        [_segmentedControl setSelectedSegmentIndex:pageIndex animated:YES];
        self.centerTableView.frame = CGRectMake(320*pageIndex, 0, 320, self.view.height);
        [self swichCurrentType];
    }
}

-(void) swichCurrentType{
    switch (_currCommunityType) {
        case AskingSelectedTableView:{
            if (![_askArrays count]) {
                [self currDataRefresh:_currCommunityType PageIndex:0];
            }else{
                [_centerTableView reloadData];
            }
            break;
        }
        case ShareSelectedTableView:{
            if (![_ShareArrays count]) {
                [self currDataRefresh:_currCommunityType PageIndex:0];
            }else{
                [_centerTableView reloadData];
            }
            break;
        }
        case ITSelectedTableView:{
            if (![_ITArrays count]) {
                [self currDataRefresh:_currCommunityType PageIndex:0];
            }else{
                [_centerTableView reloadData];
            }
            break;
        }
        case CareerSelectedTableView:{
            if (![_CareerArrays count]) {
                [self currDataRefresh:_currCommunityType PageIndex:0];
            }else{
                [_centerTableView reloadData];
            }
            break;
        }
        case SuggestSelectedTableView:{
            if (![_SuggestArrays count]) {
                [self currDataRefresh:_currCommunityType PageIndex:0];
            }else{
                [_centerTableView reloadData];
            }
            break;
        }
    }
}
-(void) currDataRefresh:(NSInteger) type PageIndex:(NSInteger) pageIndex{
    [[OSAPIClient shareClient] getCommunityListWithType:type PageIndex:pageIndex RequestResult:^(id resultDatas, NSError *error) {
        if (!resultDatas && ![resultDatas isKindOfClass:[NSArray class]]) {
            return ;
        }
        switch (_currCommunityType) {
            case AskingSelectedTableView:{
                [_askArrays addObjectsFromArray:resultDatas];
                break;
            }
            case ShareSelectedTableView:{
                [_ShareArrays addObjectsFromArray:resultDatas];
               break;
            }
            case ITSelectedTableView:{
                [_ITArrays addObjectsFromArray:resultDatas];
                break;
            }
            case CareerSelectedTableView:{
                [_CareerArrays addObjectsFromArray:resultDatas];
                break;
            }
            case SuggestSelectedTableView:{
                [_SuggestArrays addObjectsFromArray:resultDatas];
                break;
            }
        }
        [_centerTableView reloadData];
    }];
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (_currCommunityType) {
        case AskingSelectedTableView:{
            return [_askArrays count];
            break;
        }
        case ShareSelectedTableView:{
            return [_ShareArrays count];
            break;
        }
        case ITSelectedTableView:{
            return [_ITArrays count];
            break;
        }
        case CareerSelectedTableView:{
            return [_CareerArrays count];
            break;
        }
        case SuggestSelectedTableView:{
            return [_SuggestArrays count];
            break;
        }
    }
    return 0;
}
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
            static NSString *cellIdentifier = @"askCell";
            PostCell *cell= [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (!cell) {
                cell = [[PostCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
    switch (_currCommunityType) {
        case AskingSelectedTableView:{
             Post *post= [self.askArrays objectAtIndexOrNil:indexPath.row];
            cell.post = post;
            break;
        }
        case ShareSelectedTableView:{
            Post *post= [self.ShareArrays objectAtIndexOrNil:indexPath.row];
            cell.post = post;
            break;
        }
        case ITSelectedTableView:{
            Post *post= [self.ITArrays objectAtIndexOrNil:indexPath.row];
            cell.post = post;
            break;
        }
        case CareerSelectedTableView:{
            Post *post= [self.CareerArrays objectAtIndexOrNil:indexPath.row];
            cell.post = post;
            break;
        }
        case SuggestSelectedTableView:{
            Post *post= [self.SuggestArrays objectAtIndexOrNil:indexPath.row];
            cell.post = post;
            break;
        }
    }
            return cell;
    
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
