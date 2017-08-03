//
//  BookAnalyticsChartView+BookStatistic.h
//  BookShelf
//
//  Created by Ashley Han on 3/8/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import "BookAnalyticsChartView.h"

@class BookStatistic;

@interface BookAnalyticsChartView (BookStatistic)

- (void)configureWithBookStatistics:(NSArray<BookStatistic *> *)statistics;

@end
