//
//  BookListViewController.m
//  BookShelf
//
//  Created by ShaoweiZhang on 24/7/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import "BookListViewController.h"

#import "BookListTableViewController.h"
#import "BookListCollectionViewController.h"

#import "BookListActionDelegate.h"

#import "BookDetailViewController.h"

typedef NS_ENUM(NSUInteger, BookListMode) {
    BookListModelTableView,
    BookListModelCollectionView
};

@interface BookListViewController () <BookListActionDelegate>

@property (assign, nonatomic) BookListMode mode;
@end

@implementation BookListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavigation];
    
    self.mode = BookListModelTableView;
    
    [self switchToMode:self.mode];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (void)initNavigation
{
    self.navigationItem.title =@"My books";
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"list-switch-collection"] style:UIBarButtonItemStylePlain target:self action:@selector(didTapSwitchButton:)];
}

- (void)didTapSwitchButton:(UIBarButtonItem *)barButtonItem
{
    // Remove child ViewControllers
    [self.childViewControllers makeObjectsPerformSelector:@selector(willMoveToParentViewController:) withObject:nil];
    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.childViewControllers makeObjectsPerformSelector:@selector(removeFromParentViewController)];
    [self.childViewControllers makeObjectsPerformSelector:@selector(didMoveToParentViewController:) withObject:nil];
    
    if (self.mode == BookListModelTableView) {
        self.mode = BookListModelCollectionView;
        self.navigationItem.rightBarButtonItem.image = [UIImage imageNamed:@"list-switch-table"];
    } else {
        self.mode = BookListModelTableView;
        self.navigationItem.rightBarButtonItem.image = [UIImage imageNamed:@"list-switch-collection"];
    }
    
    [self switchToMode:self.mode];
}

- (void)switchToMode: (BookListMode)mode
{
    if (mode == BookListModelTableView) {
        BookListTableViewController *controller = [[BookListTableViewController alloc] init];
        controller.delegate = self;
        [controller willMoveToParentViewController:self];
        [self addChildViewController:controller];
        [self.view addSubview:controller.view];
        controller.view.frame = self.view.bounds;
        [controller didMoveToParentViewController:self];
    } else {
        BookListCollectionViewController *controller = [[BookListCollectionViewController alloc] init];
        controller.delegate = self;
        [controller willMoveToParentViewController:self];
        [self addChildViewController:controller];
        [self.view addSubview:controller.view];
        controller.view.frame = self.view.bounds;
        [controller didMoveToParentViewController:self];
    }
}

#pragma mark - BookListActionDelegate 

- (void)didSelectBookEntity:(BookEntity *)bookEntity
{
    BookDetailViewController *controller = [[BookDetailViewController alloc] init];
    [controller setBookEntity:bookEntity];
    
    [self.navigationController pushViewController:controller animated:YES];
}

@end
