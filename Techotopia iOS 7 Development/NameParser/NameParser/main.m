//
//  main.m
//  NameParser
//
//  Created by Patrick Reynolds on 2/11/14.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        NSString *nameString = [[NSString alloc] initWithContentsOfFile:@"/usr/share/dict/propernames"
                                                          encoding:NSUTF8StringEncoding
                                                             error:NULL];
        NSArray *names = [nameString componentsSeparatedByString:@"\n"];
        
        for (NSString *name in names) {
            // Look for the string pat in case sensitive manner
            NSRange r = [name rangeOfString:@"Pat" options:NSCaseInsensitiveSearch];
            
            // Was it found?
            if (r.location != NSNotFound) {
                NSLog(@"%@", name);
            }
        }
        
    }
    return 0;
}

