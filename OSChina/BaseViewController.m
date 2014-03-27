//
//  BaseViewController.m
//  OSChina
//
//  Created by Baxiang on 14-3-19.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *  自定义title
 *
 *  @param title 当前题目
 */
- (void)setTitle:(NSString *)title
{
   //CGSize requestedTitleSize = [title sizeWithFont:titleFont];
    CGSize requestedTitleSize =[title sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:18.0f]}];
    CGFloat titleWidth = MIN(280, requestedTitleSize.width);
    UILabel *navLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, titleWidth, 20)];
    navLabel.backgroundColor = [UIColor clearColor];
    navLabel.textColor = [UIColor whiteColor];
    navLabel.font = [UIFont systemFontOfSize:18.0f];
    navLabel.textAlignment = NSTextAlignmentCenter;
    navLabel.text = title;
    self.navigationItem.titleView = navLabel;

}
/**
 *  自定义返回按钮
 */
-(void) setBackbuttonItemStyle{
    UIButton *backBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame =CGRectMake(0, 0, 60, 44);
    backBtn.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    [backBtn addTarget:self action:@selector(popCurrViewController) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -25, 0, 0)];
    [backBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 0)];
    [backBtn setAdjustsImageWhenHighlighted:NO];
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backBtn  setTitle:@"返回" forState:UIControlStateNormal];
    UIBarButtonItem *backItem= [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
}

-(void)popCurrViewController{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
