//
//  ItemsViewController.m
//  HomeOwner
//
//  Created by Patrick Reynolds on 2/12/14.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import "ItemsViewController.h"
#import "DetailsViewController.h"
#import "BNRItem.h"
#import "BNRItemStore.h"
#import "HomeownerTableCell.h"

@interface ItemsViewController ()

@end

@implementation ItemsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UINib *tableCellNib = [UINib nibWithNibName:@"HomeownerTableCell" bundle:nil];
    
    // Register this NIB which contains the cell
    [self.tableView registerNib:tableCellNib
         forCellReuseIdentifier:@"HomeownerTableCell"];
}

/*
- (UIView *)headerView
{
    if (!headerView) {
        [[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:self options:nil];
    }
    return headerView;
}
*/

#pragma mark - Table Manipulation Functions
- (IBAction)toggleEditingMode:(id)sender
{
    NSLog(@"Toggle editing was pressed.");
    if ([self isEditing]) {
        // Change text of button to inform user of state
        [sender setTitle:@"Edit" forState:UIControlStateNormal];
        // Turn off editing mode
        [self setEditing:NO animated:YES];
    } else {
        // Change text of button to inform user of state
        [sender setTitle:@"Done" forState:UIControlStateNormal];
        // Enter editing mode
        [self setEditing:YES animated:YES];
    }
}

- (IBAction)addNewItem:(id)sender
{
    NSLog(@"Add new item pressed.");
    
    // Create a new BNRItem and add it to the store
    BNRItem *newItem = [[BNRItemStore sharedStore] createItem];
    
    // Figureout where that item is in the array
    int lastRow = (int)[[[BNRItemStore sharedStore] allItems] indexOfObject:newItem];
    
    
    NSIndexPath *ip = [NSIndexPath indexPathForRow:lastRow inSection:0];
    
    // Insert this new row into the talbe
    [[self tableView] insertRowsAtIndexPaths:[NSArray arrayWithObject:ip] withRowAnimation:[self randomAnimation]];
    
};


- (UITableViewRowAnimation)randomAnimation
{
    int random = arc4random() % 8 + 1;
    switch (random) {
        case 1:
            NSLog(@"Automatic animation.");
            return UITableViewRowAnimationAutomatic;
            break;
        case 2:
            NSLog(@"Bottom animation.");
            return UITableViewRowAnimationBottom;
            break;
        case 3:
            NSLog(@"Fade animation.");
            return UITableViewRowAnimationFade;
            break;
        case 4:
            NSLog(@"Left animation.");
            return UITableViewRowAnimationLeft;
            break;
        case 5:
            NSLog(@"Middle animation.");
            return UITableViewRowAnimationMiddle;
            break;
        case 6:
            NSLog(@"None animation.");
            return UITableViewRowAnimationNone;
            break;
        case 7:
            NSLog(@"Right animation.");
            return UITableViewRowAnimationRight;
            break;
        case 8:
            NSLog(@"Top animation.");
            return UITableViewRowAnimationTop;
            break;
            
        default:
            NSLog(@"None animation");
            return UITableViewRowAnimationNone;
            break;
    }
}


#pragma mark - Tableview Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[[BNRItemStore sharedStore] allItems] count];
    NSLog(@"Item count: %lu", (unsigned long)[[[BNRItemStore sharedStore] allItems] count]);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    static NSString *CellIdentifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if ([indexPath row] < [[[BNRItemStore sharedStore] allItems] count]) {
        // Configure the cell...
        BNRItem *item = [[[BNRItemStore sharedStore] allItems] objectAtIndex:[indexPath row]];

        cell.textLabel.text = [item description];
        
    }
    */
    BNRItem *item = [[[BNRItemStore sharedStore] allItems] objectAtIndex:indexPath.row];
    
    // Get the new recycled cell
    HomeownerTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"HomeownerTableCell"];

    // Configure cell
    cell.nameLabel.text = item.itemName;
    cell.serialNumberLabel.text = item.serialNumber;
    cell.valueLabel.text = [NSString stringWithFormat:@"%d", item.valueInDollars];
    
    // Configure thumbnail image
    cell.thumbnailView.image = item.thumbnail;
    
    NSLog(@"Text: %@", [cell.textLabel.text description]);
    return cell;
}

#pragma mark - HeaderView Implementation
/*
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self headerView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    // The height of the header view should be determined from
    // the height of the view in the XIB file
    return [[self headerView] bounds].size.height;
}
*/
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // If the table view is asking to commit a delete command..
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        BNRItemStore *itemStore = [BNRItemStore sharedStore];
        NSArray *items = [itemStore allItems];
        BNRItem *item = [items objectAtIndex:indexPath.row];
        [itemStore removeItem:item];
        
        // We also remove that row from the table view with an animation
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [[BNRItemStore sharedStore] moveItemAtIndex:sourceIndexPath.row :destinationIndexPath.row];
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"Remove";
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"Prepare for seque.");
    if ([segue.identifier isEqualToString:@"ListVCtoDetialVC"]) {
        NSLog(@"Matched Log");
        DetailsViewController *detialVC = [segue destinationViewController];
        NSIndexPath *selectedItem = [self.tableView indexPathForSelectedRow];
        detialVC.item = [[[BNRItemStore sharedStore] allItems] objectAtIndex:selectedItem.row];
    }
}

/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Find the selected cell in the usual way
    HomeOwnerItemCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    // Check if this is the cell I want to segue from by using the reuseIdenifier
    // which I set in the "Identifier" field in Interface Builder
    if ([cell.reuseIdentifier isEqualToString:@"CustomItemCell"]) {
        
        // Do my conditional logic - this was the whole point of changing the segue
        if (cell.nameLabel) {
            // Perform the segue using the identifier I was careful to give it in IB
            // Note I'm sending the cell as the sender because that's what the normal
            // segue does and I already had code counting on that
            [self performSegueWithIdentifier:@"ListVCtoDetialVC" sender:cell];
        }
    }
}
*/
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
