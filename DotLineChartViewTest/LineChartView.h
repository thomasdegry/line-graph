//
//  LineChartView.h
//  GraphTest
//
//  Created by LOANER on 4/26/15.
//  Copyright (c) 2015 Thomas Degry. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LineChartView;

@protocol LineChartViewDataSource <NSObject>

@required
- (NSUInteger)numberOfValuesInLineChartView:(LineChartView *)lineChartView;

@end


@protocol LineChartViewDelegate <NSObject>

@required
- (CGFloat)lineChartView:(LineChartView *)lineChartView verticalValueForHorizontalIndex:(NSUInteger)horizontalIndex;

@optional
- (UIEdgeInsets)paddingForLineChartView:(LineChartView *)lineChartView;

@end

@interface LineChartView : UIView

@property (nonatomic, weak) id<LineChartViewDelegate> delegate;
@property (nonatomic, weak) id<LineChartViewDataSource> dataSource;

@property (strong, nonatomic) UIView *headerView;
@property (strong, nonatomic) UIView *footerView;

- (void)reloadData;

@end
