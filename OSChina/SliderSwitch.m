//
//  SliderSwitch.m
//  OSChina
//
//  Created by baxiang on 14-2-17.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//

#import "SliderSwitch.h"



@implementation SliderSwitch{

    NSInteger tilteCount;

}

- (id)initWithFrame:(CGRect)frame items:(NSArray *)items {
    if(self = [self initWithFrame:frame]) {
        self.items = items;
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5.0f;
        self.layer.masksToBounds = YES;
        self.textColorOfNormalState = RGB(69, 176, 222);
        self.textColorOfSelectedState = [UIColor whiteColor];
        
        _selectedIndex = -1;
        _labels = [NSMutableArray array];
        
        _selectionView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [_selectionView setImage:[UIImage imageNamed:@"tweet_segement_bg"]];
        _selectionView.backgroundColor = [UIColor clearColor];
        [self addSubview:_selectionView];
    }
    return self;
}


- (void)setBackgoundImageOfSelectedItem:(UIImage *)backgoundImageOfSelectedItem {
    [_selectionView setImage:backgoundImageOfSelectedItem];
}



- (void)setTitles:(NSArray *)items {
   
    tilteCount = [items count];
    for(int i = 0; i < items.count; i++) {
        UILabel *label = [[UILabel alloc] init];
        label.frame =CGRectMake(2+i* (self.width - 2.0f * 2) / tilteCount, 2, (self.width - 2.0f * 2) / tilteCount, self.height - 2.0f * 2);
        label.text = [items objectAtIndex:i];
        label.font = [UIFont boldSystemFontOfSize:15];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        [self addSubview:label];
        [_labels addObject:label];

    }
    _selectionView.frame = CGRectMake(2, 2, (self.width - 2.0f * 2) / tilteCount, self.height - 2.0f * 2);
    //_selectedIndex = 0;
    [self setSelectedIndex:0];
}



- (void)setSelectedIndex:(NSInteger)selectedIndex animated:(BOOL)animated {
    if(selectedIndex != _selectedIndex) {
        _selectedIndex = selectedIndex;
        
        if(animated) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.3];
        }
        
       // _selectionView.left = 1 + (self.width - 2.0f * 1) * _selectedIndex / self.items.count ;
        _selectionView.frame = CGRectMake( 2 + (self.width - 2.0f * 1) * _selectedIndex / tilteCount ,2, (self.width - 2.0f * 2) / tilteCount, self.height - 2.0f * 2);
        for(int i = 0;i < tilteCount; i++) {
            UILabel *label = [_labels objectAtIndex:i];
            [self bringSubviewToFront:label];
            if(i == selectedIndex) {
                label.textColor = self.textColorOfSelectedState;
                label.shadowOffset = CGSizeZero;
            } else {
                label.textColor = self.textColorOfNormalState;
                label.shadowOffset = CGSizeZero;
            }
        }
        
        if(animated) {
            [UIView commitAnimations];
        }
    }
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    [self setSelectedIndex:selectedIndex animated:NO];
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    CGPoint position = [(UITouch *)[touches anyObject] locationInView:self];
    if(CGRectContainsPoint(self.bounds, position)) {
        NSInteger index =  (int)floorf((position.x - 1) / ((self.bounds.size.width - 2.0f * 1) / (tilteCount * 1.0f)));
        if(index != _selectedIndex) {
            [self setSelectedIndex:index animated:YES];
            [self sendActionsForControlEvents:UIControlEventValueChanged];
        }
    }
}

@end


