//
//  BookAnalyticsTableViewCell+BookStatistic.h
//  BookShelf
//
//  Created by Ashley Han on 3/8/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import "BookAnalyticsTableViewCell.h"

@class BookStatistic;

@interface BookAnalyticsTableViewCell (BookStatistic)

- (void)configureWithBookStatistic:(BookStatistic *)statistic;

@end
