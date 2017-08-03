//
//  BookNavigationController.m
//  BookShelf
//
//  Created by ShaoweiZhang on 28/7/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import "BookBaseNavigationController.h"
#import "BookBaseViewController.h"

@interface BookBaseNavigationController ()

@end

@implementation BookBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[UINavigationBar appearance] setBarTintColor:UIColorForRGB(0x009D82)];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([viewController isKindOfClass:[BookBaseViewController class]]) {
        viewController.hidesBottomBarWhenPushed = [(BookBaseViewController *)viewController shouldHideBottomBarWhenPushed];
    } else {
        
    }
    
    [super pushViewController:viewController animated:animated];
}

@end
