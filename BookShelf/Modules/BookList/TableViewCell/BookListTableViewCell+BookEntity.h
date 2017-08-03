//
//  BookListTableViewCell+BookEntity.h
//  BookShelf
//
//  Created by Ashley Han on 3/8/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import "BookListTableViewCell.h"

@class BookEntity;

@interface BookListTableViewCell (BookEntity)

- (void)configureWithBookEntity:(BookEntity *)bookEntity;

@end
