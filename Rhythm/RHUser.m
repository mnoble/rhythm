//
//  RHUser.m
//  Rhythm
//
//  Created by Matthew Noble on 4/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RHUser.h"

static RHUser *_currentUser;

@implementation RHUser
@synthesize username, password;

+ (RHUser *)currentUser
{
    if (_currentUser)
    {
        return _currentUser;
    }
    
    NSError *error = nil;
    NSString *password = [SFHFKeychainUtils getPasswordForUsername:@"me@mattenoble.com" andServiceName:@"Rhythm" error:&error];
    
    _currentUser = [[RHUser alloc] initWithUsername:@"me@mattenoble.com" andPassword:password];
    return _currentUser;
}

- (RHUser *)initWithUsername:(NSString *)_username andPassword:(NSString *)_password
{
    self.username = _username;
    self.password = _password;
    return self;
}

- (id)proxyForJson
{
    return [NSDictionary dictionaryWithObjectsAndKeys:username, @"username", nil];
}

- (NSString *)authString
{
    NSString *usernameAndPassword = [[NSString alloc] initWithFormat:@"%@:%@", username, password];
    NSString *auth = [[NSString alloc] initWithFormat:@"Basic %@", [usernameAndPassword toBase64]];
    return auth;
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self=[super init])
    {
        username = [decoder decodeObjectForKey:RHUsernameKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:username forKey:RHUsernameKey];
}

@end
