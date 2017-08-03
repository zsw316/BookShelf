//
//  BookTagDAO.h
//  BookShelf
//
//  Created by Shaowei Zhang on 2/8/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import "BookBaseDAO.h"
#import "BookTag.h"

@interface BookTagDAO : BookBaseDAO

+ (long long)insertModel:(BookTag *)bookTag withDataBase:(FMDatabase *)db;

+ (BOOL)deleteModelWithBookId:(long long)bookId withDataBase:(FMDatabase *)db;

+ (NSArray<BookTag *> *)queryModelsWithBookId:(long long)bookId withDataBase:(FMDatabase *)db;

@end
