//
//  CYTabbar.h
//  InKe
//
//  Created by 薛国宾 on 17/3/5.
//  Copyright © 2017年 千里之行始于足下. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CYItemType) {
    CYItemTypeLaunch = 100,
    CYItemTypeLive    = 1000,
    CYItemTypeMe,
};

@class CYTabbar;

typedef void(^TabBlock)(CYTabbar *tabbar, CYItemType idx);

@protocol CYTabbarDelegate <NSObject>

- (void)tabbar:(CYTabbar *)tabbar clickIndex:(CYItemType)idx;

@end

@interface CYTabbar : UIView

@property (nonatomic, weak) id <CYTabbarDelegate> delegate;

@property (nonatomic, copy) TabBlock tabBlock;

@end
