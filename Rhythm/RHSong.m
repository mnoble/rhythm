//
//  Play.m
//  Rhythm
//
//  Created by Matthew Noble on 4/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RHSong.h"


@implementation RHSong
@synthesize user, title, artist, album, cover, created_at;

#pragma mark - Initialization Methods

+ (RHSong *)currentPlay
{
    RHSong      *song = [RHSong alloc];
    MPMediaItem *item = [[MPMusicPlayerController iPodMusicPlayer] nowPlayingItem];

    MPMediaItemArtwork *artwork = [item valueForProperty:MPMediaItemPropertyArtwork];
    // TODO: Replace with Current User
    song.cover      = [artwork imageWithSize:CGSizeMake(320.0f, 320.0f)];
    song.title      = [item valueForProperty:MPMediaItemPropertyTitle];
    song.artist     = [item valueForProperty:MPMediaItemPropertyArtist];
    song.album      = [item valueForProperty:MPMediaItemPropertyAlbumTitle];
    song.created_at = [NSDate date];
    
    return song;
}

+ (RHSong *)initWithDictionary:(NSDictionary *)dict
{
    RHSong *song = [RHSong alloc];

    song.user       = [dict objectForKey:@"user"];
    song.cover      = [[UIImage alloc] initWithData:[[dict objectForKey:@"cover"] fromBase64]];
    song.title      = [dict objectForKey:@"title"];
    song.artist     = [dict objectForKey:@"artist"];
    song.album      = [dict objectForKey:@"album"];
    song.created_at = [NSDate date];
    
    return song;
}

#pragma mark - Instance Methods

- (NSString *)coverString
{
    if (cover)
    {
        return [UIImagePNGRepresentation(cover) base64EncodedString];
    }
    
    return @"";
}

- (NSString *)hash
{
    return [[NSString stringWithFormat:@"%@%@%@", title, artist, album] MD5];
}

- (NSString *)artistAndAlbum
{
    return [[NSString alloc] initWithFormat:@"%@ – %@", artist, album];
}

#pragma mark - Saving

- (void)saveForUser:(RHUser *)_user
{
    self.user = _user;
    [self save];
}

- (void)save
{
    NSURL               *url      = [NSURL URLWithString:@"/plays" relativeToURL:RHServerURL];
    NSMutableURLRequest *request  = [[NSMutableURLRequest alloc] initWithURL:url];
    RHSaveDelegate      *delegate = [RHSaveDelegate sharedInstance];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[[self JSONRepresentation] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setValue:[[RHUser currentUser] authString] forHTTPHeaderField:@"Authorization"];
    [[NSURLConnection alloc] initWithRequest:request delegate:delegate];
}

#pragma mark - JSON Serialization

- (NSDictionary *)attributes
{
    return [[NSDictionary alloc] initWithObjectsAndKeys:
            title,  RHTitleKey,
            artist, RHArtistKey,
            album,  RHAlbumKey, 
            nil];
}

- (NSString *)JSONRepresentation
{
    return [[self attributes] JSONRepresentation];
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self=[super init])
    {
        user       = [decoder decodeObjectForKey:RHUsernameKey];
        title      = [decoder decodeObjectForKey:RHTitleKey];
        artist     = [decoder decodeObjectForKey:RHArtistKey];
        album      = [decoder decodeObjectForKey:RHAlbumKey];
        cover      = [decoder decodeObjectForKey:RHCoverKey];
        created_at = [decoder decodeObjectForKey:RHCreatedAtKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:user       forKey:RHUsernameKey];
    [encoder encodeObject:title      forKey:RHTitleKey];
    [encoder encodeObject:artist     forKey:RHArtistKey];
    [encoder encodeObject:album      forKey:RHAlbumKey];
    [encoder encodeObject:cover      forKey:RHCoverKey];
    [encoder encodeObject:created_at forKey:RHCreatedAtKey];
}

@end
