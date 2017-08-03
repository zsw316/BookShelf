//
//  BookAnalyticsService.h
//  BookShelf
//
//  Created by Ashley Han on 3/8/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BookStatistic.h"

typedef NS_ENUM(NSInteger, statisticMode)
{
    statisticModeAuthor
};

@interface BookAnalyticsService : NSObject

+ (NSDictionary<NSString *, BookStatistic *> *)calculateStatisticWithMode:(statisticMode)mode;

@end
