//
//  BookBaseDAO.h
//  BookShelf
//
//  Created by Shaowei Zhang on 2/8/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BookBaseModel.h"
#import <FMDB/FMDB.h>

@interface BookBaseDAO : NSObject

+ (long long)insertModel:(BookBaseModel *)model withDataBase:(FMDatabase *)db;

@end
