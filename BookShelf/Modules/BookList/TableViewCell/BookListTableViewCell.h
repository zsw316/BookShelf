//
//  BookListTableViewCell.h
//  BookShelf
//
//  Created by Ashley Han on 3/8/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import "BookBaseTableViewCell.h"

@interface BookListTableViewCell : BookBaseTableViewCell

@property (strong, nonatomic) UIImageView *coverImageView;
@property (strong, nonatomic) UILabel *authorLabel;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIView *tagsView;

@end
