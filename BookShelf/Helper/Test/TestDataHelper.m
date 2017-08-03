//
//  TestDataHelper.m
//  BookShelf
//
//  Created by Ashley Han on 3/8/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import "TestDataHelper.h"

#import <AFNetworking.h>
#import "BookEntity.h"
#include "BookDetailService.h"

@implementation TestDataHelper

+ (void)buildTestData
{
    NSArray *testISBNs = [[self class] testISBNs];
    
    for (NSString *isbn in testISBNs) {
        [[self class] fetchAndFavBookWithISBN:isbn];
    }
}

+ (void)fetchAndFavBookWithISBN:(NSString *)ISBN {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *sessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.douban.com/v2/book/isbn/%@", ISBN]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *dataTask = [sessionManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"error: %@", error);
        } else {
            BookEntity *bookEntity = [[BookEntity alloc] initWithDictionary:responseObject];
            BookEntity *favedBookEntity = [BookDetailService searchFavedBookWithDoubanId:bookEntity.doubanId];
            if (favedBookEntity == nil) {
                [BookDetailService favBook:bookEntity];
            }
        }
    }];
    
    [dataTask resume];
}

+ (NSArray *)testISBNs
{
    NSArray *isbns = @[
                       @"9781119975915",
                       @"9780470918029",
                       @"9787121314384",
                       @"9781119975915",
                       @"9780273768418",
                       @"9787111095927",
                       @"9787115149817",
                       @"9780470500880",
                       ];
    return isbns;
}

@end
