//
//  BookListCollectionViewCell+BookEntity.h
//  BookShelf
//
//  Created by Ashley Han on 3/8/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import "BookListCollectionViewCell.h"

@class BookEntity;

@interface BookListCollectionViewCell (BookEntity)

- (void)configureCellWithBookEntity:(BookEntity *)entity;

@end
