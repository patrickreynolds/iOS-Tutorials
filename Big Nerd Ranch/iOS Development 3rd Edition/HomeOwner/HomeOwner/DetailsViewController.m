//
//  DetialsViewController.m
//  HomeOwner
//
//  Created by Patrick Reynolds on 2/17/14.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import "DetailsViewController.h"
#import "BNRItem.h"
#import "BNRImageStore.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    NSLog(@"View recieved memory warning! Image might not save.");
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Setting title
    self.title = self.item.itemName;
    
    // Namefield texts
    self.nameField.text = self.item.itemName;
    self.serialNumberField.text = self.item.serialNumber;
    self.valueField.text = [NSString stringWithFormat:@"%d", self.item.valueInDollars];
    
    // Create a NSDateFormatter that will turn a date into a simle date string
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
    // Use filtered NSDate object to set dateLabel contents
    self.dateLabel.text = [dateFormatter stringFromDate:self.item.dateCreated];
    
    
    // Setting image from cache
    NSString *imageKey = self.item.imageKey;
    
    if (imageKey) {
        // Get image for image key from image store
        UIImage *cachedImage = [[BNRImageStore sharedStore] imageForKey:imageKey];
        self.imageView.image = cachedImage;
    } else {
        // Clear the ImageView
        self.imageView.image = nil;
    }
}

#pragma mark - Capturing and Saving Image

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // Delete old key if another image exists.
    NSString *oldImageKey = self.item.imageKey;
    
    if (oldImageKey) {
        [[BNRImageStore sharedStore] deleteImageForKey:oldImageKey];
    }
    
    // Get picked image from info dictionary
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [self.item setThumbnailDataFromImage:image];
    
    // Create a CFUUID object - it knows hhow to create unique identifier strings
    CFUUIDRef newUniqueId = CFUUIDCreate(kCFAllocatorDefault);
    
    // Create a string from unique identifier
    CFStringRef newUniqueIDString = CFUUIDCreateString(kCFAllocatorDefault, newUniqueId);
    
    // Use that unique ID to set our item's imageKey
    NSString *key = (__bridge NSString *)newUniqueIDString;
    self.item.imageKey = key;
    
    // Store image in the BNRStore with this key
    [[BNRImageStore sharedStore] setImage:image forKey:self.item.imageKey];
    
    // Release owners of each pointer
    CFRelease(newUniqueId);
    CFRelease(newUniqueIDString);
    
    // Put that image onto the screen in our image view
    self.imageView.image = image;
    
    // Take image picker off the screen
    // You must call this dismiss method
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)tapToTakePhoto:(UITapGestureRecognizer *)sender
{
    NSLog(@"Double tap detected");
    [self getMediaFromSource];
}


- (IBAction)takePhoto:(UIBarButtonItem *)sender
{
    [self getMediaFromSource];
}

- (void)getMediaFromSource
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    // If our device has a camera, we want to take a picture, otherwise, we
    // just pick from photo library
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    } else {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    
    // This line of code will generate a warning right now, ignore it
    imagePicker.delegate = self;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}

#pragma mark - Keyboard Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)backgroundTapped:(UIControl *)sender
{
    [self.view endEditing:YES];
}


@end





















