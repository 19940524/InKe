//
//  CYMainTopView.m
//  InKe
//
//  Created by 薛国宾 on 17/3/5.
//  Copyright © 2017年 千里之行始于足下. All rights reserved.
//

#import "CYMainTopView.h"
#import "CYBGTopView.h"

#define kFont 16
#define kMaxWeight 1
#define kDefaultAlpha 0.6
#define kLineLength 14

@interface CYMainTopView () {
    UIButton *_seleteButton;
}

@property (nonatomic, strong) CYBGTopView *bgView;

@property (nonatomic, copy) MainTopBlock block;

@property (nonatomic, strong) NSMutableArray *buttons;

@property (nonatomic, strong) NSMutableArray *btnSizes;

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
        self.backgroundColor = [UIColor clearColor];
        self.btnSizes = [NSMutableArray array];
        [self __initUI:titles];
    }
    return self;
}

- (void)__initUI:(NSArray *)titles {
    
    self.bounces = NO;
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    
    CGFloat btnH = self.height;
    CGFloat btnX = 0;
    
    CGFloat contentW = 0.0;
    
    if (!titles.count) {
        return;
    }
    
    for (int i = 0; i < titles.count; i++) {
        
        UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.buttons addObject:titleButton];
        titleButton.tag = i;
        NSString *vcName = titles[i];
        [titleButton setTitle:vcName forState:UIControlStateNormal];
        [titleButton setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:kDefaultAlpha] forState:UIControlStateNormal];
        titleButton.titleLabel.font = [UIFont systemFontOfSize:kFont weight:0];
        [titleButton sizeToFit];
        titleButton.frame = CGRectMake(btnX, 0, titleButton.width+20, btnH);
        [self.btnSizes addObject:[NSValue valueWithCGSize:titleButton.size]];
        [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:titleButton];
        
        btnX += titleButton.width;
        contentW = titleButton.right;
    }
    
    UIButton *button = self.buttons[self.buttons.count-1];
    self.bgView = [[CYBGTopView alloc] initWithFrame:CGRectMake(0, 0, button.right, self.height)];
    self.bgView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.bgView];
    [self sendSubviewToBack:self.bgView];
    
    self.contentSize = CGSizeMake(contentW, self.height);
}


- (void)scrolling:(NSInteger)tag {
    
    UIButton *button = self.buttons[tag];
    
    [UIView animateWithDuration:0.16 animations:^{
        [self setButtonLabelPremiere:_seleteButton alpha:kDefaultAlpha weight:0];
        [self setButtonLabelPremiere:button alpha:1 weight:1];
    } completion:nil];
    
    _seleteButton = button;
    CGFloat offsetX = 0;
    
    if (button.right > self.width) {
        offsetX = button.right - self.width;
        [self setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    }
    
    if (button.left < self.contentOffset.x) {
        offsetX = button.left;
        [self setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    }
}

- (void)premiereText:(CGFloat)offsetX toLeft:(BOOL)toLeft {
    
//    NSLog(@"offset X --- > %f",offsetX);
    
    int firstIndex = (int)offsetX;
    int secondIndex = (int)ceil(offsetX);
    
    if (firstIndex >= _buttons.count || secondIndex >= _buttons.count) {
        return;
    }
    
    if (firstIndex == secondIndex) {
        return;
    }
    
    UIButton *currentButton;
    UIButton *toButton;

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
        
        currentWeight = (offsetX - firstIndex) * kMaxWeight;
        toWeight = (1 - (offsetX - firstIndex)) * kMaxWeight;
        
    } else {
        currentButton = _buttons[firstIndex];
        toButton = _buttons[secondIndex];
        
        currentAlpha = (1 - (offsetX - firstIndex)) * 0.4 + kDefaultAlpha;
        toAlpha = kDefaultAlpha + (offsetX - firstIndex) * 0.4;
        
        toWeight = (offsetX - firstIndex) * kMaxWeight;
        currentWeight = (1 - (offsetX - firstIndex)) * kMaxWeight;
    }
    
    [self setButtonLabelPremiere:currentButton alpha:currentAlpha weight:currentWeight];
    [self setButtonLabelPremiere:toButton alpha:toAlpha weight:toWeight];
    
    [self __scrollBGViewLine:offsetX curBtn:currentButton toBtn:toButton toLeft:toLeft];
}

- (void)setButtonLabelPremiere:(UIButton *)button alpha:(CGFloat)alpha weight:(CGFloat)weight {
    button.titleLabel.font = [UIFont systemFontOfSize:kFont weight:weight];
    [button setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:alpha] forState:UIControlStateNormal];
}

- (void)__scrollBGViewLine:(CGFloat)offsetX curBtn:(UIButton *)curBtn toBtn:(UIButton *)toBtn toLeft:(BOOL)toLeft {
    
    CGFloat mp = curBtn.centerX - kLineLength / 2;
    CGFloat tp = toBtn.centerX - kLineLength / 2;
    CGFloat x;
    if (toLeft) {
        CGFloat dist = mp - tp;
        x = mp - (dist - ((offsetX - (int)offsetX) * dist));
    } else {
        x = (offsetX - (int)offsetX) * (tp - mp) + mp;
    }
    
    // 线的起点
    CGPoint movePath = CGPointMake(x, 35);
    CGPoint toPath = CGPointMake(movePath.x+kLineLength, movePath.y);

    [self.bgView drawLineMovePath:movePath toPath:toPath];
}

- (void)showBGViewLine:(NSInteger)tag {
    UIButton *button = self.buttons[tag];
    CGFloat mp = button.centerX - kLineLength / 2;
    
    CGPoint movePath = CGPointMake(mp, 35);
    CGPoint toPath = CGPointMake(movePath.x+kLineLength, movePath.y);
    
    [self.bgView drawLineMovePath:movePath toPath:toPath];
}


- (void)titleClick:(UIButton *)button {
    
    self.block(button.tag);
    
    [self scrolling:button.tag];
    
    [self showBGViewLine:button.tag];
}

@end
