//
//  CYMainTopView.m
//  InKe
//
//  Created by 薛国宾 on 17/3/5.
//  Copyright © 2017年 千里之行始于足下. All rights reserved.
//

#import "CYMainTopView.h"

#define kFont 16
#define kWeight 1
#define kDefaultAlpha 0.6

@interface CYMainTopView () {
    UIScrollView *_contentScrollView;
    UIButton *_seleteButton;
}

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, copy) MainTopBlock block;

@property (nonatomic, strong) NSMutableArray *buttons;

@end

@implementation CYMainTopView

- (NSMutableArray *)buttons {
    
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles tapView:(MainTopBlock)block {
    
    if (self = [super initWithFrame:frame]) {
        
        self.block = block;
        
        [self initUI:titles];
    }
    return self;
}

- (void)initUI:(NSArray *)titles {
    
    _contentScrollView = [[UIScrollView alloc] init];
    _contentScrollView.bounces = NO;
    _contentScrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:_contentScrollView];
    [_contentScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self);
    }];
    
    
    CGFloat btnH = self.height;
    CGFloat btnX = 0;
    
    CGFloat contentW = 0.0;
    
    for (int i = 0; i < titles.count; i++) {
        
        UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [self.buttons addObject:titleButton];
        
        
        titleButton.tag = i;
        
        NSString *vcName = titles[i];
        
        [titleButton setTitle:vcName forState:UIControlStateNormal];
        // 设置标题颜色
        [titleButton setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:kDefaultAlpha] forState:UIControlStateNormal];
        
        // 设置标题字体
        titleButton.titleLabel.font = [UIFont systemFontOfSize:kFont weight:0];
        [titleButton sizeToFit];
        
        titleButton.frame = CGRectMake(btnX, 0, titleButton.width+20, btnH);
        
        btnX += titleButton.width;
        
        
        contentW = titleButton.right;
        // 监听按钮点击
        [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [_contentScrollView addSubview:titleButton];
        
        if (i == 1) {
            
            CGFloat h = 2;
            CGFloat y = 35;
            
            UIView *lineView = [[UIView alloc] init];
            // 位置和尺寸
            lineView.height = h;
            lineView.width = 15;
            lineView.centerX = titleButton.centerX;
            lineView.top = y;
            lineView.layer.cornerRadius = 1;
            lineView.layer.masksToBounds = YES;
            lineView.backgroundColor = [UIColor whiteColor];
            
            self.lineView = lineView;
            
            [_contentScrollView addSubview:self.lineView];
            
        }
    }
    _contentScrollView.contentSize = CGSizeMake(contentW, self.height);
}


- (void)scrolling:(NSInteger)tag {
    
    UIButton *button = self.buttons[tag];
    
    [UIView animateWithDuration:0.16 animations:^{
        self.lineView.centerX = button.centerX;
        [self setButtonLabelPremiere:_seleteButton alpha:kDefaultAlpha weight:0];
        [self setButtonLabelPremiere:button alpha:1 weight:1];
    } completion:nil];
    
    _seleteButton = button;
    CGFloat offsetX = 0;
    
    if (button.right > self.width) {
        offsetX = button.right - self.width;
        [_contentScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    }
    
    if (button.left < _contentScrollView.contentOffset.x) {
        offsetX = button.left;
        [_contentScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    }
}

- (void)premiereText:(CGFloat)offsetX toLeft:(BOOL)toLeft {
    
    int firstIndex = (int)offsetX;
    int secondIndex = (int)ceil(offsetX);
    
    if (firstIndex >= _buttons.count || secondIndex >= _buttons.count) {
        return;
    }
    
    UIButton *currentButton;
    UIButton *toButton;
    
    if (firstIndex == secondIndex) {
//        currentButton = _buttons[firstIndex];
//        currentButton.titleLabel.font = [UIFont systemFontOfSize:16 weight:10];
        return;
    }

    // 0.6 ~ 1 & 1 ~ 0.6
    CGFloat toAlpha;
    CGFloat currentAlpha;
    
    CGFloat currentWeight;
    CGFloat toWeight;
    
    if (toLeft) {
        currentButton = _buttons[secondIndex];
        toButton = _buttons[firstIndex];
        
        currentAlpha = (offsetX - firstIndex) * 0.4 + kDefaultAlpha;
        toAlpha = 1 - ((offsetX - firstIndex) * 0.4);
        
        currentWeight = (offsetX - firstIndex) * kWeight;
        toWeight = (1 - (offsetX - firstIndex)) * kWeight;
        
    } else {
        currentButton = _buttons[firstIndex];
        toButton = _buttons[secondIndex];
        
        currentAlpha = (1 - (offsetX - firstIndex)) * 0.4 + kDefaultAlpha;
        toAlpha = kDefaultAlpha + (offsetX - firstIndex) * 0.4;
        
        toWeight = (offsetX - firstIndex) * kWeight;
        currentWeight = (1 - (offsetX - firstIndex)) * kWeight;
    }
    
    [self setButtonLabelPremiere:currentButton alpha:currentAlpha weight:currentWeight];
    [self setButtonLabelPremiere:toButton alpha:toAlpha weight:toWeight];
}

- (void)setButtonLabelPremiere:(UIButton *)button alpha:(CGFloat)alpha weight:(CGFloat)weight {
    button.titleLabel.font = [UIFont systemFontOfSize:kFont weight:weight];
    [button setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:alpha] forState:UIControlStateNormal];
}

- (void)titleClick:(UIButton *)button {
    
    self.block(button.tag);
    
    [self scrolling:button.tag];
}

@end
