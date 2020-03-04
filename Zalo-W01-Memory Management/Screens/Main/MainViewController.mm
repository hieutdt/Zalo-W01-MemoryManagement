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
    
    for (int i = 0; i < array.count; i++) {
        UILabel *label = [[UILabel alloc] init];
        label.text = [array objectAtIndex:i];
        
        [mStackView addArrangedSubview:label];
    }
}

@end
