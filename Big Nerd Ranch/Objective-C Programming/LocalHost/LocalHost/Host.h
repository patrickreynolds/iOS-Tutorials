//
//  Host.h
//  LocalHost
//
//  Created by Patrick Reynolds on 2/11/14.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Host : NSObject

+ (NSString *)getNameOfHost :(NSHost *)host;
+ (NSString *)getLocalizedNameOfHost :(NSHost *)host;
+ (NSString *)getAddressOfHost :(NSHost *)host;

@end
