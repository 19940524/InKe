//
//  CYMacros.h
//  InKe
//
//  Created by 薛国宾 on 17/3/4.
//  Copyright © 2017年 千里之行始于足下. All rights reserved.
//

#ifndef CYMacros_h
#define CYMacros_h

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define RGB(r,g,b) [UIColor colorWithRed:(r/255.0f) green:(g/255.0f) blue:(b/255.0f) alpha:1]
#define RANDOM_COLOR [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]

#endif /* CYMacros_h */
