//
//  MainViewController.m
//  Zalo-W01-Memory Management
//
//  Created by CPU12163 on 3/4/20.
//  Copyright © 2020 CPU12163. All rights reserved.
//

#import "MainViewController.h"
#import "SafeMutableArray.h"

@interface MainViewController () {
    __weak IBOutlet UIStackView *mStackView;
}

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SafeMutableArray *array = [[SafeMutableArray alloc] initWithArray:@[@"Alo", @"Hello", @"This is my room"]];
    
    NSThread *thread = [[NSThread alloc] initWithBlock:^{
        for (int i  = 0; i < 100; i++) {
            [array addObject:[NSString stringWithFormat:@"%d", i]];
        }
    }];
    
    NSThread *secondThread = [[NSThread alloc] initWithBlock:^{
        for (int i = 101; i < 200; i++) {
            [array addObject:[NSString stringWithFormat:@"%d", i]];
        }
        
        for (int i = 0; i < array.count; i++) {
            NSLog(@"TON HIEU: %@", [array objectAtIndex:i]);
        }
    }];
    
    [thread start];
    [secondThread start];
}




@end
