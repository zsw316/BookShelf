//
//  BookBaseModel.m
//  BookShelf
//
//  Created by Shaowei Zhang on 31/7/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import "BookBaseModel.h"

@implementation BookBaseModel

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    NSString *msg = [NSString stringWithFormat:@"%s is not implemented "
                     "for the class %@", sel_getName(_cmd), self];
    @throw [NSException exceptionWithName:@"BookModelInitializerException"
                                   reason:msg userInfo:nil];
}

- (instancetype)initWithFMResultSet:(FMResultSet *)set {
    NSString *msg = [NSString stringWithFormat:@"%s is not implemented "
                     "for the class %@", sel_getName(_cmd), self];
    @throw [NSException exceptionWithName:@"BookModelInitializerException"
                                   reason:msg userInfo:nil];
}

- (id)copyWithZone:(NSZone *)zone {
    NSString *msg = [NSString stringWithFormat:@"%s is not implemented "
                     "for the class %@", sel_getName(_cmd), self];
    @throw [NSException exceptionWithName:@"BookModelInitializerException"
                                   reason:msg userInfo:nil];
}

#pragma mark - convert

- (NSArray *)modelArrayFromDictArray:(NSArray *)array withModelClass:(Class)modelClass {
    NSParameterAssert(modelClass != nil);
    NSParameterAssert([modelClass isSubclassOfClass:BookBaseModel.class]);
    
    NSMutableArray *models = [@[] mutableCopy];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BookBaseModel *model = [[modelClass alloc] initWithDictionary:obj];
        [models addObject:model];
    }];
    return models;
}

@end
