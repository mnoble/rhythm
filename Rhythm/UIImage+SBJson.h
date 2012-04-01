//
//  UIImage+SBJson.h
//  Rhythm
//
//  Created by Matthew Noble on 4/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Base64.h"

#pragma mark JSON Writing

@interface UIImage (UIImage_SBJsonWriting)
- (NSString *)proxyForJson;
@end

