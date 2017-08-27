//
//  BookAnalyticsViewController.m
//  BookShelf
//
//  Created by ShaoweiZhang on 24/7/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import "BookAnalyticsViewController.h"

#import "BookAnalyticsTableView.h"

#import "BookAnalyticsService.h"

#import "BookAnalyticsTableViewCell.h"
#import "BookAnalyticsTableViewCell+BookStatistic.h"

#import "UIColor+Array.h"

#import "BookAnalyticsChartView.h"
#import "BookAnalyticsChartView+BookStatistic.h"

#define kBackgroundHeight 270.5f
#define kNavigationHeight 64.0f

#define kChartViewRadius 90.0f
#define kChartViewInnerRadius 50.0f

@interface BookAnalyticsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) BookAnalyticsTableView *tableView;
@property (strong, nonatomic) BookAnalyticsChartView *chartView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *descLabel;

@property (strong, nonatomic) NSMutableArray<BookStatistic *> *sortedBookStatistics;

@end

@implementation BookAnalyticsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavigation];
    [self getData];
    [self initSubviews];
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

#pragma mark - Navigation
- (void)initNavigation
{
    self.navigationItem.title = @"My Favorite Authors";
}


#pragma mark - navigation config
- (BOOL)shouldShowShadowImage
{
    return NO;
}

- (UIImage *)navigationBarBackgroundImage
{
    return [UIImage new];
}

#pragma mark - Subviews
- (void)initSubviews
{
    // Background view
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), kBackgroundHeight)];
    backgroundView.backgroundColor = UIColorForRGB(0x009D82);
    [self.view addSubview:backgroundView];
    
    CGFloat minX = CGRectGetWidth(self.view.frame) / 2.0f - kChartViewRadius;
    CGFloat minY = (kBackgroundHeight - kNavigationHeight) / 2.0f - kChartViewRadius + kNavigationHeight;
    
    // ChartView
    self.chartView = [[BookAnalyticsChartView alloc] initWithFrame:CGRectMake(minX, minY, 2 * kChartViewRadius, 2 * kChartViewRadius)];
    self.chartView.radius = kChartViewRadius;
    self.chartView.innerRadius = kChartViewInnerRadius;
    [self.chartView configureWithBookStatistics:self.sortedBookStatistics];
    [self.view addSubview:self.chartView];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.font = [UIFont systemFontOfSize:28.0f];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.text = [NSString stringWithFormat:@"%@", @(self.sortedBookStatistics.count)];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.bounds = CGRectMake(0, 0, 100, 20);
    self.titleLabel.center = CGPointMake(self.chartView.center.x, self.chartView.center.y - 10);
    [self.view addSubview:self.titleLabel];
    
    self.descLabel = [[UILabel alloc] init];
    self.descLabel.backgroundColor = [UIColor clearColor];
    self.descLabel.font = [UIFont systemFontOfSize:16.0f];
    self.descLabel.textColor = UIColorForRGB(0x555555);
    self.descLabel.text = @"authors";
    self.descLabel.textAlignment = NSTextAlignmentCenter;
    self.descLabel.bounds = CGRectMake(0, 0, 100, 20);
    self.descLabel.center = CGPointMake(self.chartView.center.x, self.chartView.center.y + 15);
    [self.view addSubview:self.descLabel];
    
    // TableView
    self.tableView = [[BookAnalyticsTableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(backgroundView.frame), CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)- kBackgroundHeight) style:(UITableViewStylePlain)];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
}

#pragma mark - data

- (void)getData
{
    NSArray<BookStatistic *> *unsortedArray = [[BookAnalyticsService calculateStatisticWithMode:statisticModeAuthor] allValues];
    
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"count"
                                                 ascending:NO];
    self.sortedBookStatistics = [[unsortedArray sortedArrayUsingDescriptors:@[sortDescriptor]] mutableCopy];
    
    [self.tableView reloadData];
    self.titleLabel.text = [NSString stringWithFormat:@"%@", @(self.sortedBookStatistics.count)];
    [self.chartView setNeedsLayout];
}


#pragma mark - datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sortedBookStatistics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"bookAnalyticsTableViewCell";
    
    BookAnalyticsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[BookAnalyticsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.colorView.backgroundColor = [UIColor colorAtIndex:indexPath.row];
    BookStatistic *statistic = [self.sortedBookStatistics objectAtIndex:indexPath.row];
    [cell configureWithBookStatistic:statistic];
    
    return cell;
}

@end
