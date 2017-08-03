//
//  BookListCollectionViewController.m
//  BookShelf
//
//  Created by Ashley Han on 2/8/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import "BookListCollectionViewController.h"

#import "BookListCollectionViewCell.h"
#import "BookListCollectionViewCell+BookEntity.h"

#import "BookListService.h"
#import "BookDetailService.h"

#import "BookListCollectionViewCellEditDelegate.h"

#define kMaxColumn 3

static NSString *const kCellIdentifier = @"bookListCollectionViewCell";

@interface BookListCollectionViewController () <UICollectionViewDataSource, UICollectionViewDelegate, BookListCollectionViewCellEditDelegate>

@property (strong, nonatomic) UICollectionView *collectionView;

@property (strong, nonatomic) NSMutableArray<BookEntity *> *bookEntities;

@end

@implementation BookListCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor greenColor];
    [self initCollectionView];
    [self getData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self getData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CollectionView
- (void)initCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    CGFloat margin = 10.0f;
    layout.minimumLineSpacing = margin;
    layout.minimumInteritemSpacing = margin;
    CGFloat itemWidth = (CGRectGetWidth(self.view.frame) - (kMaxColumn + 1) * margin) / kMaxColumn;
    CGFloat itemHeight = 170.f;
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    layout.sectionInset = UIEdgeInsetsMake(margin, margin, margin, margin);
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) collectionViewLayout:layout];
    
    collectionView.backgroundColor = UIColorForRGB(0xF9F9F9);
    collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    self.collectionView = collectionView;
    [self.collectionView registerClass:[BookListCollectionViewCell class] forCellWithReuseIdentifier:kCellIdentifier];
    
    [self.view addSubview:collectionView];
}

#pragma mark - data
- (void)getData
{
    self.bookEntities = [[BookListService getAllBookEntities] mutableCopy];
    [self.collectionView reloadData];
}

#pragma mark - datasource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.bookEntities count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BookListCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    cell.indexPath = indexPath;
    cell.delegate = self;
    BookEntity *entity = [self.bookEntities objectAtIndex:indexPath.row];
    [cell configureCellWithBookEntity:entity];
    
    return cell;
}

#pragma mark - delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    BookEntity *entity = [self.bookEntities objectAtIndex:indexPath.row];
    [self.delegate didSelectBookEntity:entity];
    [self.collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return YES;
}

-(void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    NSLog(@"%@",NSStringFromSelector(action));
}

#pragma mark - BookListCollectionViewCellEditDelegate
- (void)collectionViewCell:(UICollectionViewCell *)cell didDeleteCellAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell isKindOfClass:[BookListCollectionViewCell class]]) {
        BookEntity *entity = [self.bookEntities objectAtIndex:indexPath.row];
        BOOL success = [BookDetailService unFavBookWithId:entity.id];
        if (success) {
            [self.bookEntities removeObjectAtIndex:indexPath.row];
            [self.collectionView reloadData];
        }
    }
}

@end
