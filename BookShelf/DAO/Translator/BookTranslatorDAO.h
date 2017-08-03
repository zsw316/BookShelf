//
//  BookTranslatorDAO.h
//  BookShelf
//
//  Created by Shaowei Zhang on 2/8/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import "BookBaseDAO.h"
#import "BookTranslator.h"

@interface BookTranslatorDAO : BookBaseDAO

+ (long long)insertModel:(BookTranslator *)bookTranslator withDataBase:(FMDatabase *)db;

+ (BOOL)deleteModelWithBookId:(long long)bookId withDataBase:(FMDatabase *)db;

+ (NSArray<BookTranslator *> *)queryModelsWithBookId:(long long)bookId withDataBase:(FMDatabase *)db;

@end
