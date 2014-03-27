//
//  MacroDefines.h
//  OSChina
//
//  Created by baxiang on 14-1-22.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//


// iOS 系统版本

#define IOS_LEAST_7	( [[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] != NSOrderedAscending )
#define IOS_LEAST_6	( [[[UIDevice currentDevice] systemVersion] compare:@"6.0" options:NSNumericSearch] != NSOrderedAscending )
#define IOS_LEAST_5	( [[[UIDevice currentDevice] systemVersion] compare:@"5.0" options:NSNumericSearch] != NSOrderedAscending )
#define IOS_LEAST_4	( [[[UIDevice currentDevice] systemVersion] compare:@"4.0" options:NSNumericSearch] != NSOrderedAscending )


// NSLog 打印
#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)//如果为测试模式,则log信息,否则什么都不做. 当项目设置为release时自动修改,不需要额外修改配置
#else
#define NSLog(...) do{} while(0)
#endif



//定义UIImage对象

#define IMAGE(name)         [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:nil]]
#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]

#define CGRectChangeX(rect, x) (CGRectMake(x, rect.origin.y, rect.size.width, rect.size.height))
#define CGRectChangeY(rect, y) (CGRectMake(rect.origin.x, y, rect.size.width, rect.size.height))
#define CGRectChangeWidth(rect, width) (CGRectMake(rect.origin.x, rect.origin.y, width, rect.size.height))
#define CGRectChangeHeight(rect, height) (CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, height))
#define CGRectChangeSize(rect, size) (CGRectMake(rect.origin.x, rect.origin.y, size.width, size.height))
#define CGRectChangeOrigin(rect, origin) (CGRectMake(origin.x, origin.y, rect.size.width, rect.size.height))


// 设备信息
#define isRetina     [UIScreen mainScreen].scale==2
#define screenWidth  [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height
#define INCH_IS_4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

// 颜色
#define RGB(r, g, b)      [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBA(r, g, b, a)  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]
#define CLEARCOLOR         [UIColor clearColor]

//由角度获取弧度 有弧度获取角度
#define degreesToRadian(x) (M_PI * (x) / 180.0)
#define radianToDegrees(radian) (radian*180.0)/(M_PI)



//使用ARC和不使用ARC
#if __has_feature(objc_arc)
//compiling with ARC
#else
// compiling without ARC
#endif

#pragma mark - common functions
#define RELEASE_SAFELY(__POINTER) { [__POINTER release]; __POINTER = nil; }

//释放一个对象
#define SAFE_DELETE(P) if(P) { [P release], P = nil; }
#define SAFE_RELEASE(x) [x release];x=nil

//other
#define KPopCurrentView  @"KPopCurrentView"

#define DEFAULT_DRAG_UP_BOTTOM_OFFSET 30