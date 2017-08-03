//
//  BookEntity.m
//  BookShelf
//
//  Created by Shaowei Zhang on 31/7/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import "BookEntity.h"
#import "BookAuthor.h"
#import "BookTranslator.h"
#import "BookTag.h"

@implementation BookEntity

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    BookEntity *bookEntity = [[[self class] alloc] init];
    
    bookEntity.doubanId = [[dict objectForKey:@"id"] longLongValue];
    bookEntity.isbn10 = [dict objectForKey:@"isbn10"];
    bookEntity.isbn13 = [dict objectForKey:@"isbn13"];
    bookEntity.title = [dict objectForKey:@"title"];
    bookEntity.doubanUrl = [dict objectForKey:@"alt"];
    bookEntity.image = [[dict objectForKey:@"images"] objectForKey:@"large"];
    bookEntity.publisher = [dict objectForKey:@"publisher"];
    bookEntity.pubdate = [dict objectForKey:@"pubdate"];
    bookEntity.price = [dict objectForKey:@"price"];
    bookEntity.summary = [dict objectForKey:@"summary"];
    bookEntity.author_intro = [dict objectForKey:@"author_intro"];
    
    NSMutableArray *authors = [@[] mutableCopy];
    [[dict objectForKey:@"author"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BookAuthor *model = [[BookAuthor alloc] init];
        [model setName:obj];
        [authors addObject:model];
    }];
    
    bookEntity.authors = authors;
    
    NSMutableArray *translators = [@[] mutableCopy];
    [[dict objectForKey:@"translators"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BookTranslator *model = [[BookTranslator alloc] init];
        [model setName:obj];
        [translators addObject:model];
    }];
    
    bookEntity.translators = translators;
    
    bookEntity.tags = [self modelArrayFromDictArray:[dict objectForKey:@"tags"] withModelClass:[BookTag class]];
    
    return bookEntity;
}

- (instancetype)initWithFMResultSet:(FMResultSet *)set {
    BookEntity *bookEntity = [[[self class] alloc] init];
    
    bookEntity.id = [set longLongIntForColumn:@"id"];
    bookEntity.doubanId = [set longLongIntForColumn:@"doubanId"];
    bookEntity.isbn10 = [set stringForColumn:@"isbn10"];
    bookEntity.isbn13 = [set stringForColumn:@"isbn13"];
    bookEntity.title = [set stringForColumn:@"title"];
    bookEntity.doubanUrl = [set stringForColumn:@"doubanUrl"];
    bookEntity.image = [set stringForColumn:@"image"];
    bookEntity.publisher = [set stringForColumn:@"publisher"];
    bookEntity.pubdate = [set stringForColumn:@"pubdate"];
    bookEntity.price = [set stringForColumn:@"price"];
    bookEntity.summary = [set stringForColumn:@"summary"];
    bookEntity.author_intro = [set stringForColumn:@"author_intro"];
    
    return bookEntity;
}

- (id)copyWithZone:(NSZone *)zone {
    BookEntity *bookEntity = [[[self class] alloc] init];
    
    bookEntity.id = self.id;
    bookEntity.doubanId = self.doubanId;
    bookEntity.isbn10 = [self.isbn10 copy];
    bookEntity.isbn13 = [self.isbn13 copy];
    bookEntity.title = [self.title copy];
    bookEntity.doubanUrl = [self.doubanUrl copy];
    bookEntity.image = [self.image copy];
    bookEntity.publisher = [self.publisher copy];
    bookEntity.pubdate = [self.pubdate copy];
    bookEntity.price = [self.price copy];
    bookEntity.summary = [self.summary copy];
    bookEntity.author_intro = [self.author_intro copy];
    bookEntity.authors = [self.authors copy];
    bookEntity.translators = [self.translators copy];
    bookEntity.tags = [self.tags copy];
    
    return bookEntity;
}

@end
