//
//  BookAnalyticsChartView+BookStatistic.m
//  BookShelf
//
//  Created by Ashley Han on 3/8/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import "BookAnalyticsChartView+BookStatistic.h"
#import "BookStatistic.h"
#import "BookAnalyticsChartItem.h"
#import "UIColor+Array.h"

@implementation BookAnalyticsChartView (BookStatistic)

- (void)configureWithBookStatistics:(NSArray<BookStatistic *> *)statistics
{
    self.itemList = [@[] mutableCopy];
    [statistics enumerateObjectsUsingBlock:^(BookStatistic * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BookAnalyticsChartItem *item = [[BookAnalyticsChartItem alloc] init];
        item.color = [UIColor colorAtIndex:idx];
        item.value = obj.percentage;
        [self.itemList addObject:item];
    }];
}

@end
