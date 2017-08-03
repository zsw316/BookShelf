//
//  BookDBHelper.m
//  BookShelf
//
//  Created by Shaowei Zhang on 2/8/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import "BookDBHelper.h"

@implementation BookDBHelper

+ (NSString *)dbFolder {
    NSString *docsdir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *path = [docsdir stringByAppendingString:@"/db"];
    
    return path;
}

+ (NSString *)dbPath {
    NSString *path = [[[self class] dbFolder] stringByAppendingString:@"/book.sqlite"];
    return path;
}

+ (void)buildDataBase {
    if (![[NSFileManager defaultManager] fileExistsAtPath:[[self class] dbFolder]]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:[[self class] dbFolder] withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    FMDatabase *db = [FMDatabase databaseWithPath:[[self class] dbPath]];
    if (![db open]) {
        return;
    }
    
    BOOL succ = [[self class] createTableWithDB:db];
    if (succ) {
        NSLog(@"init sql done");
    } else {
        NSLog(@"init sql fail");
    }
    
    [db close];
}

+ (BOOL)createTableWithDB:(FMDatabase *)db {
    BOOL succ = YES;
    
    NSArray *array = [[self class] createTableSqls];
    for (NSInteger i = 0; i < [array count]; i++) {
        NSString *sql = [array objectAtIndex:i];
        if (![db executeUpdate:sql]) {
            succ = NO;
            break;
        }
    }
    
    return succ;
}

+ (NSArray *)createTableSqls
{
    return @[
             @"CREATE TABLE `TB_BOOK_ENTITY` (\
             `id`   INTEGER PRIMARY KEY AUTOINCREMENT,\
             `doubanId` INTEGER UNIQUE,\
             `isbn10`   TEXT,\
             `isbn13`   TEXT,\
             `title`   TEXT,\
             `doubanUrl`   TEXT,\
             `image`   TEXT,\
             `publisher`   TEXT,\
             `pubdate`   TEXT,\
             `price`   TEXT,\
             `summary`   TEXT,\
             `author_intro`   TEXT\
             );",
             @"CREATE TABLE `TB_BOOK_TRANSLATOR` (\
             `bookId`   INTEGER,\
             `name` TEXT,\
             `count`    INTEGER\
             );",
             @"CREATE TABLE `TB_BOOK_TAG` (\
             `bookId`   INTEGER,\
             `name` TEXT,\
             `count`    INTEGER\
             );",
             @"CREATE TABLE `TB_BOOK_AUTHOR` (\
             `bookId`   INTEGER,\
             `name` TEXT\
             );"
             ];
}
@end
