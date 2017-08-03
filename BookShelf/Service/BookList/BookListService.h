//
//  BookListService.h
//  BookShelf
//
//  Created by Ashley Han on 2/8/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BookEntity.h"

@interface BookListService : NSObject

+ (NSArray<BookEntity *> *)getAllBookEntities;

@end
