//
//  BaseNavigationController.m
//  OSChina
//
//  Created by baxiang on 14-2-14.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//

#import "BaseMainViewController.h"
#import "SideBarViewController.h"
@interface BaseMainViewController ()<UIGestureRecognizerDelegate>

@property (strong, nonatomic) UIBarButtonItem *leftButton;
@property (strong, nonatomic) UIBarButtonItem *rightButton;
@property (nonatomic, strong) UITapGestureRecognizer *tapRecognizer;
@property (nonatomic, strong) UIPanGestureRecognizer *panRecognizer;

@end

@implementation BaseMainViewController

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
    
    self.view.backgroundColor = [UIColor whiteColor];
    if (IOS_LEAST_7)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.navigationController.navigationBar.translucent = NO;
   
    UIImage *image = [UIImage imageNamed:@"Navibarbg"];
    [[UINavigationBar appearance] setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.exclusiveTouch = YES;
    [button setImage:[UIImage imageNamed:@"icon_menu"] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 50, 40);
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    [button addTarget:self action:@selector(leftButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* backItem=[[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem=backItem;


    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    settingBtn.exclusiveTouch = YES;
    [settingBtn setImage:[UIImage imageNamed:@"icon_myinfo"] forState:UIControlStateNormal];
    settingBtn.frame = CGRectMake(0, 0, 50, 40);
    [settingBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
    [settingBtn addTarget:self action:@selector(rightButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* settingItem=[[UIBarButtonItem alloc] initWithCustomView:settingBtn];
    self.navigationItem.rightBarButtonItem=settingItem;
    
    self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRecognized:)];
    self.tapRecognizer.delegate = self;
    self.panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panRecognized:)];
    [self.view addGestureRecognizer:self.tapRecognizer];
    [self.view addGestureRecognizer:self.panRecognizer];
}
- (void)setTitle:(NSString *)title
{
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
- (void)tapRecognized:(UITapGestureRecognizer*)recognizer
{
    if (self.sidebarController.currentSide == LeftSide) {
        [self leftButtonClicked];
    }
    if (self.sidebarController.currentSide == RightSide) {
        [self rightButtonClicked];
    }
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]&&self.sidebarController.currentSide == CenterMain) {
        return NO;
    }
    return YES;
}
- (void)panRecognized:(UIPanGestureRecognizer*)recognizer
{
    
    CGPoint velocity = [recognizer velocityInView:recognizer.view];
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan: {
            break;
        }
        case UIGestureRecognizerStateChanged: {
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled: {
            if (velocity.x>0) {
                if (self.sidebarController.currentSide ==CenterMain) {
                    [self leftButtonClicked];
                }else{
                    [self rightButtonClicked];
                }
            }
            if (velocity.x<0) {
                if (self.sidebarController.currentSide ==CenterMain) {
                    [self rightButtonClicked];
                }else{
                    [self leftButtonClicked];
                }
            }
            break;
        }
        default:
            break;
    }
}
- (void)leftButtonClicked
{
    if(self.sidebarController.sidebarIsPresenting)
    {
        [self.sidebarController dismissSidebarViewController];
    }
    else
    {
        [self.sidebarController presentLeftSidebarViewController];
    }
}

- (void)rightButtonClicked
{
    if(self.sidebarController.sidebarIsPresenting)
    {
        [self.sidebarController dismissSidebarViewController];
    }
    else
    {
        [self.sidebarController presentRightSidebarViewController];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
