//
//  BookScanView.m
//  BookShelf
//
//  Created by ShaoweiZhang on 25/7/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import "BookScanView.h"

@interface BookScanView ()

/**
 * The size of scan area
 */
@property (assign, nonatomic) CGSize rectSize;

/**
 * The offset Y against with the center of super view
 */
@property (assign, nonatomic) CGFloat offsetY;

/**
 * The animation line of scan view
 */
@property (strong, nonatomic) UIImageView *animationLine;

/**
 * Indicate whether to reverse the animation or not
 */
@property (assign, nonatomic, getter=isAnimationReverse) BOOL animationReverse;

/**
 * Indicate if it is animating or not
 */
@property (assign, nonatomic) BOOL isAnimating;

@end

@implementation BookScanView

- (instancetype)initWithFrame:(CGRect)frame rectSize:(CGSize)size offsetY:(CGFloat)offsetY {
    if (self = [super initWithFrame:frame]) {
        _rectSize = size;
        _offsetY = offsetY;
        _animationReverse = NO;
        _isAnimating = NO;
    }
    
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    
    // Calculate minX, minY, maxX and maxY of scan area
    CGFloat minX = (CGRectGetWidth(self.frame) - self.rectSize.width) / 2.0f;
    CGFloat maxX = minX + self.rectSize.width;
    CGFloat minY = CGRectGetHeight(self.frame) / 2.0f + self.offsetY - self.rectSize.height/2.0f;
    CGFloat maxY = minY + self.rectSize.height;
    
    // Draw the rectangles
    CGRect topRectangle = CGRectMake(0, 0, CGRectGetWidth(self.frame), minY);
    CGContextAddRect(context, topRectangle);
    
    CGRect bottomRectangle = CGRectMake(0, maxY, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - maxY);
    CGContextAddRect(context, bottomRectangle);
    
    CGRect leftRectangle = CGRectMake(0, minY, minX, self.rectSize.height);
    CGContextAddRect(context, leftRectangle);
    
    CGRect rightRectangle = CGRectMake(maxX, minY, CGRectGetWidth(self.frame) - maxX, self.rectSize.height);
    CGContextAddRect(context, rightRectangle);
    
    CGContextClosePath(context);
    
    CGContextSetRGBFillColor(context, 0, 0, 0, 0.4f);
    CGContextFillPath(context);
    
    // Draw center rectangle
    CGContextSetLineWidth(context, 0.5f);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextAddRect(context, CGRectMake(minX, minY, self.rectSize.width, self.rectSize.height));
    CGContextStrokePath(context);
    
    // Draw the corner shapes
    CGFloat lineWidth = 1.0f;
    CGFloat lineLength = 9.0f;
    CGContextSetLineWidth(context, lineWidth);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    
    // Top left corner
    CGContextMoveToPoint(context, minX-lineWidth, minY+lineLength-lineWidth);
    CGContextAddLineToPoint(context, minX-lineWidth, minY-lineWidth);
    CGContextAddLineToPoint(context, minX+lineLength-lineWidth, minY-lineWidth);
    
    // Top right corner
    CGContextMoveToPoint(context, maxX+lineWidth-lineLength, minY-lineWidth);
    CGContextAddLineToPoint(context, maxX+lineWidth, minY-lineWidth);
    CGContextAddLineToPoint(context, maxX+lineWidth, minY-lineWidth+lineLength);
    
    // Bottom left corner
    CGContextMoveToPoint(context, minX-lineWidth, maxY+lineWidth-lineLength);
    CGContextAddLineToPoint(context, minX-lineWidth, maxY+lineWidth);
    CGContextAddLineToPoint(context, minX-lineWidth+lineLength, maxY+lineWidth);
    
    // Bottom right corner
    CGContextMoveToPoint(context, maxX+lineWidth-lineLength, maxY+lineWidth);
    CGContextAddLineToPoint(context, maxX+lineWidth, maxY+lineWidth);
    CGContextAddLineToPoint(context, maxX+lineWidth, maxY+lineWidth-lineLength);
    CGContextStrokePath(context);
}

- (UIImageView *)animationLine {
    if (_animationLine == nil) {
        CGFloat minX = (CGRectGetWidth(self.frame) - self.rectSize.width) / 2.0f;
        CGFloat minY = (CGRectGetHeight(self.frame) - self.rectSize.height) / 2.0f + self.offsetY;
        _animationLine = [[UIImageView alloc] initWithFrame:CGRectMake(minX, minY, self.rectSize.width, 1.0f)];
        _animationLine.image = [UIImage imageNamed:@"scanner-line"];
        
        [self addSubview:_animationLine];
    }
    
    return _animationLine;
}

- (void)startAnimation {
    if (self.isAnimating) {
        return;
    }
    
    self.isAnimating = YES;
    
    CGFloat minX = (CGRectGetWidth(self.frame) - self.rectSize.width) / 2.0f;
    CGFloat minY = (CGRectGetHeight(self.frame) - self.rectSize.height) / 2.0f + self.offsetY;
    CGFloat maxY = minY + self.rectSize.height;
    
    [UIView animateWithDuration:3.0f delay:0.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        if (self.animationReverse) {
            self.animationLine.frame = CGRectMake(minX, minY, self.rectSize.width, 1.0f);
        } else {
            self.animationLine.frame = CGRectMake(minX, maxY, self.rectSize.width, 1.0f);
        }
    } completion:^(BOOL finished) {
        if (finished) {
            self.isAnimating = NO;
            self.animationReverse = !self.animationReverse;
            [self startAnimation];
        } else {
            [self stopAnimation];
        }
    }];
}

- (void)stopAnimation {
    [self.animationLine removeFromSuperview];
    self.animationLine = nil;
    self.isAnimating = NO;
    self.animationReverse = NO;
}

@end
