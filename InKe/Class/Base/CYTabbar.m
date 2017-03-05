//
//  CYTabbar.m
//  InKe
//
//  Created by 薛国宾 on 17/3/5.
//  Copyright © 2017年 千里之行始于足下. All rights reserved.
//

#import "CYTabbar.h"

@interface CYTabbar ()

@property (nonatomic, strong) NSArray * datalist;

@property (nonatomic, strong) UIButton * lastItem;

@property (nonatomic, strong) UIImageView * tabBgView;

@property (nonatomic, strong) UIButton * cameraBtn;

@end

@implementation CYTabbar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    //装载背景
    [self addSubview:self.tabBgView];
    
    //装载item
    for (int i = 0; i < self.datalist.count; i++) {
        
        UIButton * item = [UIButton buttonWithType:UIButtonTypeCustom];
        
        item.adjustsImageWhenHighlighted = NO;
        
        [item setImage:[UIImage imageNamed:self.datalist[i]] forState:UIControlStateNormal];
        
        [item setImage:[UIImage imageNamed:[self.datalist[i] stringByAppendingString:@"_p"]] forState:UIControlStateSelected];
        
        if (i == 0) {
            item.selected = YES;
            self.lastItem = item;
        }
        
        item.tag = CYItemTypeLive + i;
        
        [item addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:item];
        
    }
    
    //装载相机
    [self addSubview:self.cameraBtn];
}

- (NSArray *)datalist {
    
    if (!_datalist) {
        _datalist = @[@"tab_live",@"tab_me"];
    }
    return _datalist;
}

- (UIButton *)cameraBtn {
    
    if (!_cameraBtn) {
        _cameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cameraBtn setImage:[UIImage imageNamed:@"tab_launch"] forState:UIControlStateNormal];
        [_cameraBtn sizeToFit];
        [_cameraBtn addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
        _cameraBtn.tag = CYItemTypeLaunch;
    }
    return _cameraBtn;
}

- (UIImageView *)tabBgView {
    
    if (!_tabBgView) {
        _tabBgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"global_tab_bg"]];
    }
    return _tabBgView;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGFloat width = self.frame.size.width / self.datalist.count;
    
    for (UIView * btn in self.subviews) {
        
        if (btn.tag >= CYItemTypeLive) {
            
            btn.frame = CGRectMake((btn.tag - CYItemTypeLive) * width, 0, width, self.frame.size.height);
        }
    }
    
    self.tabBgView.frame = self.frame;
    self.cameraBtn.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5 - 15);
}

- (void)clickItem:(UIButton *)button {
    
    if ([self.delegate respondsToSelector:@selector(tabbar:clickIndex:)]) {
        [self.delegate tabbar:self clickIndex:button.tag];
    }
    
    if (self.tabBlock) {
        self.tabBlock(self,button.tag);
    }
    
    if (button.tag == CYItemTypeLaunch) {
        return;
    }
    
    //将上一个按钮的选中状态置为NO
    self.lastItem.selected = NO;
    
    //将正在点击的按钮状态置为YES
    button.selected = YES;
    
    //将当前按钮设置成上一个按钮
    self.lastItem = button;
    
    [UIView animateWithDuration:0.11 animations:^{
        button.transform = CGAffineTransformMakeScale(0.85f, 0.85f);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            button.transform = CGAffineTransformMakeScale(1.15f, 1.15f);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 animations:^{
                button.transform = CGAffineTransformIdentity;
            }];
        }];
    }];
    
    
}

@end
