//
//  BookDetailViewController.m
//  BookShelf
//
//  Created by ShaoweiZhang on 31/7/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import "BookDetailViewController.h"
#import "BookAuthor.h"
#import "BookTranslator.h"
#import "BookTag.h"
#import <UIImageView+WebCache.h>

#import "BookDetailService.h"

#define kBackgroundHeight 270.5f 
#define kNavHeight 64.0f

@interface BookDetailViewController () <UIScrollViewDelegate>

@property (strong, nonatomic) UIImageView *backgroundImageView;

@end

@implementation BookDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self initNavigation];
    [self initSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation
- (void)initNavigation {
    self.navigationItem.title = @"Book Details";
}

- (UIImage *)navigationBarBackgroundImage {
    return [UIImage new];
}

- (BOOL)shouldShowShadowImage {
    return NO;
}

- (BOOL)shouldHideBottomBarWhenPushed {
    return YES;
}

#pragma mark - subviews

- (void)initSubviews {
    [self initBackgroundView];
    [self initScrollView];
}

- (void)initBackgroundView {
    self.backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"detail-topbg"]];
    self.backgroundImageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), kBackgroundHeight);
    self.backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.backgroundImageView];
}

- (void)initScrollView {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kNavHeight, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - kNavHeight)];
    scrollView.alwaysBounceVertical = YES;
    scrollView.delegate = self;
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:scrollView];
    
    // Head
    UIView *headView = [[UIView alloc] init];
    headView.translatesAutoresizingMaskIntoConstraints = NO;
    [scrollView addSubview:headView];
    
    [scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[headView(==206.5)]" options:NSLayoutFormatAlignAllCenterX metrics:nil views:NSDictionaryOfVariableBindings(headView)]];
    [scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[headView(==scrollView)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(headView, scrollView)]];
    
    // Cover
    UIImageView *coverImageView = [[UIImageView alloc] init];
    coverImageView.translatesAutoresizingMaskIntoConstraints = NO;
    coverImageView.backgroundColor = [UIColor whiteColor];
    [coverImageView sd_setImageWithURL:[NSURL URLWithString:self.bookEntity.image]];
    [headView addSubview:coverImageView];
    
    [headView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-16-[coverImageView(==115)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(coverImageView)]];
    [headView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-16-[coverImageView(==161)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(coverImageView)]];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    titleLabel.text = self.bookEntity.title;
    titleLabel.font = [UIFont systemFontOfSize:17.0f];
    titleLabel.textColor = [UIColor whiteColor];
    [headView addSubview:titleLabel];
    
    [headView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[coverImageView]-14-[titleLabel]-(>=15)-|" options:NSLayoutFormatAlignAllTop metrics:nil views:NSDictionaryOfVariableBindings(coverImageView, titleLabel)]];
    
    // Detail information
    NSMutableArray *itemsText = [@[] mutableCopy];
    
    if (self.bookEntity.authors) {
        NSString *authorList = @"";
        for (BookAuthor *author in self.bookEntity.authors) {
            authorList = [[authorList stringByAppendingString:author.name] stringByAppendingString:@" "];
        }
        [itemsText addObject:[NSString stringWithFormat:@"Author: %@", authorList]];
    }
    
    if (self.bookEntity.translators) {
        NSString *translatorList = @"";
        for (BookTranslator *translator in self.bookEntity.translators) {
            translatorList = [[translatorList stringByAppendingString:translator.name] stringByAppendingString:@" "];
        }
        
        [itemsText addObject:[NSString stringWithFormat:@"Translator: %@", translatorList]];
    }
    
    if (self.bookEntity.publisher) {
        [itemsText addObject:[NSString stringWithFormat:@"Publisher: %@", self.bookEntity.publisher]];
    }
    
    if (self.bookEntity.pubdate) {
        [itemsText addObject:[NSString stringWithFormat:@"Date: %@", self.bookEntity.pubdate]];
    }
    
    if (self.bookEntity.price) {
        [itemsText addObject:[NSString stringWithFormat:@"Price: %@", self.bookEntity.price]];
    }
    
    if (self.bookEntity.isbn13) {
        [itemsText addObject:[NSString stringWithFormat:@"ISBN: %@", self.bookEntity.isbn13]];
    } else if (self.bookEntity.isbn10) {
        [itemsText addObject:[NSString stringWithFormat:@"ISBN: %@", self.bookEntity.isbn10]];
    }
    
    __block UILabel *lastLabel = titleLabel;
    
    [itemsText enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *itemLabel = [[UILabel alloc] init];
        itemLabel.translatesAutoresizingMaskIntoConstraints = NO;
        itemLabel.text = obj;
        itemLabel.font = [UIFont systemFontOfSize:11.0f];
        itemLabel.textColor = [UIColor whiteColor];
        [headView addSubview:itemLabel];
        
        [headView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[coverImageView]-14-[itemLabel]-(>=15)-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(coverImageView, itemLabel)]];
        [headView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[lastLabel]-4-[itemLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(lastLabel, itemLabel)]];
        lastLabel = itemLabel;
    }];
    
    UIButton *favButton = [UIButton buttonWithType:UIButtonTypeCustom];
    favButton.translatesAutoresizingMaskIntoConstraints = NO;
    favButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [favButton setBackgroundColor:[UIColor whiteColor]];
    [favButton setTitle:@"Favorite" forState:UIControlStateNormal];
    [favButton setTitle:@"Favorited" forState:UIControlStateDisabled];
    [favButton setTitleColor:UIColorForRGB(0x00A25B) forState:UIControlStateNormal];
    [favButton setTitleColor:UIColorForRGB(0xB8B8B8) forState:UIControlStateDisabled];
    favButton.layer.cornerRadius = 2.0f;
    [favButton addTarget:self action:@selector(didTapFavButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [headView addSubview:favButton];
    
    // Check the book is already favorited
    BookEntity *bookEntity = [BookDetailService searchFavedBookWithDoubanId:self.bookEntity.doubanId];
    if (bookEntity) {
        favButton.enabled = NO;
    }
    
    [headView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[coverImageView]-14-[favButton(==70)]" options:NSLayoutFormatAlignAllBottom metrics:nil views:NSDictionaryOfVariableBindings(coverImageView, favButton)]];
    [headView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[favButton(==27)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(favButton)]];
    
    // Bottom
    UIView *bodyView = [[UIView alloc] init];
    bodyView.translatesAutoresizingMaskIntoConstraints = NO;
    bodyView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:bodyView];
    
    [scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[bodyView(==scrollView)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(bodyView, scrollView)]];
    [scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[headView]-0-[bodyView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(headView, bodyView)]];
    
    UILabel *summaryLabel = [[UILabel alloc] init];
    summaryLabel.text = @"Summary";
    summaryLabel.font = [UIFont systemFontOfSize:16.0f];
    summaryLabel.textColor = UIColorForRGB(0x555555);
    summaryLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [bodyView addSubview:summaryLabel];
    
    UILabel *detailLabel = [[UILabel alloc] init];
    detailLabel.numberOfLines = 0;
    detailLabel.text = self.bookEntity.summary;
    detailLabel.font = [UIFont systemFontOfSize:15.0f];
    detailLabel.textColor = UIColorForRGB(0x999999);
    detailLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [bodyView addSubview:detailLabel];
    
    [bodyView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[summaryLabel]-6.5-[detailLabel]-15-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(summaryLabel, detailLabel)]];
    [bodyView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[summaryLabel]-15-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(summaryLabel)]];
    [bodyView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[detailLabel]-15-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(detailLabel)]];
}

#pragma mark - scroll response
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y < 0) {
        self.backgroundImageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), kBackgroundHeight - scrollView.contentOffset.y);
    } else {
        self.backgroundImageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), kBackgroundHeight);
    }
}

#pragma mark - actions

- (void)didTapFavButton:(UIButton *)button {
    long long bookId = [BookDetailService favBook:self.bookEntity];
    if (bookId > 0) {
        [button setEnabled:NO];
    }
}

@end
