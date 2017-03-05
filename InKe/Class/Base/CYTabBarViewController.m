//
//  CYTabBarViewController.m
//  InKe
//
//  Created by 薛国宾 on 17/3/5.
//  Copyright © 2017年 千里之行始于足下. All rights reserved.
//

#import "CYTabBarViewController.h"
//#import "CYLaunchViewController.h"
#import "CYNavigationController.h"
#import "CYTabbar.h"

@interface CYTabBarViewController () <CYTabbarDelegate>

@property (nonatomic, strong) CYTabbar *cyTabbar;

@end

@implementation CYTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc]init]];
    
    //加载自定义tabbar
    [self.tabBar addSubview:self.cyTabbar];
}

#pragma mark - getters and setters

- (CYTabbar *)cyTabbar {
    
    if (!_cyTabbar) {
        _cyTabbar = [[CYTabbar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 49)];
        _cyTabbar.delegate = self;
    }
    return _cyTabbar;
}

#pragma mark - CYTabbarDelegate
- (void)tabbar:(CYTabbar *)tabbar clickIndex:(CYItemType)idx {
    if (idx != CYItemTypeLaunch) {
        //当前tabbar的索引
        self.selectedIndex = idx - CYItemTypeLive;
        return;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
