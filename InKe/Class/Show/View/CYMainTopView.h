//
//  CYMainTopView.h
//  InKe
//
//  Created by 薛国宾 on 17/3/5.
//  Copyright © 2017年 千里之行始于足下. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LineType){
    LineType_sjx = 1,
    LineType_zx,
};


typedef void(^MainTopBlock)(NSInteger tag);

@interface CYMainTopView : UIScrollView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles lineType:(LineType)lineType tapView:(MainTopBlock)block;

@property (nonatomic, assign) LineType lineType;

@property (nonatomic, readonly, assign) NSInteger selectedIndex;

//@property (nonatomic, assign) NSInteger selectedIndexArrow; // 默认为-1 所有都是直角 当lineType 为 LineType_sjx 才有效

- (void)scrolling:(NSInteger)tag;

- (void)showBGViewLine:(NSInteger)tag;

- (void)premiereText:(CGFloat)offsetX toLeft:(BOOL)toLeft;

@end
