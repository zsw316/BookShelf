//
//  BookAuthorDAO.h
//  BookShelf
//
//  Created by Shaowei Zhang on 2/8/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import "BookBaseDAO.h"
#import "BookAuthor.h"

@interface BookAuthorDAO : BookBaseDAO

+ (long long)insertModel:(BookAuthor *)bookAuthor withDataBase:(FMDatabase *)db;

+ (BOOL)deleteModelWithBookId:(long long)bookId withDataBase:(FMDatabase *)db;

+ (NSArray<BookAuthor *> *)queryModelsWithBookId:(long long)bookId withDataBase:(FMDatabase *)db;

@end
