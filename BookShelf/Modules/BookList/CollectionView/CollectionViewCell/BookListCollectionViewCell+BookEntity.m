//
//  BookListCollectionViewCell+BookEntity.m
//  BookShelf
//
//  Created by Ashley Han on 3/8/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import "BookListCollectionViewCell+BookEntity.h"

#import <UIImageView+WebCache.h>
#import "BookEntity.h"

@implementation BookListCollectionViewCell (BookEntity)

- (void)configureCellWithBookEntity:(BookEntity *)entity
{
    self.titleLabel.text = entity.title;
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:entity.image]];
}

@end
