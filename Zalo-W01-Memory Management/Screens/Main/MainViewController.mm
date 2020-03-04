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
    
    NSMutableArray* nextPositions;
    NSMutableArray* currentPositions;
}

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    nextPositions = [[NSMutableArray alloc] init];
    currentPositions = [[NSMutableArray alloc] init];
    
    [self compute];
}

- (void)compute {
    NSMutableArray* tmp = nextPositions;
    nextPositions = currentPositions;
    currentPositions = tmp;
}


@end
