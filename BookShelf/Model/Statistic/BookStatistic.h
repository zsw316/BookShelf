//
//  BookStatistic.h
//  BookShelf
//
//  Created by Ashley Han on 3/8/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookStatistic : NSObject

@property (strong, nonatomic) NSString *key;

@property (assign, nonatomic) NSUInteger count;

@property (assign, nonatomic) float percentage;

@end
