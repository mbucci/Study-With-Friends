//
//  CoursesTableViewController.m
//  Study With Friends
//
//  Created by Max Bucci on 4/16/13.
//  Copyright (c) 2013 Sharif Younes. All rights reserved.
//

#import "CoursesTableViewController.h"
#import "StatisticsViewController.h"

@interface CoursesTableViewController ()

@property (nonatomic, weak) UINavigationItem *controllersNavigationBar;

@end

@implementation CoursesTableViewController

@synthesize controllersNavigationBar = _controllersNavigationBar;
@synthesize userDelegate = _userDelegate;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    self.controllersNavigationBar = [self.navigationController.navigationBar.items lastObject];
    self.controllersNavigationBar.title = @"Play Game";
    
    /*
    NSArray *controllers =  self.tabBarController.viewControllers;
    StatisticsViewController *SVC = [[StatisticsViewController alloc]init];
    for (id obj in controllers) {
        if ([obj isKindOfClass:[StatisticsViewController class]]) {
            SVC = obj;
            SVC.statisticsGamesDelegate = self.userDelegate.userGames.games;
        }
    }
     */

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidAppear:(BOOL)animated
{
    self.controllersNavigationBar.title = @"Play Game";
    [self.controllersNavigationBar setHidesBackButton:YES];
    self.controllersNavigationBar.leftBarButtonItem = self.editButtonItem;
    [self.tableView reloadData];
        
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isKindOfClass:[UITableViewCell class] ]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        if (indexPath) {
            if ([segue.destinationViewController isKindOfClass:[GameViewController class]]) {
                GameViewController *GVC = segue.destinationViewController;
                GVC.gameDelegate = [self.userDelegate.userGames getGameForIndex:indexPath.row andSection:indexPath.section];
                GVC.gameIndex = indexPath.row;

            }
            if ([segue.destinationViewController isKindOfClass:[ResultsViewController class]]) {
                ResultsViewController *RVC = [segue destinationViewController];
            
                Game *temp = [self.userDelegate.userGames.games objectAtIndex:indexPath.row];
                RVC.userAnswers = temp.userAnswers;
                RVC.gamePlayed = temp;
                RVC.gameIndex = indexPath.row;
            }
        }
    }
}


- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([sender isKindOfClass:[UITableViewCell class] ]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        if (indexPath) {
            Game *temp = [self.userDelegate.userGames getGameForIndex:indexPath.row andSection:indexPath.section];
            if ([identifier isEqualToString:@"game"]) {
                if (temp.played) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You've Already Played That Game!"
                                                                    message:@"Go to Statistics to view a breakdown of all your games, or hit the blue button next to your score to view your results"
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil, nil];
                    [alert show];
                    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
                    return NO;
                }
            }
            if ([identifier isEqualToString:@"results"]) {
                if (!temp.played) {
                    return YES;
                }
            }
        }
    }
    return YES;
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.userDelegate.userGames getNumberOfCourses];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *course = [self.userDelegate.userGames getCourseForCourseSection:section];
    return [self.userDelegate.userGames getGamesPerCourse:course];
}


- (NSString *)titleForRow:(NSUInteger)row AndSection:(NSUInteger)section
{
    Game *temp = [self.userDelegate.userGames getGameForIndex:row andSection:section];
    return temp.title;
}


- (NSString *)subtitleForRow:(NSUInteger)row AndSection:(NSUInteger)section
{
    Game *temp = [self.userDelegate.userGames getGameForIndex:row andSection:section];
    NSString *fraction = [NSString stringWithFormat:@"%d/%d", temp.amtCorrect, temp.amtQuestions];
    NSString *returnString = [NSString stringWithFormat:@"Score: %@", fraction];
    if (temp.played) {
        return returnString;
    } else {
        return @"Play Now";
    }
    
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    Game *temp = [self.userDelegate.userGames.games objectAtIndex:section];
    return temp.course;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Game *temp = [self.userDelegate.userGames getGameForIndex:indexPath.row andSection:indexPath.section];
    static NSString *CellIdentifier = @"Courses";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = [self titleForRow:indexPath.row AndSection:indexPath.section];
    cell.detailTextLabel.text = [self subtitleForRow:indexPath.row AndSection:indexPath.section];
    if (temp.played) {
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    } else {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/
/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
