//
//  CYNavigationController.m
//  InKe
//
//  Created by 薛国宾 on 17/3/5.
//  Copyright © 2017年 千里之行始于足下. All rights reserved.
//

#import "CYNavigationController.h"

@interface CYNavigationController ()

@end

@implementation CYNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.translucent = NO;
    
    self.navigationBar.barTintColor = RGB(36, 218, 201);
    self.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}


@end
