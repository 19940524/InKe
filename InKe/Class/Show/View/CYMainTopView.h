//
//  CYMainTopView.h
//  InKe
//
//  Created by 薛国宾 on 17/3/5.
//  Copyright © 2017年 千里之行始于足下. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^MainTopBlock)(NSInteger tag);

@interface CYMainTopView : UIScrollView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles tapView:(MainTopBlock)block;

- (void)scrolling:(NSInteger)tag;

- (void)showBGViewLine:(NSInteger)tag;

- (void)premiereText:(CGFloat)offsetX toLeft:(BOOL)toLeft;

@end
