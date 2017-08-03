//
//  BookAuthorDAO.m
//  BookShelf
//
//  Created by Shaowei Zhang on 2/8/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import "BookAuthorDAO.h"

@implementation BookAuthorDAO

+ (long long)insertModel:(BookAuthor *)bookAuthor withDataBase:(FMDatabase *)db
{
    BOOL success = [db executeUpdate:@"INSERT INTO TB_BOOK_AUTHOR (bookId, name) VALUES (?, ?)", @(bookAuthor.bookId), bookAuthor.name];
    
    if (success) {
        return [db lastInsertRowId];
    } else {
        return 0;
    }
}

+ (BOOL)deleteModelWithBookId:(long long)bookId withDataBase:(FMDatabase *)db
{
    BOOL success = [db executeUpdate:@"DELETE FROM TB_BOOK_AUTHOR WHERE bookId = ?", @(bookId)];
    return success;
}

+ (NSArray<BookAuthor *> *)queryModelsWithBookId:(long long)bookId withDataBase:(FMDatabase *)db
{
    FMResultSet *s = [db executeQuery:@"SELECT * FROM TB_BOOK_AUTHOR WHERE bookId = ?", @(bookId)];
    
    NSMutableArray *bookAuthors = [@[] mutableCopy];
    
    while ([s next]) {
        BookAuthor *author = [[BookAuthor alloc] initWithFMResultSet:s];
        [bookAuthors addObject:author];
    }
    [s close];
    
    return bookAuthors;
}

@end
