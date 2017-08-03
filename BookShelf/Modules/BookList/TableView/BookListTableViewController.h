//
//  BookListTableViewController.h
//  BookShelf
//
//  Created by Ashley Han on 2/8/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import "BookBaseViewController.h"
#import "BookListActionDelegate.h"

@interface BookListTableViewController : BookBaseViewController

@property (weak, nonatomic) id<BookListActionDelegate> delegate;

@end
