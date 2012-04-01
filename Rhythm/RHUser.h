//
//  RHUser.h
//  Rhythm
//
//  Created by Matthew Noble on 4/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBJson.h"
#import "RHDefinitions.h"
#import "Base64.h"
#import "SFHFKeychainUtils.h"


@interface RHUser : NSObject <NSCoding>
{
    NSString *email;
    NSString *password;
}

@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *password;

+ (RHUser *)currentUser;
- (RHUser *)initWithUsername:(NSString *)_username andPassword:(NSString *)_password;
- (NSString *)authString;

@end
