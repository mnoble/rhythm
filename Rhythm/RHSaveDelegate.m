//
//  RHSaveDelegate.m
//  Rhythm
//
//  Created by Matthew Noble on 4/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RHSaveDelegate.h"

@implementation RHSaveDelegate

static RHSaveDelegate *_sharedInstance = nil;

+ (RHSaveDelegate *)sharedInstance
{
    if (!_sharedInstance)
    {
        _sharedInstance = [[RHSaveDelegate alloc] init];
    }
    
    return _sharedInstance;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)_response
{
    // TODO: If anything other than a 201 is returns, saved the song to be
    // sent to the server next push.
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [response setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [response appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSLog(@"%@", [error description]);
}

@end
