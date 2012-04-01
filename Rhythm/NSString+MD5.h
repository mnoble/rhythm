//
//  NSString+MD5.h
//  Rhythm
//
//  Created by Matthew Noble on 4/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>


@interface NSString (MD5)
- (NSString *)MD5;
@end
