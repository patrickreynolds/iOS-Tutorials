//
//  Host.m
//  LocalHost
//
//  Created by Patrick Reynolds on 2/11/14.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#import "Host.h"

@implementation Host

+ (NSString *)getNameOfHost :(NSHost *)host
{
    return host.name;
}

+ (NSString *)getLocalizedNameOfHost :(NSHost *)host
{
    return host.localizedName;
}

+ (NSString *)getAddressOfHost :(NSHost *)host
{
    return host.address;
}

@end
