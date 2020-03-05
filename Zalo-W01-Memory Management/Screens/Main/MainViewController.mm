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
    NSMutableArray *mArray;
    SafeMutableArray *mSafeArray;
}

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    mArray = [[NSMutableArray alloc] init];
    mSafeArray = [[SafeMutableArray alloc] init];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        
    for (int i = 0; i < 10; i++) {
        dispatch_sync(queue, ^{
            [self->mSafeArray addObject:[NSString stringWithFormat:@"Element %d", i + 1]];
        });
    }
    
    sleep(5);
    
    NSLog(@"Print array:");
    for (int i = 0; i < [mSafeArray count]; i++) {
        NSLog(@"Array[%d] = %@", i, [mSafeArray objectAtIndex:i]);
    }
}

@end
