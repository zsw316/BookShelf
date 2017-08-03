//
//  BookDetailService.m
//  BookShelf
//
//  Created by Shaowei Zhang on 2/8/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import "BookDetailService.h"

#import "BookEntityDAO.h"
#import "BookAuthorDAO.h"
#import "BookTranslatorDAO.h"
#import "BookTagDAO.h"

#import "BookDBHelper.h"

@implementation BookDetailService

+ (long long)favBook:(BookEntity *)bookEntity
{
    FMDatabase *db = [FMDatabase databaseWithPath:[BookDBHelper dbPath]];
    
    if (![db open]) {
        return 0;
    }
    
    long long bookId = [BookEntityDAO insertModel:bookEntity withDataBase:db];
    if (!bookId) {
        return bookId;
    }
    
    [bookEntity.authors enumerateObjectsUsingBlock:^(BookAuthor*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.bookId = bookId;
        [BookAuthorDAO insertModel:obj withDataBase:db];
    }];
    
    [bookEntity.translators enumerateObjectsUsingBlock:^(BookTranslator*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.bookId = bookId;
        [BookTranslatorDAO insertModel:obj withDataBase:db];
    }];
    
    [bookEntity.tags enumerateObjectsUsingBlock:^(BookTag*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.bookId = bookId;
        [BookTagDAO insertModel:obj withDataBase:db];
    }];
    
    [db close];
    
    return bookId;
}

+ (BOOL)unFavBookWithId:(long long)id
{
    FMDatabase *db = [FMDatabase databaseWithPath:[BookDBHelper dbPath]];
    
    if (![db open]) {
        return NO;
    }
    
    BOOL success = [BookEntityDAO deleteModelWithId:id withDataBase:db];
    if (!success) {
        return NO;
    }
    
    [BookAuthorDAO deleteModelWithBookId:id withDataBase:db];
    [BookTranslatorDAO deleteModelWithBookId:id withDataBase:db];
    [BookTagDAO deleteModelWithBookId:id withDataBase:db];
    
    [db close];
    
    return success;
}

+ (BookEntity *)searchFavedBookWithDoubanId:(long long)doubanId
{
    FMDatabase *db = [FMDatabase databaseWithPath:[BookDBHelper dbPath]];
    
    if (![db open]) {
        return nil;
    }
    
    BookEntity *bookEntity = [BookEntityDAO queryModelByDoubanId:doubanId withDataBase:db];
    [db close];
    
    return bookEntity;
}

@end
