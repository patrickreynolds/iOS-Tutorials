//
//  ItemsViewController.m
//  HomeOwner
//
//  Created by Patrick Reynolds on 2/12/14.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import "ItemsViewController.h"
#import "BNRItem.h"
#import "BNRItemStore.h"

@interface ItemsViewController ()

@end

@implementation ItemsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        // Custom initialization
        //for (int i = 0; i < 5; i++) {
        //    [[BNRItemStore sharedStore] createItem];
        //    NSLog(@"Created item #%d", i);
        //}
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    for (int i = 0; i < 5; i++) {
        [[BNRItemStore sharedStore] createItem];
    }
}

#pragma mark - Table view data source
/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}
*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[[BNRItemStore sharedStore] allItems] count] + 1;
    NSLog(@"Item count: %d", [[[BNRItemStore sharedStore] allItems] count]);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if ([indexPath row] < [[[BNRItemStore sharedStore] allItems] count]) {
        // Configure the cell...
        BNRItem *item = [[[BNRItemStore sharedStore] allItems] objectAtIndex:[indexPath row]];

        cell.textLabel.text = [item description];
        
    } else {
        
        cell.textLabel.text = @"No more items!";
    }
    
    NSLog(@"Text: %@", [cell.textLabel.text description]);
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

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
