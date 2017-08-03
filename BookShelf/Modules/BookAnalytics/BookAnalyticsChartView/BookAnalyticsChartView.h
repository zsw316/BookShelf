//
//  BookAnalyticsChartView.h
//  BookShelf
//
//  Created by Ashley Han on 3/8/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BookAnalyticsChartItem;

@interface BookAnalyticsChartView : UIView

@property (nonatomic, assign) CGFloat radius;

@property (nonatomic, assign) CGFloat innerRadius;

@property (nonatomic, strong) NSMutableArray<BookAnalyticsChartItem *> *itemList;

@end
