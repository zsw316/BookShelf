//
//  BookAnalyticsTableViewCell.m
//  BookShelf
//
//  Created by Ashley Han on 3/8/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import "BookAnalyticsTableViewCell.h"

@implementation BookAnalyticsTableViewCell

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
    
    CGFloat colorViewWidth = 5.0f;
    self.colorView = [[UIView alloc] init];
    self.colorView.backgroundColor = [UIColor redColor];
    self.colorView.translatesAutoresizingMaskIntoConstraints = NO;
    self.colorView.layer.cornerRadius = colorViewWidth / 2.0f;
    [self.contentView addSubview:self.colorView];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    self.titleLabel.textColor = UIColorForRGB(0x555555);
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.titleLabel];
    
    self.detailLabel = [[UILabel alloc] init];
    self.detailLabel.font = [UIFont systemFontOfSize:13.0f];
    self.detailLabel.textColor = UIColorForRGB(0x999999);
    self.detailLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.detailLabel];
    
    self.percentageLabel = [[UILabel alloc] init];
    self.percentageLabel.font = [UIFont systemFontOfSize:16.0f];
    self.percentageLabel.textColor = UIColorForRGB(0x555555);
    self.percentageLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.percentageLabel];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_colorView(==5)]-5-[_titleLabel]-8-[_detailLabel]" options:NSLayoutFormatAlignAllCenterY metrics:nil views:NSDictionaryOfVariableBindings(_colorView, _titleLabel, _detailLabel)]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.colorView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:0 constant:colorViewWidth]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_percentageLabel]-15-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:NSDictionaryOfVariableBindings(_percentageLabel)]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.percentageLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
}

- (void)prepareForReuse
{
    self.titleLabel.text = nil;
    self.detailLabel.text = nil;
    self.percentageLabel.text = nil;
}

@end
