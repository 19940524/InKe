//
//  CYBGTopImageView.m
//  InKe
//
//  Created by 薛国宾 on 17/3/6.
//  Copyright © 2017年 千里之行始于足下. All rights reserved.
//

#import "CYBGTopView.h"

@interface CYBGTopView () {
    CGPoint _movePath;
    CGPoint _toPath;
    NSArray *_sizes;
}
@property (nonatomic, strong) UIBezierPath *bezierPath;

@end

@implementation CYBGTopView

-(UIBezierPath *)bezierPath {
    if (!_bezierPath) {
        _bezierPath = [UIBezierPath bezierPath];
        _bezierPath.lineWidth = 2;
        _bezierPath.lineCapStyle = kCGLineCapRound;
        _bezierPath.lineJoinStyle = kCGLineJoinRound;
    }
    
    return _bezierPath;
}

- (void)drawRect:(CGRect)rect {
    [self.bezierPath removeAllPoints];
    [self.bezierPath moveToPoint:_movePath];
    [self.bezierPath addLineToPoint:_toPath];
    [[UIColor whiteColor] set];
    [self.bezierPath stroke];
}

- (void)drawLineMovePath:(CGPoint)movePath toPath:(CGPoint)toPoint {
    _movePath = movePath;
    _toPath = toPoint;
    [self setNeedsDisplay];
}









@end
