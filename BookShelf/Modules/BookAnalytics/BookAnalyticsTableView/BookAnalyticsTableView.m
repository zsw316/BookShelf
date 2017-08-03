//
//  BookAnalyticsTableView.m
//  BookShelf
//
//  Created by Ashley Han on 3/8/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import "BookAnalyticsTableView.h"

@implementation BookAnalyticsTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    
    if (self) {
        [self initTableView];
    }
    
    return self;
}

#pragma mark - initTableView

- (void)initTableView
{
    self.backgroundColor = UIColorForRGB(0xF9F9F9);
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.tableFooterView = [UIView new];
}

@end
