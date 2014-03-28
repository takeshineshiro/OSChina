//
//  LeftMenuViewController.m
//  OSChina
//
//  Created by baxiang on 14-1-21.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "SideBarViewController.h"
#import "NewsViewController.h"
#import "BlogViewController.h"
#import "TweetViewController.h"
#import "CommunityViewController.h"
#import "UIView+MotionEffect.h"
#import "BaseNavigationController.h"
@interface LeftMenuViewController()
@property (nonatomic, strong)  NSArray *menuIcons;
@property (nonatomic, strong)  NSArray *menuTitles;
@property (nonatomic, strong) TweetViewController *tweet;
@property (nonatomic, strong) CommunityViewController *community;
@end
@implementation LeftMenuViewController{

    
}



-(void)viewDidLoad{
    
     self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Sidebarbg"]];
     UIImage *bg =[UIImage imageNamed:@"Sidebarbg"];
     UIImageView *bgImage= [[UIImageView alloc ] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
     bgImage.image = bg;
     [self.view addSubview:bgImage];
     [bgImage addCenterMotionEffectsXYWithOffset:20];
     UITableView *MemuTable= [[UITableView alloc] initWithFrame:CGRectMake(30, 80, 200, self.view.frame.size.height)];
     MemuTable.delegate =self;
     MemuTable.dataSource = self;
     MemuTable.separatorStyle = UITableViewCellSeparatorStyleNone;
     MemuTable.opaque = NO;
    MemuTable.scrollEnabled  = NO;
     MemuTable.backgroundView = nil;
     MemuTable.backgroundColor = [UIColor clearColor];
     //[MemuTable addCenterMotionEffectsXYWithOffset:30];
     [self.view addSubview:MemuTable];
     _menuIcons  =@[@"icon_search.png",@"icon_news.png",@"icon_blog.png",@"icon_discuss.png",@"icon_tweet.png",@"icon_software.png"];
     _menuTitles = @[@"搜索",@"资讯",@"博客",@"讨论",@"动弹",@"软件"];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [_menuTitles count];
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  static NSString * tablevieCell = @"menuCell";
  UITableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:tablevieCell];
    if (!cell) {
      cell = [[UITableViewCell alloc] init];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:21];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.highlightedTextColor = [UIColor lightGrayColor];
        cell.selectedBackgroundView = [[UIView alloc] init];
        
    }
    cell.textLabel.text = _menuTitles[indexPath.row];
    [cell.imageView setImage:[UIImage imageNamed:_menuIcons[indexPath.row]]];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView  deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
            
        case 0:{
        }
        break;
        case 1:{
            UINavigationController *contentViewController= [[BaseNavigationController alloc] initWithRootViewController:[[NewsViewController alloc] init]];
            [self.sidebarController setContentViewController:contentViewController];
            [self.sidebarController dismissSidebarViewController];
            break;
        }
        case 2:{
            UINavigationController *contentViewController= [[BaseNavigationController alloc] initWithRootViewController:[[BlogViewController alloc] init]];
            [self.sidebarController setContentViewController:contentViewController];
            [self.sidebarController dismissSidebarViewController];
            break;
        }
       
        case 3:{
            UINavigationController *contentViewController= [[BaseNavigationController alloc] initWithRootViewController:[[CommunityViewController alloc] init]];
            [self.sidebarController setContentViewController:contentViewController];
            [self.sidebarController dismissSidebarViewController];
            break;
        }
        case 4:{
            UINavigationController *contentViewController= [[BaseNavigationController alloc] initWithRootViewController:[[TweetViewController alloc] init]];
            [self.sidebarController setContentViewController:contentViewController];
            [self.sidebarController dismissSidebarViewController];
            break;
        
        }
        default:
            break;
    }

}
@end
