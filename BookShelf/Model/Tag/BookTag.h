//
//  BookTag.h
//  BookShelf
//
//  Created by Shaowei Zhang on 31/7/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import "BookBaseModel.h"

@interface BookTag : BookBaseModel

@property (assign, nonatomic) long long bookId;

@property (copy, nonatomic) NSString *name;

@property (assign, nonatomic) NSUInteger count;

@end
