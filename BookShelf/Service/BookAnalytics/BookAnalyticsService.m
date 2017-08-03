//
//  BookAnalyticsService.m
//  BookShelf
//
//  Created by Ashley Han on 3/8/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import "BookAnalyticsService.h"

#import "BookListService.h"
#import "BookAuthor.h"

@implementation BookAnalyticsService

+ (NSDictionary<NSString *, BookStatistic *> *)calculateStatisticWithMode:(statisticMode)mode
{
    if (mode == statisticModeAuthor) {
        NSMutableDictionary<NSString *, BookStatistic *> *dict = [@{} mutableCopy];
        
        NSArray<BookEntity *> *bookEntities = [BookListService getAllBookEntities];
        
        __block NSUInteger sum = 0;
        
        [bookEntities enumerateObjectsUsingBlock:^(BookEntity * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.authors count] > 0) {
                BookAuthor *author = (BookAuthor *)[obj.authors firstObject];
                NSString *key = author.name;
                BookStatistic *statistic = [dict objectForKey:key];
                
                if (statistic == nil) {
                    BookStatistic *newStatistic = [[BookStatistic alloc] init];
                    newStatistic.key = key;
                    newStatistic.count = 1;
                    [dict setObject:newStatistic forKey:key];
                } else {
                    statistic.count = statistic.count + 1;
                }
                
                sum++;
            }
        }];
        
        [[dict allValues] enumerateObjectsUsingBlock:^(BookStatistic * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.percentage = ((float) obj.count / (float) sum) * 100.0f;
        }];
        
        return dict;
    }
    
    return nil;
}

@end
