//
//  Play.h
//  Rhythm
//
//  Created by Matthew Noble on 4/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "SBJson.h"
#import "Base64.h"
#import "RHDefinitions.h"
#import "RHUser.h"
#import "RHSaveDelegate.h"
#import "NSString+MD5.h"


@interface RHSong : NSObject <NSCoding>
{
    RHUser   *user;
    NSString *title;
    NSString *artist;
    NSString *album;
    UIImage  *cover;
    NSDate   *created_at;
    
    NSMutableData *saveResponse;
}

@property (nonatomic, retain) RHUser   *user;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *artist;
@property (nonatomic, retain) NSString *album;
@property (nonatomic, retain) UIImage  *cover;
@property (nonatomic, retain) NSDate   *created_at;

+ (RHSong *)currentPlay;
+ (RHSong *)initWithDictionary:(NSDictionary *)dict;

- (NSString *)hash;
- (NSString *)artistAndAlbum;
- (void)save;
- (void)saveForUser:(RHUser *)_user;

@end
