//
//  UIColor+Array.m
//  BookShelf
//
//  Created by Ashley Han on 3/8/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import "UIColor+Array.h"

@implementation UIColor (Array)

+ (UIColor *)colorAtIndex:(NSUInteger)index
{
    NSArray *colors = @[
                        [UIColor blackColor],
                        [UIColor yellowColor],
                        [UIColor greenColor],
                        [UIColor redColor],
                        [UIColor blueColor],
                        [UIColor orangeColor],
                        [UIColor purpleColor],
                        [UIColor brownColor],
                        [UIColor cyanColor]
                        ];
    
    return [colors objectAtIndex:(index % colors.count)];
}

@end
