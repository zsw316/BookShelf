//
//  BookAnalyticsTableViewCell+BookStatistic.m
//  BookShelf
//
//  Created by Ashley Han on 3/8/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import "BookAnalyticsTableViewCell+BookStatistic.h"
#import "BookStatistic.h"

@implementation BookAnalyticsTableViewCell (BookStatistic)

- (void)configureWithBookStatistic:(BookStatistic *)statistic
{
    self.titleLabel.text = statistic.key;
    if (statistic.count > 1) {
        self.detailLabel.text = [NSString stringWithFormat:@"%@ books", @(statistic.count)];
    } else {
        self.detailLabel.text = [NSString stringWithFormat:@"%@ book", @(statistic.count)];
    }
    
    self.percentageLabel.text = [NSString stringWithFormat:@"%@ %%", @((int)statistic.percentage)];
}

@end
