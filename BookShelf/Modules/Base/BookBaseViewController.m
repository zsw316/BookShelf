//
//  BookViewController.m
//  BookShelf
//
//  Created by ShaoweiZhang on 28/7/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import "BookBaseViewController.h"

@interface BookBaseViewController ()

@end

@implementation BookBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self adjustNavigator];
}

#pragma mark - navigation config

- (void)adjustNavigator {
    // Set shadow image
    if ([self shouldShowShadowImage]) {
        [self.navigationController.navigationBar setShadowImage:nil];
    } else {
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
        [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    }
    
    // Set navigation background image
    if ([self navigationBarBackgroundImage]) {
        [self.navigationController.navigationBar setBackgroundImage:[self navigationBarBackgroundImage] forBarMetrics:UIBarMetricsDefault];
    } else {
        self.navigationController.navigationBar.barTintColor = UIColorForRGB(0x009D82);
        [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    }
}

- (UIImage *)navigationBarBackgroundImage {
    return nil;
}

- (BOOL)shouldShowShadowImage {
    return NO;
}

- (BOOL)shouldHideBottomBarWhenPushed {
    return NO;
}

@end
