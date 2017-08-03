//
//  BookDetailViewController.h
//  BookShelf
//
//  Created by ShaoweiZhang on 31/7/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import "BookBaseViewController.h"
#import "BookEntity.h"

@interface BookDetailViewController : BookBaseViewController

@property (copy, nonatomic) BookEntity *bookEntity;

@end
