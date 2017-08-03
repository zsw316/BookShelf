//
//  BookTranslatorDAO.m
//  BookShelf
//
//  Created by Shaowei Zhang on 2/8/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import "BookTranslatorDAO.h"

@implementation BookTranslatorDAO

+ (long long)insertModel:(BookTranslator *)bookTranslator withDataBase:(FMDatabase *)db
{
    BOOL success = [db executeUpdate:@"INSERT INTO TB_BOOK_TRANSLATOR (bookId, name) VALUES (?, ?)", @(bookTranslator.bookId), bookTranslator.name];
    
    if (success) {
        return [db lastInsertRowId];
    } else {
        return 0;
    }
}

+ (BOOL)deleteModelWithBookId:(long long)bookId withDataBase:(FMDatabase *)db
{
    BOOL success = [db executeUpdate:@"DELETE FROM TB_BOOK_TRANSLATOR WHERE bookId = ?", @(bookId)];
    return success;
}

+ (NSArray<BookTranslator *> *)queryModelsWithBookId:(long long)bookId withDataBase:(FMDatabase *)db
{
    FMResultSet *s = [db executeQuery:@"SELECT * FROM TB_BOOK_TRANSLATOR WHERE bookId = ?", @(bookId)];
    
    NSMutableArray *bookTranslators = [@[] mutableCopy];
    
    while ([s next]) {
        BookTranslator *translator = [[BookTranslator alloc] initWithFMResultSet:s];
        [bookTranslators addObject:translator];
    }
    [s close];
    
    return bookTranslators;
}

@end
