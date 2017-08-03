//
//  BookListActionDelegate.h
//  BookShelf
//
//  Created by Ashley Han on 3/8/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BookEntity.h"

@protocol BookListActionDelegate <NSObject>

- (void)didSelectBookEntity:(BookEntity *)bookEntity;

@end
