//
//  LineChartView.m
//  GraphTest
//
//  Created by LOANER on 4/26/15.
//  Copyright (c) 2015 Thomas Degry. All rights reserved.
//

#import "LineChartView.h"

@interface LineChartView()

@property (strong, nonatomic) UIView *graphView;
@property (strong, nonatomic) NSMutableArray *sections;

@property (strong, nonatomic) UIBezierPath *graphPath;
@property (strong, nonatomic) CAShapeLayer *graphLayer;

@end

@implementation LineChartView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self construct];
        
        self.sections = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)construct {
    self.graphView = [[UIView alloc] initWithFrame:self.frame];
    self.graphView.backgroundColor = [UIColor blackColor];
    [self addSubview:self.graphView];
}

- (void)reloadData {
    // Get the number of points
    NSUInteger numberOfPoints = [self.dataSource numberOfValuesInLineChartView:self];
    
    // Get padding for graph
    UIEdgeInsets padding = UIEdgeInsetsMake(0, 0, 0, 0);
    if ([self.delegate respondsToSelector:@selector(paddingForLineChartView:)])
        padding = [self.delegate paddingForLineChartView:self];
    
    // Calculate the width / bar based on the screensize - padding left and right
    CGFloat widthPerBar = (self.bounds.size.width - padding.left - padding.right) / numberOfPoints;
    
    // Calculate the height per bar based on graphView height - padding top
    CGFloat heightForBar = self.graphView.frame.size.height - padding.top;
    CAShapeLayer *previousBar;
    for (NSInteger i = 0; i < numberOfPoints; i++) {
        CAShapeLayer *bar = [CAShapeLayer layer];
        
        CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
        CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
        CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
        UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
        
        if (previousBar)
            bar.frame = CGRectMake(previousBar.frame.origin.x + widthPerBar, padding.top, widthPerBar, heightForBar);
        else
            bar.frame = CGRectMake(padding.left, padding.top, widthPerBar, heightForBar);
        
        // Set the bar's background color
        bar.backgroundColor = color.CGColor;
        
        // Add the bar to the graph view's layer
        [self.graphView.layer addSublayer:bar];
        
        // Add it to the array
        [self.sections addObject:bar];
        
        previousBar = bar;
    }
    
    
    
    self.graphLayer = [CAShapeLayer layer];
    self.graphLayer.backgroundColor = [UIColor blueColor].CGColor;
    
    
    CGFloat maxValueForGraph = [self maxValue];
}

- (void)setHeaderView:(UIView *)headerView {
    // Remove possible old header view
    [self.headerView removeFromSuperview];
    
    _headerView = headerView;
    
    // Add the new one
    [self addSubview:headerView];
    
    // Update view frames
    [self updateGraphViewFrame];
}

- (void)setFooterView:(UIView *)footerView {
    // Remove possible old footer view
    [self.footerView removeFromSuperview];
    
    _footerView = footerView;
    
    // Add the new one
    [self addSubview:self.footerView];
    
    // Update View Frames
    [self updateGraphViewFrame];
}

- (void)updateGraphViewFrame {
    NSLog(@"[LineChartView] Setting view frames");
    self.headerView.frame = self.headerView.frame;
    
    self.graphView.frame = CGRectMake(0, self.headerView.frame.size.height, self.bounds.size.width, self.bounds.size.height - self.headerView.frame.size.height - self.footerView.frame.size.height);
    
    self.footerView.frame = CGRectMake(0, self.graphView.frame.origin.y + self.graphView.frame.size.height, self.footerView.frame.size.width, self.footerView.frame.size.height);
}

- (CGFloat)availableHeight {
    return self.bounds.size.height - self.headerView.frame.size.height - self.footerView.frame.size.height;
}

- (CGFloat)maxValue {
    CGFloat maxValue = 0;
    for (NSInteger i = 0; i < [self.dataSource numberOfValuesInLineChartView:self]; i++) {
        CGFloat valueForPoint = [self.delegate lineChartView:self verticalValueForHorizontalIndex:i];
        NSLog(@"value for point = %f", valueForPoint);
        if (valueForPoint > maxValue)
            maxValue = valueForPoint;
    }
    
    return maxValue;
}

@end
