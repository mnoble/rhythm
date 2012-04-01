//
//  RHSaveDelegate.h
//  Rhythm
//
//  Created by Matthew Noble on 4/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RHSaveDelegate : NSObject <NSURLConnectionDelegate>
{
    NSMutableData *response;
}

+ (RHSaveDelegate *)sharedInstance;
@end
