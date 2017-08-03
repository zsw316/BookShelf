//
//  BookAuthor.m
//  BookShelf
//
//  Created by Shaowei Zhang on 31/7/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import "BookAuthor.h"

@implementation BookAuthor

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    BookAuthor *author = [[[self class] alloc] init];
    
    author.bookId = [[dict objectForKey:@"bookId"] longLongValue];
    author.name = [dict objectForKey:@"name"];
    
    return author;
}

- (instancetype)initWithFMResultSet:(FMResultSet *)set {
    BookAuthor *bookAuthor = [[[self class] alloc] init];
    
    bookAuthor.bookId = [set longLongIntForColumn:@"bookId"];
    bookAuthor.name = [set stringForColumn:@"name"];
    
    return bookAuthor;
}


- (id)copyWithZone:(NSZone *)zone {
    BookAuthor *author = [[[self class] alloc] init];
    
    author.bookId = self.bookId;
    author.name = self.name;
    
    return author;
}

@end
