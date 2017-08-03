//
//  BookEntity.h
//  BookShelf
//
//  Created by Shaowei Zhang on 31/7/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BookBaseModel.h"

@interface BookEntity : BookBaseModel

@property (assign, nonatomic) long long id;
@property (assign, nonatomic) long long doubanId;
@property (copy, nonatomic) NSString *isbn10;
@property (copy, nonatomic) NSString *isbn13;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *doubanUrl;
@property (copy, nonatomic) NSString *image;
@property (copy, nonatomic) NSString *publisher;
@property (copy, nonatomic) NSString *pubdate;
@property (copy, nonatomic) NSString *price;
@property (copy, nonatomic) NSString *summary;
@property (copy, nonatomic) NSString *author_intro;
@property (copy, nonatomic) NSArray *authors;
@property (copy, nonatomic) NSArray *translators;
@property (copy, nonatomic) NSArray *tags;

@end
