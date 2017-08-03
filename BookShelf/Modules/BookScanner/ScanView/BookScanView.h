//
//  BookScanView.h
//  BookShelf
//
//  Created by ShaoweiZhang on 25/7/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookScanView : UIView

- (instancetype)initWithFrame:(CGRect)frame rectSize:(CGSize)size offsetY:(CGFloat)offsetY;
- (void)startAnimation;
- (void)stopAnimation;

@end
