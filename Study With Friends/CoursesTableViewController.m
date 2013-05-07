//
//  CoursesTableViewController.m
//  Study With Friends
//
//  Created by Max Bucci on 4/16/13.
//  Copyright (c) 2013 Sharif Younes. All rights reserved.
//

#import "CoursesTableViewController.h"

@interface CoursesTableViewController ()

@end

@implementation CoursesTableViewController

@synthesize segueType = _segueType;
@synthesize gamesArray = _gamesArray;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

-(StudyGames *)gamesArray
{
    if (!_gamesArray) {
        _gamesArray = [[StudyGames alloc]init];
    }
    return _gamesArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    UINavigationItem *item = [self.navigationController.navigationBar.items lastObject];
    item.title = @"Courses";
    [item setHidesBackButton:YES];
    item.leftBarButtonItem = self.editButtonItem;

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isKindOfClass:[UITableViewCell class] ]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        if (indexPath) {
            if ([segue.destinationViewController isKindOfClass:[GameViewController class]]) {
                GameViewController *GVC = segue.destinationViewController;
                GVC.gameDelegate = [self.gamesArray getGameForIndex:indexPath.row];
                GVC.gameIndex = indexPath.row;

            }
        }
    }
}


- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    return YES;
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (NSString *)titleForRow:(NSUInteger)row
{
    Game *temp = [self.gamesArray getGameForIndex:row];
    return temp.title;
}

- (NSString *)subtitleForRow:(NSUInteger)row
{
    Game *temp = [self.gamesArray getGameForIndex:row];
    NSString *returnString = [NSString stringWithFormat:@"Score: %@", [self.gamesArray getPercentageForIndex:row]];
    if (temp.played) {
        return returnString;
    } else {
        return @"Play Now";
    }
    
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Basic Math";
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Courses";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    cell.textLabel.text = [self titleForRow:indexPath.row];
    
    if ([self.segueType isEqualToString:@"Student"]){
        cell.detailTextLabel.text = [self subtitleForRow:indexPath.row];
    }
    if ([self.segueType isEqualToString:@"Teacher"]){
        cell.detailTextLabel.text = @"Edit";
    }
    
    return cell;
}

- (IBAction)unwindOnSelection:(UIStoryboardSegue *)segue
{
    if ([segue.sourceViewController isKindOfClass:[ResultsViewController class]]) {
        ResultsViewController *RVC = [[ResultsViewController alloc]init];
        RVC = segue.sourceViewController;
    }
    [self.tableView reloadData];
    
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
