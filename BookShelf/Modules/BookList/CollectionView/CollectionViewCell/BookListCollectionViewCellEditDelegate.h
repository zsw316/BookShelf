//
//  BookListCollectionViewCellEditDelegate.h
//  BookShelf
//
//  Created by Ashley Han on 3/8/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol BookListCollectionViewCellEditDelegate <NSObject>

- (void)collectionViewCell:(UICollectionViewCell *)cell didDeleteCellAtIndexPath:(NSIndexPath *)indexPath;

@end
