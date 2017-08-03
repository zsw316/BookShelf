//
//  BookBaseDAO.m
//  BookShelf
//
//  Created by Shaowei Zhang on 2/8/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import "BookBaseDAO.h"

@implementation BookBaseDAO

+ (long long)insertModel:(BookBaseModel *)model withDataBase:(FMDatabase *)db
{
    NSString *msg = [NSString stringWithFormat:@"%s is not implemented "
                     "for the class %@", sel_getName(_cmd), self];
    @throw [NSException exceptionWithName:@"BookDAOMethodException"
                                   reason:msg userInfo:nil];
}

@end
