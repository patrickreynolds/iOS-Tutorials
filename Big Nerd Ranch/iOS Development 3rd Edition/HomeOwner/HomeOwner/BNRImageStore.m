//
//  BNRObjectStore.m
//  HomeOwner
//
//  Created by Patrick Reynolds on 2/18/14.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import "BNRImageStore.h"

@interface BNRImageStore()

@property (strong, nonatomic) NSMutableDictionary *dictionary;

@end

@implementation BNRImageStore

/*
// Optional lazy instantiation
- (NSMutableDictionary *)dictionary
{
    if (!_dictionary) _dictionary = [[NSMutableDictionary alloc] init];
    return _dictionary;
}
*/
- (id)init
{
    self = [super init];
    if (self) {
        self.dictionary = [[NSMutableDictionary alloc] init];
        
        NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
        [notificationCenter addObserver:self
                               selector:@selector(clearCache:)
                                   name:UIApplicationDidReceiveMemoryWarningNotification
                                 object:nil];
    }
    return self;
}

- (void)clearCache:(NSNotification *)notification
{
    NSLog(@"Flushing %d images out of the cache", self.dictionary.count);
    [self.dictionary removeAllObjects];
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    return [self sharedStore];
}

+ (BNRImageStore *)sharedStore
{
    static BNRImageStore *sharedStore = nil;
    if (!sharedStore) {
        // Create the singleton
        sharedStore = [[super allocWithZone:NULL] init];
    }
    return sharedStore;
}

- (void)setImage:(UIImage *)image forKey:(NSString *)key
{
    [self.dictionary setObject:image forKey:key];
    
    // Create full path for image
    NSString *imagePath = [self imagePathForKey:key];
    
    // turn image into JPEG data
    NSData *data = UIImageJPEGRepresentation(image, 0.5);
    
    // Write it to full path
    [data writeToFile:imagePath atomically:YES];
}

- (UIImage *)imageForKey:(NSString *)key
{
    UIImage *result = [self.dictionary objectForKey:key];
    
    if (!result) {
        // Create UIImage object from file
        result = [UIImage imageWithContentsOfFile:[self imagePathForKey:key]];
        
        // If we found an image on the file system, place it into the cache
        if (result) {
            [self.dictionary setObject:result forKey:key];
        } else {
            NSLog(@"Error: unable to find %@", [self imageForKey:key]);
        }
    }
    return result;
}

- (void)deleteImageForKey:(NSString *)key
{
    if (!key) {
        NSLog(@"Key nil/invalid");
        return;
    }
    
    [self.dictionary removeObjectForKey:key];
    
    NSString *path = [self imagePathForKey:key];
    [[NSFileManager defaultManager] removeItemAtPath:path error:NULL];
}

- (NSString *)imagePathForKey:(NSString *)key
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                       NSUserDomainMask,
                                                                       YES);
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    
    return [documentDirectory stringByAppendingPathComponent:key];
}

@end
