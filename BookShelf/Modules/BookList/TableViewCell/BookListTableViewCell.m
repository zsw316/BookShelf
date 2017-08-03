//
//  BookListTableViewCell.m
//  BookShelf
//
//  Created by Ashley Han on 3/8/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import "BookListTableViewCell.h"

@implementation BookListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self initSubviews];
    }
    
    return self;
}

- (void)initSubviews
{
    self.contentView.backgroundColor = UIColorForRGB(0xF9F9F9);
    
    self.coverImageView = [[UIImageView alloc] init];
    self.coverImageView.backgroundColor = [UIColor whiteColor];
    self.coverImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.coverImageView];
    
    self.authorLabel = [[UILabel alloc] init];
    self.authorLabel.font = [UIFont systemFontOfSize:13.0f];
    self.authorLabel.textColor = UIColorForRGB(0x999999);
    self.authorLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.authorLabel];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    self.titleLabel.textColor = UIColorForRGB(0x555555);
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.titleLabel];
    
    self.tagsView = [[UIView alloc] init];
    self.tagsView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.tagsView];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_coverImageView, _authorLabel, _titleLabel, _tagsView);
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_coverImageView(==50)]-15-[_titleLabel]-(>=15)-|" options:NSLayoutFormatAlignAllTop metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[_coverImageView(==70)]" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[_titleLabel]-6-[_authorLabel]-10-[_tagsView(==18)]" options:NSLayoutFormatAlignAllLeft metrics:nil views:views]];
    
}

- (void)prepareForReuse
{
    self.titleLabel.text = nil;
    self.coverImageView.image = nil;
    self.authorLabel.text = nil;
    
    [self.tagsView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

@end
