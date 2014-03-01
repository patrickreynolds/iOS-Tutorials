//
//  BNRItemsViewController.m
//  Homepwner
//
//  Created by Patrick Reynolds on 2/22/14.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import "BNRItemsViewController.h"
#import "BNRDetailViewController.h"
#import "BNRItemStore.h"
#import "BNRItem.h"

@interface BNRItemsViewController()

//@property (strong, nonatomic) IBOutlet UIView *headerView;

@end

@implementation BNRItemsViewController

#pragma mark - Initializers
- (instancetype)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    
    if (self) {
        UINavigationItem *navItem = self.navigationItem;
        navItem.title = @"Homepwner";
        
        // Create a new bar button item that will send
        // addNewItem: to BNRItemsViewController
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewItem:)];
        
        // set this bar button item as the right item in the navigationItem
        navItem.rightBarButtonItem = barButtonItem;
        
        navItem.leftBarButtonItem = self.editButtonItem;
    }
    
    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

/*
- (UIView *)headerView
{
    if (!_headerView) {
        [[NSBundle mainBundle] loadNibNamed:@"HeaderView"
                                      owner:self
                                    options:nil];
    }
    return _headerView;
}
*/

#pragma mark - View Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    /* // Removed custom table header view. Added elements to navBar
    UIView *headerView = self.headerView;
    [self.tableView setTableHeaderView:headerView];
    */
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"BNRItemCell"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [self.tableView reloadData];
}

#pragma mark - Table View Implementation
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[BNRItemStore sharedStore] allItems] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Create an instance of UITableViewCell, with default appearance
    //UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BNRItemCell" forIndexPath:indexPath];
    
    // Set the text on the cell with the description of the item
    // that is at the nth index of items, where n = row this cell
    // will appear in on the tableview
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    BNRItem *item = items[indexPath.row];
    
    cell.textLabel.text = [item description];

    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // If the table view is asking to commit a delete command...
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSArray *items = [[BNRItemStore sharedStore] allItems];
        BNRItem *item = items[indexPath.row];
        
        
        //UIAlertView *deletionAlert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Delete %@", item.itemName] message:[NSString stringWithFormat:@"Are you sure you want to remove %@ from the store?", item.itemName] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Delete", nil];
        //[deletionAlert show];
        //NSLog(@"After message shown.");
        //if (self.confirmDelete) {
            [[BNRItemStore sharedStore] removeItem:item];
            
            // Also remove that row from the table view with an animation
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        //}
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"Remove";
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [[BNRItemStore sharedStore] moveItemAtIndex:sourceIndexPath.row
                                        toIndex:destinationIndexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BNRDetailViewController *detailViewController = [[BNRDetailViewController alloc] initForNewItem:NO];
    
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    BNRItem *selectedItem = items[indexPath.row];
    
    // Give detial view controller a pointer to the item object in row
    detailViewController.item = selectedItem;
    
    // Push it onto the top fo the navigation controller's stack
    [self.navigationController pushViewController:detailViewController animated:YES];
}

#pragma mark - Actions
- (IBAction)addNewItem:(id)sender
{
    
    // Create a new BNRItem and add it to the store
    BNRItem *newItem = [[BNRItemStore sharedStore] createItem];
    
    BNRDetailViewController *detailVC =
    [[BNRDetailViewController alloc] initForNewItem:YES];
    
    detailVC.item = newItem;
    
    detailVC.dismissBlock = ^{
        [self.tableView reloadData];
    };
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:detailVC];
    navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:navigationController animated:YES completion:nil];
}

- (IBAction)toggleEditingMode:(id)sender
{
    NSLog(@"\"Edit\" button pressed in Header View.");
    
    // If you are currently in editing mode
    if (self.isEditing) {
        
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


/* // Saving for future impl ementation. Add <UIAlertViewDelegate> to class when implementing
 - (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
 // the user clicked one of the OK/Cancel buttons
 self.confirmDelete = NO;
 if (buttonIndex == 1)
 {
 NSLog(@"Yes, delete.");
 self.confirmDelete = YES;
 }
 else
 {
 NSLog(@"Can not delete.");
 self.confirmDelete = NO;
 }
 }
 */


@end
