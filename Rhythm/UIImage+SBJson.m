//
//  UIImage+SBJson.m
//  Rhythm
//
//  Created by Matthew Noble on 4/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UIImage+SBJson.h"

@implementation UIImage (UIImage_SBJsonWriting)

- (NSString *)proxyForJson
{
    return [UIImagePNGRepresentation(self) base64EncodedString];
}

@end

