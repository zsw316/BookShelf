//
//  BookListCollectionViewCell.m
//  BookShelf
//
//  Created by Ashley Han on 3/8/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import "BookListCollectionViewCell.h"

@interface BookListCollectionViewCell ()

@property (strong, nonatomic) UIButton *deleteButton;

@property (assign, nonatomic) BOOL editing;

@end

@implementation BookListCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
    }
    
    return self;
}

#pragma mark - Subviews

- (void)initSubViews
{
    self.backgroundColor = UIColorForRGB(0xF9F9F9);
    
    self.coverImageView = [[UIImageView alloc] init];
    self.coverImageView.backgroundColor = [UIColor whiteColor];
    self.coverImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.coverImageView];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    self.titleLabel.textColor = UIColorForRGB(0x555555);
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.titleLabel.numberOfLines = 2;
    [self.contentView addSubview:self.titleLabel];
    
    self.deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.deleteButton setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
    [self.deleteButton sizeToFit];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapDeleteButton)];
    [self.deleteButton addGestureRecognizer:tapGesture];
    [self.deleteButton setHidden:YES];
    [self addSubview:self.deleteButton];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_coverImageView(==93)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_coverImageView)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_titleLabel]-(>=0)-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_titleLabel)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_coverImageView(==126)]-5-[_titleLabel]-(>=0)-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_coverImageView, _titleLabel)]];
    
    UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(didLongPressCell:)];
    [self.contentView addGestureRecognizer:gesture];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.deleteButton.center = CGPointMake(CGRectGetMaxX(self.contentView.frame), CGRectGetMinY(self.contentView.frame));
}

- (void)endEditing
{
    if (!self.editing) {
        return;
    }
    
    self.editing = NO;
    [self.deleteButton setHidden:YES];
}

-(void)prepareForReuse
{
    self.coverImageView.image = nil;
    self.titleLabel.text = nil;
    [self.deleteButton setHidden:YES];
}

#pragma mark - button action

- (void)didTapDeleteButton
{
    [self.delegate collectionViewCell:self didDeleteCellAtIndexPath:self.indexPath];
}

#pragma mark - gesture

- (void)didLongPressCell:(UILongPressGestureRecognizer *)gesture
{
    self.editing = YES;
    [self.deleteButton setHidden:NO];
}

#pragma mark - pointInside

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    if ([self.deleteButton pointInside:[self convertPoint:point toView:self.deleteButton] withEvent:event]) {
        return YES;
    }
    
    return [super pointInside:point withEvent:event];
}

@end
