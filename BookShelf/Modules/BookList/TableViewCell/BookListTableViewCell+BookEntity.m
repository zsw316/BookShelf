//
//  BookListTableViewCell+BookEntity.m
//  BookShelf
//
//  Created by Ashley Han on 3/8/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import "BookListTableViewCell+BookEntity.h"

#import <UIImageView+WebCache.h>
#import "BookEntity.h"
#import "BookAuthor.h"
#import "BookTag.h"

@implementation BookListTableViewCell (BookEntity)

- (void)configureWithBookEntity:(BookEntity *)bookEntity
{
    self.titleLabel.text = bookEntity.title;
    
    NSString *authorList = @"";
    for (BookAuthor *author in bookEntity.authors) {
        authorList = [[authorList stringByAppendingString:author.name] stringByAppendingString:@" "];
    }
    
    self.authorLabel.text = [NSString stringWithFormat:@"%@", authorList];
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:bookEntity.image]];
    
    UIView *lastDockView = self.tagsView;
    for (NSInteger i = 0; i< MIN(bookEntity.tags.count, 4); i++) {
        BookTag *tag = [bookEntity.tags objectAtIndex:i];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitleColor:UIColorForRGB(0x999999) forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:9.0f];
        button.layer.cornerRadius = 2.0f;
        button.layer.borderColor = UIColorForRGB(0x999999).CGColor;
        button.layer.borderWidth = 0.5f;
        button.translatesAutoresizingMaskIntoConstraints = NO;
        [button setContentEdgeInsets:UIEdgeInsetsMake(3.0f, 5.0f, 3.0f, 5.0f)];
        [button setTitle:tag.name forState:UIControlStateNormal];
        [button sizeToFit];
        [self.tagsView addSubview:button];
        
        if ([lastDockView isEqual:self.tagsView]) {
            [self.tagsView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[button]" options:NSLayoutFormatAlignAllCenterY metrics:nil views:NSDictionaryOfVariableBindings(button)]];
            
            [self.tagsView addConstraint:[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.tagsView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
        } else {
            [self.tagsView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[lastDockView]-8-[button]" options:NSLayoutFormatAlignAllCenterY metrics:nil views:NSDictionaryOfVariableBindings(lastDockView, button)]];
        }
        
        lastDockView = button;
    }
    
    if (![lastDockView isEqual:self.tagsView]) {
        [self.tagsView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[lastDockView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(lastDockView)]];
    }
}

@end
