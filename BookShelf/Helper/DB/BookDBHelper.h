//
//  BookDBHelper.h
//  BookShelf
//
//  Created by Shaowei Zhang on 2/8/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>

@interface BookDBHelper : NSObject

+ (NSString *)dbFolder;

+ (NSString *)dbPath;

+ (void)buildDataBase;

+ (BOOL)createTableWithDB:(FMDatabase *)db;

@end
