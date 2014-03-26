//
//  UserInfoViewController.m
//  OSChina
//
//  Created by baxiang on 14-3-27.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//

#import "UserInfoViewController.h"

@interface UserInfoViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *userTableView;
@property (nonatomic,strong) NSArray *dataSoure;
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
   
    if (_isLoginUser) {
      _userTableView= [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.height-64) style:UITableViewStyleGrouped];
    }else{
       _userTableView= [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.height-64)];
    }
    _userTableView.delegate = self;
    _userTableView.dataSource = self;
    if (_isLoginUser) {
         _dataSoure = @[@"更换头像",@"加入时间",@"所在地区",@"开放平台",@"专长领域"];
    }else{
         _dataSoure = @[@"更换头像",@"加入时间",@"所在地区",@"开放平台",@"专长领域"];
    }
   
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"userCell";
    UITableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell= [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    if (_isLoginUser) {
        switch (indexPath.section) {
            case 0:
                cell.textLabel.text =_dataSoure[indexPath.row];
                break;
            case 1:{
               cell.textLabel.text =_dataSoure[indexPath.row+1];
            }
                break;
        }
    }
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;{
    if (_isLoginUser) {
        return 2;
    }
    return 1;
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_isLoginUser) {
        switch (section) {
            case 0:
                return 1;
                break;
            default:
                return 4;
                break;
        }
    }
    return [_dataSoure count];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
