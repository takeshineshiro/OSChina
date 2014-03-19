//
//  BlogDetailViewController.m
//  OSChina
//
//  Created by baxiang on 14-2-14.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//

#import "BlogDetailViewController.h"
#import "BlogDetail.h"
@interface BlogDetailViewController ()
@property (nonatomic, strong) UIWebView *blogDetailWebView;
@property (nonatomic, strong) BlogDetail *currBlog;
@end

@implementation BlogDetailViewController

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
    _blogDetailWebView  = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height-60)];
    [self.view addSubview:_blogDetailWebView];
    __weak BlogDetailViewController *weakSelf = self;
    [[OSAPIClient shareClient] getblogDetailWithBlogID:_blogID RequestResult:^(id resultDatas, NSError *error) {
        if (resultDatas &&[resultDatas isKindOfClass:[NSDictionary class]]) {
            weakSelf.currBlog = [[BlogDetail alloc] initWithDictionary:resultDatas];
            [self loadHtmlDataHandle];
        }
    }];
    
}

-(void) loadHtmlDataHandle{
    NSString * HTML_Style  = @"<style>#oschina_title {color: #000000; margin-bottom: 6px; font-weight:bold;}#oschina_title img{vertical-align:middle;margin-right:6px;}#oschina_title a{color:#0D6DA8;}#oschina_outline {color: #707070; font-size: 12px;}#oschina_outline a{color:#0D6DA8;}#oschina_software{color:#808080;font-size:12px}#oschina_body img {max-width: 300px;align: center;padding:5px;}#oschina_body {color: #666666; font-size:16px;max-width:300px;line-height:1.0;background-color: #FFFFFF; } #oschina_body span{line-height:0.5;}  #oschina_body table{max-width:300px;}#oschina_body pre { font-size:9pt;font-family:Courier New,Arial;border:1px solid #ddd;border-left:5px solid #6CE26C;background:#f6f6f6;padding:5px;}</style>";
    NSString *html = [NSString stringWithFormat:@"<body style='background-color:#FFFFFF'>%@<div id='oschina_title'>%@</div><div id='oschina_outline'>%@</div><hr/><div id='oschina_body'>%@</div>%@%@%@</body>",HTML_Style, _currBlog.BlogTitle,@"", _currBlog.BlogBody,@"",@"",@""];
    [_blogDetailWebView loadHTMLString:html baseURL:nil];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
