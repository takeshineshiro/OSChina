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
#import <MediaPlayer/MediaPlayer.h>
@interface NewsDetailViewController ()<UIGestureRecognizerDelegate,DTAttributedTextContentViewDelegate,DTLazyImageViewDelegate>
@property (nonatomic, strong) UIWebView *newsDetailWebView;
@property (nonatomic, strong) NewsDetail *currNews;
@property (nonatomic, strong) NSMutableSet *mediaPlayers;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) dispatch_queue_t currLoadQueue;
@end

@implementation NewsDetailViewController{

   DTAttributedTextView *_textView;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"资讯详情"];
    [self setBackbuttonItemStyle];
    self.currLoadQueue = dispatch_queue_create("com.oschina.newsDatail", DISPATCH_QUEUE_SERIAL);
    _textView = [[DTAttributedTextView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.width, self.view.height-44)];
	_textView.shouldDrawImages = NO;
	_textView.shouldDrawLinks = NO;
	_textView.textDelegate = self;
	_textView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	[self.view addSubview:_textView];
    __weak NewsDetailViewController *weakSelf = self;
    [[OSAPIClient shareClient] getnewsDetailWithNewID:_newsID RequestResult:^(id resultDatas, NSError *error) {
        if (resultDatas &&[resultDatas isKindOfClass:[NSDictionary class]]) {
            NewsDetail* currNews = [[NewsDetail alloc] initWithDictionary:resultDatas];
             [self loadHtmlDataHandle:currNews.newsBody];
        }
    }];
    
}




- (NSAttributedString *)_attributedStringForSnippetUsingiOS6Attributes:(NSString *)html
{
	
	NSData *data = [html dataUsingEncoding:NSUTF8StringEncoding];
    CGSize maxImageSize = CGSizeMake(self.view.bounds.size.width - 20.0, self.view.bounds.size.height - 20.0);
	
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
	
	NSAttributedString *string = [[NSAttributedString alloc] initWithHTMLData:data options:options documentAttributes:NULL];
	
	return string;
}
#pragma mark - DTLazyImageViewDelegate
- (void)lazyImageView:(DTLazyImageView *)lazyImageView didChangeImageSize:(CGSize)size {
	NSURL *url = lazyImageView.url;
	CGSize imageSize = size;
	
	NSPredicate *pred = [NSPredicate predicateWithFormat:@"contentURL == %@", url];
	
	BOOL didUpdate = NO;
	
	for (DTTextAttachment *oneAttachment in [_textView.attributedTextContentView.layoutFrame textAttachmentsWithPredicate:pred])
	{
		// update attachments that have no original size, that also sets the display size
		if (CGSizeEqualToSize(oneAttachment.originalSize, CGSizeZero))
		{
			oneAttachment.originalSize = imageSize;
			
			didUpdate = YES;
		}
	}
	
	if (didUpdate)
	{
		// layout might have changed due to image sizes
		[_textView relayoutText];
	}
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
    
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
   
}

-(void) loadHtmlDataHandle:(NSString *) newsContent{
    CGRect bounds = self.view.bounds;
	_textView.frame = bounds;
	_textView.shouldDrawLinks = NO;
    dispatch_async(_currLoadQueue, ^{
      NSAttributedString *attrHtml=  [self _attributedStringForSnippetUsingiOS6Attributes:newsContent];
      dispatch_sync(dispatch_get_main_queue(), ^{
          _textView.attributedString = attrHtml;
      });
    });
	
   
}

- (UIView *)attributedTextContentView:(DTAttributedTextContentView *)attributedTextContentView viewForAttributedString:(NSAttributedString *)string frame:(CGRect)frame
{
	NSDictionary *attributes = [string attributesAtIndex:0 effectiveRange:NULL];
	
	NSURL *URL = [attributes objectForKey:DTLinkAttribute];
	NSString *identifier = [attributes objectForKey:DTGUIDAttribute];
	
	
	DTLinkButton *button = [[DTLinkButton alloc] initWithFrame:frame];
	button.URL = URL;
	button.minimumHitSize = CGSizeMake(25, 25); // adjusts it's bounds so that button is always large enough
	button.GUID = identifier;
	
	// get image with normal link text
	UIImage *normalImage = [attributedTextContentView contentImageWithBounds:frame options:DTCoreTextLayoutFrameDrawingDefault];
	[button setImage:normalImage forState:UIControlStateNormal];
	
	// get image for highlighted link text
	UIImage *highlightImage = [attributedTextContentView contentImageWithBounds:frame options:DTCoreTextLayoutFrameDrawingDrawLinksHighlighted];
	[button setImage:highlightImage forState:UIControlStateHighlighted];
	
	// use normal push action for opening URL
	[button addTarget:self action:@selector(linkPushed:) forControlEvents:UIControlEventTouchUpInside];
	
	// demonstrate combination with long press
	UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(linkLongPressed:)];
	[button addGestureRecognizer:longPress];
	
	return button;
}

- (UIView *)attributedTextContentView:(DTAttributedTextContentView *)attributedTextContentView viewForAttachment:(DTTextAttachment *)attachment frame:(CGRect)frame
{
	if ([attachment isKindOfClass:[DTVideoTextAttachment class]])
	{
		NSURL *url = (id)attachment.contentURL;
		
		// we could customize the view that shows before playback starts
		UIView *grayView = [[UIView alloc] initWithFrame:frame];
		grayView.backgroundColor = [DTColor blackColor];
		
		// find a player for this URL if we already got one
		MPMoviePlayerController *player = nil;
		for (player in self.mediaPlayers)
		{
			if ([player.contentURL isEqual:url])
			{
				break;
			}
		}
		
		if (!player)
		{
			player = [[MPMoviePlayerController alloc] initWithContentURL:url];
			[self.mediaPlayers addObject:player];
		}
		
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_4_2
		NSString *airplayAttr = [attachment.attributes objectForKey:@"x-webkit-airplay"];
		if ([airplayAttr isEqualToString:@"allow"])
		{
			if ([player respondsToSelector:@selector(setAllowsAirPlay:)])
			{
				player.allowsAirPlay = YES;
			}
		}
#endif
		
		NSString *controlsAttr = [attachment.attributes objectForKey:@"controls"];
		if (controlsAttr)
		{
			player.controlStyle = MPMovieControlStyleEmbedded;
		}
		else
		{
			player.controlStyle = MPMovieControlStyleNone;
		}
		
		NSString *loopAttr = [attachment.attributes objectForKey:@"loop"];
		if (loopAttr)
		{
			player.repeatMode = MPMovieRepeatModeOne;
		}
		else
		{
			player.repeatMode = MPMovieRepeatModeNone;
		}
		
		NSString *autoplayAttr = [attachment.attributes objectForKey:@"autoplay"];
		if (autoplayAttr)
		{
			player.shouldAutoplay = YES;
		}
		else
		{
			player.shouldAutoplay = NO;
		}
		
		[player prepareToPlay];
		
		player.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		player.view.frame = grayView.bounds;
		[grayView addSubview:player.view];
		
		return grayView;
	}
	else if ([attachment isKindOfClass:[DTImageTextAttachment class]])
	{
		// if the attachment has a hyperlinkURL then this is currently ignored
		DTLazyImageView *imageView = [[DTLazyImageView alloc] initWithFrame:frame];
		imageView.delegate = self;
		
		// sets the image if there is one
		imageView.image = [(DTImageTextAttachment *)attachment image];
		
		// url for deferred loading
		imageView.url = attachment.contentURL;
		
		// if there is a hyperlink then add a link button on top of this image
		if (attachment.hyperLinkURL)
		{
			// NOTE: this is a hack, you probably want to use your own image view and touch handling
			// also, this treats an image with a hyperlink by itself because we don't have the GUID of the link parts
			imageView.userInteractionEnabled = YES;
			
			DTLinkButton *button = [[DTLinkButton alloc] initWithFrame:imageView.bounds];
			button.URL = attachment.hyperLinkURL;
			button.minimumHitSize = CGSizeMake(25, 25); // adjusts it's bounds so that button is always large enough
			button.GUID = attachment.hyperLinkGUID;
			
			// use normal push action for opening URL
			[button addTarget:self action:@selector(linkPushed:) forControlEvents:UIControlEventTouchUpInside];
			
			// demonstrate combination with long press
			UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(linkLongPressed:)];
			[button addGestureRecognizer:longPress];
			
			[imageView addSubview:button];
		}
		
		return imageView;
	}
	else if ([attachment isKindOfClass:[DTIframeTextAttachment class]])
	{
		DTWebVideoView *videoView = [[DTWebVideoView alloc] initWithFrame:frame];
		videoView.attachment = attachment;
		
		return videoView;
	}
	else if ([attachment isKindOfClass:[DTObjectTextAttachment class]])
	{
		// somecolorparameter has a HTML color
		NSString *colorName = [attachment.attributes objectForKey:@"somecolorparameter"];
		UIColor *someColor = DTColorCreateWithHTMLName(colorName);
		
		UIView *someView = [[UIView alloc] initWithFrame:frame];
		someView.backgroundColor = someColor;
		someView.layer.borderWidth = 1;
		someView.layer.borderColor = [UIColor blackColor].CGColor;
		
		someView.accessibilityLabel = colorName;
		someView.isAccessibilityElement = YES;
		
		return someView;
	}
	
	return nil;
}

- (BOOL)attributedTextContentView:(DTAttributedTextContentView *)attributedTextContentView shouldDrawBackgroundForTextBlock:(DTTextBlock *)textBlock frame:(CGRect)frame context:(CGContextRef)context forLayoutFrame:(DTCoreTextLayoutFrame *)layoutFrame
{
	UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(frame,1,1) cornerRadius:10];
    
	CGColorRef color = [textBlock.backgroundColor CGColor];
	if (color)
	{
		CGContextSetFillColorWithColor(context, color);
		CGContextAddPath(context, [roundedRect CGPath]);
		CGContextFillPath(context);
		
		CGContextAddPath(context, [roundedRect CGPath]);
		CGContextSetRGBStrokeColor(context, 0, 0, 0, 1);
		CGContextStrokePath(context);
		return NO;
	}
	
	return YES; // draw standard background
}


#pragma mark Actions

- (void)linkPushed:(DTLinkButton *)button
{
	NSURL *URL = button.URL;
	
	if ([[UIApplication sharedApplication] canOpenURL:[URL absoluteURL]])
	{
		[[UIApplication sharedApplication] openURL:[URL absoluteURL]];
	}
	else
	{
		if (![URL host] && ![URL path])
		{
            
			// possibly a local anchor link
			NSString *fragment = [URL fragment];
			
			if (fragment)
			{
				[_textView scrollToAnchorNamed:fragment animated:NO];
			}
		}
	}
}

//- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//	if (buttonIndex != actionSheet.cancelButtonIndex)
//	{
//		[[UIApplication sharedApplication] openURL:[self.lastActionLink absoluteURL]];
//	}
//}
//
//- (void)linkLongPressed:(UILongPressGestureRecognizer *)gesture
//{
//	if (gesture.state == UIGestureRecognizerStateBegan)
//	{
//		DTLinkButton *button = (id)[gesture view];
//		button.highlighted = NO;
//		self.lastActionLink = button.URL;
//		
//		if ([[UIApplication sharedApplication] canOpenURL:[button.URL absoluteURL]])
//		{
//			UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:[[button.URL absoluteURL] description] delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Open in Safari", nil];
//			[action showFromRect:button.frame inView:button.superview animated:YES];
//		}
//	}
//}

- (void)handleTap:(UITapGestureRecognizer *)gesture
{
	if (gesture.state == UIGestureRecognizerStateRecognized)
	{
		CGPoint location = [gesture locationInView:_textView];
		NSUInteger tappedIndex = [_textView closestCursorIndexToPoint:location];
		
		NSString *plainText = [_textView.attributedString string];
		NSString *tappedChar = [plainText substringWithRange:NSMakeRange(tappedIndex, 1)];
		
		__block NSRange wordRange = NSMakeRange(0, 0);
		
		[plainText enumerateSubstringsInRange:NSMakeRange(0, [plainText length]) options:NSStringEnumerationByWords usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
			if (NSLocationInRange(tappedIndex, enclosingRange))
			{
				*stop = YES;
				wordRange = substringRange;
			}
		}];
		
		NSString *word = [plainText substringWithRange:wordRange];
		NSLog(@"%lu: '%@' word: '%@'", (unsigned long)tappedIndex, tappedChar, word);
	}
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
