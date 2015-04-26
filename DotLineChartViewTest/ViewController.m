//
//  ViewController.m
//  DotLineChartViewTest
//
//  Created by LOANER on 4/26/15.
//  Copyright (c) 2015 Thomas Degry. All rights reserved.
//

#import "ViewController.h"
#import "LineChartView.h"

@interface ViewController () <LineChartViewDataSource, LineChartViewDelegate>

@property (strong, nonatomic) NSArray *graphData;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)loadView {
    [super loadView];
    
    self.graphData = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.093], [NSNumber numberWithFloat:0.033], [NSNumber numberWithFloat:0.075], [NSNumber numberWithFloat:0.072], [NSNumber numberWithFloat:0.041], [NSNumber numberWithFloat:0.071], [NSNumber numberWithFloat:0.098], nil];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 30)];
    headerView.backgroundColor = [UIColor yellowColor];
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50)];
    footerView.backgroundColor = [UIColor orangeColor];
    
    LineChartView *lineChart = [[LineChartView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 250)];
    lineChart.delegate = self;
    lineChart.dataSource = self;
    lineChart.footerView = footerView;
    lineChart.headerView = headerView;
    [self.view addSubview:lineChart];
    
    [lineChart reloadData];
}

- (NSUInteger)numberOfValuesInLineChartView:(LineChartView *)lineChartView {
    return 7;
}

- (CGFloat)lineChartView:(LineChartView *)lineChartView verticalValueForHorizontalIndex:(NSUInteger)horizontalIndex {
    return [[self.graphData objectAtIndex:horizontalIndex] floatValue];
}

// pragma mark: - Delegate methods
- (UIEdgeInsets)paddingForLineChartView:(LineChartView *)lineChartView {
    return UIEdgeInsetsMake(80, 10, 0, 10);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
