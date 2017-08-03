//
//  BookAnalyticsChartView.m
//  BookShelf
//
//  Created by Ashley Han on 3/8/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import "BookAnalyticsChartView.h"

#import "BookAnalyticsChartItem.h"

@implementation BookAnalyticsChartView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _radius = 100;
        _innerRadius = 33;
        
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    [self drawData:self.itemList];
}

- (void)drawData:(NSArray<BookAnalyticsChartItem *> *)itemList {
    if ([itemList count] == 0) {
        return;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGFloat radius = self.radius;
    CGFloat innerRadius = self.innerRadius;
    CGFloat centerX = CGRectGetMidX(self.bounds);
    CGFloat centerY = CGRectGetMidY(self.bounds);
    CGFloat deg2Rad = (M_PI / 180.0);
    
    // 起始弧度
    CGFloat rotationAngle = 270;
    CGFloat angle = 0.0;
    NSInteger index = 0;
    
    for (BookAnalyticsChartItem * item in itemList) {
        CGFloat value = item.value;
        CGFloat sliceAngle = value * 360.0 / 100;
        
        if (fabs(value) > 0.000001) {
            CGFloat startAngle = rotationAngle + angle;
            CGFloat sweepAngle = sliceAngle;
            if (sweepAngle < 0.0) {
                sweepAngle = 0.0;
            }
            
            CGFloat endAngle = startAngle + sweepAngle;
            
            // 外圆
            CGFloat outRadius = radius;
            CGMutablePathRef path = CGPathCreateMutable();
            CGPathMoveToPoint(path, nil, centerX, centerY);
            CGPathAddArc(path, nil, centerX, centerY, outRadius, startAngle * deg2Rad, endAngle * deg2Rad, false);
            CGPathCloseSubpath(path);
            
            // 内圆
            if (innerRadius > 0.0) {
                CGPathMoveToPoint(path, nil, centerX, centerY);
                CGPathAddArc(path, nil, centerX, centerY, innerRadius, startAngle * deg2Rad, endAngle * deg2Rad, false);
                CGPathCloseSubpath(path);
            }
            
            // 绘制
            CGContextBeginPath(context);
            CGContextAddPath(context, path);
            CGContextSetFillColorWithColor(context, item.color.CGColor);
            CGContextEOFillPath(context);
        }
        
        index ++;
        angle += sliceAngle;
    }
}

@end
