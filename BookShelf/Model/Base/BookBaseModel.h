//
//  BookBaseModel.h
//  BookShelf
//
//  Created by Shaowei Zhang on 31/7/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <FMDB/FMDB.h>

@interface BookBaseModel : NSObject <NSCopying>

- (instancetype)initWithDictionary:(NSDictionary *)dict;

- (instancetype)initWithFMResultSet:(FMResultSet *)set;

#pragma mark - covert

- (NSArray *)modelArrayFromDictArray:(NSArray *)array withModelClass:(Class)modelClass;

@end
