//
//  BookEntityDAO.m
//  BookShelf
//
//  Created by Shaowei Zhang on 2/8/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import "BookEntityDAO.h"

@implementation BookEntityDAO

+ (long long)insertModel:(BookEntity *)bookEntity withDataBase:(FMDatabase *)db
{
    BOOL success = [db executeUpdate:@"INSERT INTO TB_BOOK_ENTITY (doubanId, isbn10, isbn13, title, doubanUrl, image, publisher, pubdate, price, summary, author_intro) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", @(bookEntity.doubanId), bookEntity.isbn10, bookEntity.isbn13, bookEntity.title, bookEntity.doubanUrl, bookEntity.image, bookEntity.publisher, bookEntity.pubdate, bookEntity.price, bookEntity.summary, bookEntity.author_intro];
    
    if (success) {
        return [db lastInsertRowId];
    } else {
        return 0;
    }
}

+ (BookEntity *)queryModelByDoubanId:(long long)doubanId withDataBase:(FMDatabase *)db
{
    FMResultSet *s = [db executeQuery:@"SELECT * FROM TB_BOOK_ENTITY WHERE doubanId = ?", @(doubanId)];
    
    if ([s next]) {
        BookEntity *entity = [[BookEntity alloc] initWithFMResultSet:s];
        return entity;
    }
    
    [s close];
    
    return nil;
}

+ (BOOL)deleteModelWithId:(long long)id withDataBase:(FMDatabase *)db
{
    BOOL success = [db executeUpdate:@"DELETE FROM TB_BOOK_ENTITY WHERE id = ?", @(id)];
    return success;
}

+ (NSArray<BookEntity *> *)queryAllModelsWithDataBase:(FMDatabase *)db
{
    FMResultSet *s = [db executeQuery:@"SELECT * FROM TB_BOOK_ENTITY"];
    NSMutableArray *bookEntities = [@[] mutableCopy];
    
    while ([s next]) {
        BookEntity *entity = [[BookEntity alloc] initWithFMResultSet:s];
        [bookEntities addObject:entity];
    }
    
    [s close];
    
    return bookEntities;
}

@end
