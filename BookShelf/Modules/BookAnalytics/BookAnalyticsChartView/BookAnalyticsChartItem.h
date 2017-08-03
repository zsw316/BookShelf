//
//  BookAnalyticsChartItem.h
//  BookShelf
//
//  Created by Ashley Han on 3/8/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <UIKit/UIKit.h>

@interface BookAnalyticsChartItem : NSObject

@property (nonatomic, strong) UIColor *color;

@property (nonatomic, assign) CGFloat value;

@property (nonatomic, assign) CGFloat startPercentage;

@property (nonatomic, assign) CGFloat endPercentage;

@end
