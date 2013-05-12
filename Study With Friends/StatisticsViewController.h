//
//  StatisticsViewController.h
//  Study With Friends
//
//  Created by Max Bucci on 5/7/13.
//  Copyright (c) 2013 Sharif Younes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PieChartView.h"
#import "Game.h"

@interface StatisticsViewController : UIViewController

@property (nonatomic, retain) IBOutlet PieChartView *pieChart;
@property (nonatomic, strong) NSArray *statisticsGamesDelegate;
@property (weak, nonatomic) IBOutlet UILabel *gameLabel1;
@property (weak, nonatomic) IBOutlet UILabel *gameLabel2;
@property (weak, nonatomic) IBOutlet UILabel *gameLabel3;
@property (weak, nonatomic) IBOutlet UILabel *percentLabel;

@end
