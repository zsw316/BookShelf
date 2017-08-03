//
//  BookListCollectionViewCell.h
//  BookShelf
//
//  Created by Ashley Han on 3/8/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookListCollectionViewCellEditDelegate.h"

@interface BookListCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) UIImageView *coverImageView;
@property (strong, nonatomic) UILabel *titleLabel;

@property (weak, nonatomic) NSIndexPath *indexPath;
@property (weak, nonatomic) id<BookListCollectionViewCellEditDelegate> delegate;

- (void)endEditing;

@end
