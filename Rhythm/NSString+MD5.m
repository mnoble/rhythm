//
//  NSString+MD5.m
//  Rhythm
//
//  Created by Matthew Noble on 4/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSString+MD5.h"

@implementation NSString (MD5)

- (NSString *)MD5
{
    const char *cString = [self UTF8String];
    unsigned char digest[16];
    CC_MD5(cString, strlen(cString), digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}

@end
