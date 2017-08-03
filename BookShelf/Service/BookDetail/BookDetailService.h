//
//  BookDetailService.h
//  BookShelf
//
//  Created by Shaowei Zhang on 2/8/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BookEntity.h"

@interface BookDetailService : NSObject

/**
 *
 *  Favorite book
 *
 *  @param bookEntity The Book Entity
 *
 *  @return Local Id of book
 */
+ (long long)favBook:(BookEntity *)bookEntity;

/**
 *
 *  Cancel favorite of the book specified by id
 *
 */
+ (BOOL)unFavBookWithId:(long long)id;

/**
 *
 *  Search if there is any favorited book using douban Id
 *
 */
+ (BookEntity *)searchFavedBookWithDoubanId:(long long)doubanId;

@end
