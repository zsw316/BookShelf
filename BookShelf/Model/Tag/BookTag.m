//
//  BookTag.m
//  BookShelf
//
//  Created by Shaowei Zhang on 31/7/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import "BookTag.h"

@implementation BookTag

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    BookTag *bookTag = [[[self class] alloc] init];
    
    bookTag.bookId = [[dict objectForKey:@"bookId"] longLongValue];
    bookTag.name = [dict objectForKey:@"name"];
    bookTag.count = [[dict objectForKey:@"count"] longValue];
    
    return bookTag;
}

- (instancetype)initWithFMResultSet:(FMResultSet *)set {
    BookTag *bookTag = [[[self class] alloc] init];
    
    bookTag.bookId = [set longLongIntForColumn:@"bookId"];
    bookTag.name = [set stringForColumn:@"name"];
    bookTag.count = [set longForColumn:@"count"];
    
    return bookTag;
}

- (id)copyWithZone:(NSZone *)zone {
    BookTag *bookTag = [[[self class] alloc] init];
    
    bookTag.bookId = self.bookId;
    bookTag.name = [self.name copy];
    bookTag.count = self.count;
    
    return bookTag;
}

@end
