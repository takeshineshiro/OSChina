//
//  SliderSwitch.h
//  OSChina
//
//  Created by baxiang on 14-2-17.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SliderSwitch : UIControl

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) UIImage *backgroundImage;
@property (nonatomic, strong) UIColor *textColorOfNormalState;
@property (nonatomic, strong) UIColor *textColorOfSelectedState;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) NSMutableArray *labels;
@property (nonatomic, strong) UIImageView  *selectionView;
- (id)initWithFrame:(CGRect)frame items:(NSArray *)items;
- (void)setSelectedIndex:(NSInteger)selectedIndex animated:(BOOL)animated;
- (void)setTitles:(NSArray *)items;
- (void)setSliderSwitchBackground:(UIImage *)image;
- (void)setBackgoundImageOfSelectedItem:(UIImage *)backgoundImageOfSelectedItem;
@end


