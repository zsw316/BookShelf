//
//  BookEntityDAO.h
//  BookShelf
//
//  Created by Shaowei Zhang on 2/8/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import "BookBaseDAO.h"
#import "BookEntity.h"

@interface BookEntityDAO : BookBaseDAO

+ (long long)insertModel:(BookEntity *)bookEntity withDataBase:(FMDatabase *)db;

+ (BookEntity *)queryModelByDoubanId:(long long)doubanId withDataBase:(FMDatabase *)db;

+ (BOOL)deleteModelWithId:(long long)id withDataBase:(FMDatabase *)db;

+ (NSArray<BookEntity *> *)queryAllModelsWithDataBase:(FMDatabase *)db;

@end
