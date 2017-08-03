//
//  BookListTableViewController.m
//  BookShelf
//
//  Created by Ashley Han on 2/8/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import "BookListTableViewController.h"

#import "BookListService.h"
#import "BookDetailService.h"

#import "BookListTableViewCell.h"
#import "BookListTableViewCell+BookEntity.h"

#import "BookDetailViewController.h"

@interface BookListTableViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray<BookEntity *> *bookEntities;

@end

@implementation BookListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    [self initTableView];
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

#pragma mark - data

- (void)getData
{
    self.bookEntities = [[BookListService getAllBookEntities] mutableCopy];
    [self.tableView reloadData];
}

#pragma mark - subviews

- (void)initTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) style:UITableViewStylePlain];
    tableView.backgroundColor = UIColorForRGB(0xF9F9F9);
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    tableView.tableFooterView = [UIView new];
    tableView.dataSource = self;
    tableView.delegate = self;
    self.tableView = tableView;
    
    [self.view addSubview:tableView];
}

#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.bookEntities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"bookListTableViewCell";
    
    BookListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[BookListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    BookEntity *entity = [self.bookEntities objectAtIndex:indexPath.row];
    [cell configureWithBookEntity:entity];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        BookEntity *entity = [self.bookEntities objectAtIndex:indexPath.row];
        BOOL success = [BookDetailService unFavBookWithId:entity.id];
        if (success) {
            [tableView beginUpdates];
            [self.bookEntities removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [tableView endUpdates];
        }
    }
}

#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BookEntity *entity = [self.bookEntities objectAtIndex:indexPath.row];
    [self.delegate didSelectBookEntity:entity];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"Remove";
}

@end
