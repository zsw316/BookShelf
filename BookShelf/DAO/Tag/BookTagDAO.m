//
//  BookTagDAO.m
//  BookShelf
//
//  Created by Shaowei Zhang on 2/8/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import "BookTagDAO.h"

@implementation BookTagDAO

+ (long long)insertModel:(BookTag *)bookTag withDataBase:(FMDatabase *)db
{
    BOOL success = [db executeUpdate:@"INSERT INTO TB_BOOK_TAG (bookId, name, count) VALUES (?, ?, ?)", @(bookTag.bookId), bookTag.name, @(bookTag.count)];
    
    if (success) {
        return [db lastInsertRowId];
    } else {
        return 0;
    }
}

+ (BOOL)deleteModelWithBookId:(long long)bookId withDataBase:(FMDatabase *)db
{
    BOOL success = [db executeUpdate:@"DELETE FROM TB_BOOK_TAG WHERE bookId = ?", @(bookId)];
    return success;
}

+ (NSArray<BookTag *> *)queryModelsWithBookId:(long long)bookId withDataBase:(FMDatabase *)db
{
    FMResultSet *s = [db executeQuery:@"SELECT * FROM TB_BOOK_TAG WHERE bookId = ?", @(bookId)];
    
    NSMutableArray *bookTags = [@[] mutableCopy];
    
    while ([s next]) {
        BookTag *tag = [[BookTag alloc] initWithFMResultSet:s];
        [bookTags addObject:tag];
    }
    [s close];
    
    return bookTags;
}

@end
