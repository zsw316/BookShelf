//
//  BookListService.m
//  BookShelf
//
//  Created by Ashley Han on 2/8/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import "BookListService.h"

#import "BookEntityDAO.h"
#import "BookAuthorDAO.h"
#import "BookTranslatorDAO.h"
#import "BookTagDAO.h"

#import "BookDBHelper.h"

@implementation BookListService

+ (NSArray<BookEntity *> *)getAllBookEntities
{
    FMDatabase *db = [FMDatabase databaseWithPath:[BookDBHelper dbPath]];
    
    if (![db open]) {
        return nil;
    }
    
    NSArray<BookEntity *> *bookEntities = [BookEntityDAO queryAllModelsWithDataBase:db];
    for (BookEntity *entity in bookEntities) {
        entity.authors = [BookAuthorDAO queryModelsWithBookId:entity.id withDataBase:db];
        entity.translators = [BookTranslatorDAO queryModelsWithBookId:entity.id withDataBase:db];
        entity.tags = [BookTagDAO queryModelsWithBookId:entity.id withDataBase:db];
    }
    
    [db close];
    
    return bookEntities;
}

@end
