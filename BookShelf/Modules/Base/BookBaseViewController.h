//
//  BookViewController.h
//  BookShelf
//
//  Created by ShaoweiZhang on 28/7/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookBaseViewController : UIViewController

- (UIImage *)navigationBarBackgroundImage;
- (BOOL)shouldShowShadowImage;
- (BOOL)shouldHideBottomBarWhenPushed;

@end
