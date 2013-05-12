//
//  StatisticsViewController.m
//  Study With Friends
//
//  Created by Max Bucci on 5/7/13.
//  Copyright (c) 2013 Sharif Younes. All rights reserved.
//

#import "StatisticsViewController.h"

@interface StatisticsViewController ()

@end

@implementation StatisticsViewController

@synthesize pieChart = _pieChart;
@synthesize gameLabel1 = _gameLabel1;
@synthesize gameLabel2 = _gameLabel2;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



//Drawing of PieChart courtesy of Dain Kaplan via Chartreuse.com and StackOverflow.com
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.pieChart clearItems];
	
    [self.pieChart setGradientFillStart:0.1 andEnd:1.0];
    [self.pieChart setGradientFillColor:PieChartItemColorMake(0.0, 0.0, 0.0, 0.7)];
    
	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    UINavigationItem *item = [self.navigationController.navigationBar.items lastObject];
    item.title = @"Statistics";
    item.leftBarButtonItem = nil;
    
    [self.pieChart clearItems];
    Game *temp = [self.statisticsGamesDelegate objectAtIndex:0];
    double fraction = 0;
    double total = 0;
    int gamesPlayed = 0;
    for (int i = 0; i < self.statisticsGamesDelegate.count; i++) {
        fraction += temp.amtCorrect;
        if (temp.played) {
            gamesPlayed ++;
            total += temp.amtQuestions;
        }
    }
    
    if (gamesPlayed == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You Haven't Played Any Games Yet!"
                                                        message:@"Come back after completing a game to view your statistics"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        [alert show];

    }

    self.gameLabel1.text = [NSString stringWithFormat:@"Total Questions Answered: %d", (int)total];
    self.gameLabel2.text = [NSString stringWithFormat:@"Total Questions Correct: %d", (int)fraction];
    self.gameLabel3.text = [NSString stringWithFormat:@"Games played: %d", gamesPlayed];
    
    fraction = fraction / total;
    
    if (gamesPlayed)
        self.percentLabel.text = [NSString stringWithFormat:@"%d%%", (int)(100 *fraction)];
    
	[self.pieChart addItemValue:fraction withColor:PieChartItemColorMake(0.5, 1.0, 0.5, 0.8)];
	[self.pieChart addItemValue:1-fraction withColor:PieChartItemColorMake(1.0, 0.1, 0.1, 1.0)];

    
    [self.pieChart setNeedsDisplay];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
