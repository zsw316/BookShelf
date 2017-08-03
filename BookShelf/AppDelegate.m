//
//  AppDelegate.m
//  BookShelf
//
//  Created by Ashley Han on 24/7/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import "AppDelegate.h"
#import "BookListViewController.h"
#import "BookScannerViewController.h"
#import "BookAnalyticsViewController.h"
#import "BookBaseNavigationController.h"

#import "BookDBHelper.h"
#import "TestDataHelper.h"

@interface AppDelegate () <UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self initTabBar];
    
    [self initDB];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma  mark

- (void)initDB
{
    NSString *dbPath = [BookDBHelper dbPath];
    
    BOOL dbExist = [[NSFileManager defaultManager] fileExistsAtPath:dbPath isDirectory:nil];
    if (!dbExist) {
        [BookDBHelper buildDataBase];

#ifdef DEBUG
        [TestDataHelper buildTestData];
#endif
    }
    
#ifdef DEBUG
    NSLog(@"dbpath: %@", dbPath);
#endif
}

#pragma mark - TabBar

- (void)initTabBar {
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.delegate = self;
    
    tabBarController.tabBar.barTintColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    tabBarController.tabBar.tintColor = [UIColor colorWithRed:0 green:157/255.0 blue:130/255.0 alpha:1];
    
    BookListViewController *bookListViewController = [[BookListViewController alloc] init];
    BookBaseNavigationController *bookListNavigationController = [[BookBaseNavigationController alloc] initWithRootViewController:bookListViewController];
    bookListViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Books" image:[UIImage imageNamed:@"tabbar-icon-collection"] tag:0];
    
    BookScannerViewController *bookScannerViewController = [[BookScannerViewController alloc] init];
    bookScannerViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Scan" image:[UIImage imageNamed:@"tabbar-icon-scan"] tag:0];
    
    BookAnalyticsViewController *bookAnalyticsViewController = [[BookAnalyticsViewController alloc] init];
    BookBaseNavigationController *bookAnalyticsNavigationController = [[BookBaseNavigationController alloc] initWithRootViewController:bookAnalyticsViewController];
    bookAnalyticsViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Me" image:[UIImage imageNamed:@"tabbar-icon-me"] tag:0];
    
    tabBarController.viewControllers = @[bookListNavigationController, bookScannerViewController, bookAnalyticsNavigationController];
    
    tabBarController.tabBar.itemPositioning = UITabBarItemPositioningCentered;
    
    self.window.rootViewController = tabBarController;
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    if ([viewController isKindOfClass:[BookScannerViewController class]]) {
        BookScannerViewController *bookScannerViewController = [[BookScannerViewController alloc] init];
        BookBaseNavigationController *navController = [[BookBaseNavigationController alloc] initWithRootViewController:bookScannerViewController];
        [self.window.rootViewController presentViewController:navController animated:YES completion:nil];
        
        return NO;
    }
    
    return YES;
}

@end
