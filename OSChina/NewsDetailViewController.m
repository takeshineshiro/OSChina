//
//  NewsDetailViewController.m
//  OSChina
//
//  Created by baxiang on 14-2-13.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//

#import "NewsDetailViewController.h"
#import "NewsDetail.h"
#import "BaseNavigationController.h"
#import <CoreText/CoreText.h>
#import "DTCoreText.h"
@interface NewsDetailViewController ()<UIGestureRecognizerDelegate,DTAttributedTextContentViewDelegate,DTLazyImageViewDelegate>
@property (nonatomic, strong) UIWebView *newsDetailWebView;
@property (nonatomic, strong) NewsDetail *currNews;

@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation NewsDetailViewController{

   DTAttributedTextView *_textView;
}

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
    //self.title = @"资讯详情";
    [self setTitle:@"咨询详情"];
    [self setBackbuttonItemStyle];
    
    
    _textView = [[DTAttributedTextView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.width, self.view.height)];
	
	// we draw images and links via subviews provided by delegate methods
	_textView.shouldDrawImages = NO;
	_textView.shouldDrawLinks = NO;
	_textView.textDelegate = self; // delegate for custom sub views
	
	// gesture for testing cursor positions
    //	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    //	[_textView addGestureRecognizer:tap];
	
	// set an inset. Since the bottom is below a toolbar inset by 44px
	[_textView setScrollIndicatorInsets:UIEdgeInsetsMake(0, 0, 44, 0)];
	_textView.contentInset = UIEdgeInsetsMake(10, 10, 54, 10);
    
	_textView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	[self.view addSubview:_textView];
//     _newsDetailWebView  = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height-60)];
//    [self.view addSubview:_newsDetailWebView];
//    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self
//                                                                        action:@selector(paningGestureHandle:)];
//    //[recognizer delaysTouchesBegan];
//    recognizer.delegate = self;
//    [self.view addGestureRecognizer:recognizer];

}




- (NSAttributedString *)_attributedStringForSnippetUsingiOS6Attributes:(NSString *)html
{
	// Load HTML data
	
	NSData *data = [html dataUsingEncoding:NSUTF8StringEncoding];
	
	// Create attributed string from HTML
	CGSize maxImageSize = CGSizeMake(self.view.bounds.size.width - 20.0, self.view.bounds.size.height - 20.0);
	
	// example for setting a willFlushCallback, that gets called before elements are written to the generated attributed string
	void (^callBackBlock)(DTHTMLElement *element) = ^(DTHTMLElement *element) {
		
		// the block is being called for an entire paragraph, so we check the individual elements
		
		for (DTHTMLElement *oneChildElement in element.childNodes)
		{
			// if an element is larger than twice the font size put it in it's own block
			if (oneChildElement.displayStyle == DTHTMLElementDisplayStyleInline && oneChildElement.textAttachment.displaySize.height > 2.0 * oneChildElement.fontDescriptor.pointSize)
			{
				oneChildElement.displayStyle = DTHTMLElementDisplayStyleBlock;
				oneChildElement.paragraphStyle.minimumLineHeight = element.textAttachment.displaySize.height;
				oneChildElement.paragraphStyle.maximumLineHeight = element.textAttachment.displaySize.height;
			}
		}
	};
	
	NSMutableDictionary *options = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:1.0], NSTextSizeMultiplierDocumentOption, [NSValue valueWithCGSize:maxImageSize], DTMaxImageSize,
                                    @"Times New Roman", DTDefaultFontFamily,  @"purple", DTDefaultLinkColor, @"red", DTDefaultLinkHighlightColor, callBackBlock, DTWillFlushBlockCallBack, nil];
	
//	if (useiOS6Attributes)
//	{
//		[options setObject:[NSNumber numberWithBool:YES] forKey:DTUseiOS6Attributes];
//	}
	
	//[options setObject:[NSURL fileURLWithPath:readmePath] forKey:NSBaseURLDocumentOption];
	
	NSAttributedString *string = [[NSAttributedString alloc] initWithHTMLData:data options:options documentAttributes:NULL];
	
	return string;
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
     return YES;
}
-(void) paningGestureHandle:(UIPanGestureRecognizer *)recoginzer{
    
    
    if ([self.navigationController isKindOfClass:[BaseNavigationController class]]) {
        BaseNavigationController *base = (BaseNavigationController*)self.navigationController;
        [base paningGestureReceive:recoginzer];
    }


}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    __weak NewsDetailViewController *weakSelf = self;
    [[OSAPIClient shareClient] getnewsDetailWithNewID:_newsID RequestResult:^(id resultDatas, NSError *error) {
        if (resultDatas &&[resultDatas isKindOfClass:[NSDictionary class]]) {
            weakSelf.currNews = [[NewsDetail alloc] initWithDictionary:resultDatas];
            [self loadHtmlDataHandle];
           // NSString *content= weakSelf.currNews.newsBody;
           //
        }
    }];
}


-(void) loadHtmlDataHandle{
    NSString * HTML_Style  = @"<style>#oschina_title {color: #000000; margin-bottom: 6px; font-weight:bold;}#oschina_title img{vertical-align:middle;margin-right:6px;}#oschina_title a{color:#0D6DA8;}#oschina_outline {color: #707070; font-size: 12px;}#oschina_outline a{color:#0D6DA8;}#oschina_software{color:#808080;font-size:12px}#oschina_body img {max-width: 300px;align: center;padding:5px;}#oschina_body {color: #666666; font-size:16px;max-width:300px;line-height:1.0;background-color: #FFFFFF; } #oschina_body span{line-height:0.5;}  #oschina_body table{max-width:300px;}#oschina_body pre { font-size:9pt;font-family:Courier New,Arial;border:1px solid #ddd;border-left:5px solid #6CE26C;background:#f6f6f6;padding:5px;}</style>";
       // NSString *html = [NSString stringWithFormat:@"<body style='background-color:#FFFFFF'>%@<div id='oschina_title'>%@</div><div id='oschina_outline'>%@</div><hr/><div id='oschina_body'>%@</div>%@%@%@</body>",HTML_Style, _currNews.newsTitle,@"", _currNews.newsBody,@"",@"",@""];
    //[_newsDetailWebView loadHTMLString:html baseURL:nil];
    
    CGRect bounds = self.view.bounds;
	_textView.frame = bounds;
    
	// Display string
	_textView.shouldDrawLinks = NO; // we draw them in DTLinkButton
	_textView.attributedString = [self _attributedStringForSnippetUsingiOS6Attributes:_currNews.newsBody];
   

}
- (NSArray *)getImagesFromHTML:(NSString *)html
{
    NSMutableArray *images = [[NSMutableArray alloc] init];
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern: @"src=\"(.*?)\""//@"<img[^>]*>"
                                                                           options: NSRegularExpressionCaseInsensitive
                                                                             error: nil];
    
    for (NSTextCheckingResult *result in [regex matchesInString: html
                                                        options: 0
                                                          range: NSMakeRange(0, [html length])]) {
        
        NSString *match = [regex replacementStringForResult: result
                                                   inString: html
                                                     offset: 0
                                                   template: @"$0"];
        
        match = [match stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        match = [match stringByReplacingOccurrencesOfString:@"src=" withString:@""];
        
        if (![match isEqualToString:@""]) {
            [images addObject: match];
        }
    }
    return images;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
