//
//  UserInfoViewController.m
//  OSChina
//
//  Created by baxiang on 14-3-27.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//

#import "UserInfoViewController.h"
#import "LoginUser.h"
#import "UIImageView+WebCache.h"
#import "RightSettingViewController.h"
@interface UserInfoViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *userTableView;
@property (nonatomic,strong) NSArray *dataSoure;
@property (nonatomic,strong)  LoginUser *user;
@end

@implementation UserInfoViewController

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
    [self setBackbuttonItem:@selector(popViewController)];

    _userTableView= [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.height-64) style:UITableViewStyleGrouped];
    _userTableView.delegate = self;
    _userTableView.dataSource = self;
     _user = [[LoginUser alloc] init];
    _dataSoure = @[@"更换头像",@"加入时间",@"所在地区",@"开放平台",@"专长领域"];
    [self.view addSubview:_userTableView];
    [[OSAPIClient shareClient] fetchCurrUserInfo:^(id resultDatas, NSError *error) {
         _user= resultDatas;
        [_userTableView reloadData];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self saveUserInfo:_user];
        }) ;
        
        
    }];
    

}


-(void) saveUserInfo:(LoginUser*) user{
    
    LKDBHelper* globalHelper = [LKDBHelper getUsingLKDBHelper];
    [LKDBHelper clearTableData:[LoginUser class] ];
    [globalHelper createTableWithModelClass:[LoginUser class]];
    
    LoginUser *userInfo= [[LoginUser alloc] init];
    userInfo.name = user.name;
    userInfo.portrait = user.portrait;
    userInfo.jointime= user.jointime;
    userInfo.fromDistrict =  user.fromDistrict;
    userInfo.gender = user.gender;
    userInfo.devplatform = user.devplatform;
    userInfo.expertise = user.expertise;
    userInfo.favoritecount = user.favoritecount;
    userInfo.fanscount = user.fanscount;
    userInfo.followerscount = user.followerscount;
    [globalHelper insertToDB:user];
    NSMutableArray* arraySync = [LoginUser searchWithWhere:nil orderBy:nil offset:0 count:100];
    [arraySync enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSLog(@"%@",[obj printAllPropertys]);
    }];
    
}
-(void)popViewController{
    NSArray *vcArray= self.navigationController.viewControllers;
    [vcArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[RightSettingViewController class]]) {
            RightSettingViewController *right = obj;
            [self.navigationController popToViewController:right animated:NO];
        }
    }];
   
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"userCell";
    UITableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell= [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    if (indexPath.section ==0 ) {
        cell.textLabel.text =_dataSoure[indexPath.row];
        UIImageView *headIcon= [[UIImageView alloc] initWithFrame:CGRectMake(210, 10, 80, 80)];
        [headIcon setImageWithURL:[NSURL URLWithString:_user.portrait] placeholderImage:[UIImage imageNamed:@"icon_user_portraits"]];
        headIcon.layer.masksToBounds = YES;
        headIcon.layer.cornerRadius = 40.0f;
        [cell.contentView addSubview:headIcon];
        return cell;

    }
    if (indexPath.section ==1) {
        cell.textLabel.text =_dataSoure[indexPath.row+1];
        UILabel *content= [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 100, 20)];
        cell.accessoryView = content;
        content.backgroundColor = [UIColor clearColor];
        content.textColor = [UIColor blackColor];
        switch (indexPath.row) {
            case 0:{
                content.text = [_user.jointime substringToIndex:10];
            }
                break;
            case 1:{
                content.text = _user.fromDistrict;
            }
                 break;
            case 2:{
                if ([_user.devplatform isEqualToString:@"<无>"]) {
                    content.text = @"暂无";
                }else{
                    content.text =_user.devplatform;
                }
            }
                break;
            case 3:{
                if ([_user.expertise isEqualToString:@"<无>"]) {
                    content.text = @"暂无";
                }else{
                    content.text =_user.expertise;
                }
            }
        }
       
        return cell;
    }
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;{
    
        return 2;
    
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section ==0) {
        return 1;
    }
    if (section == 1) {
        return 4;
    }
    return 0;
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
        return 100;
    }
    return 50;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
