//
//  ViewController.h
//  Rhythm
//
//  Created by Matthew Noble on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <QuartzCore/QuartzCore.h>
#import "SBJson.h"
#import "Base64.h"
#import "SFHFKeychainUtils.h"

#import "SongCell.h"
#import "RHSong.h"


@interface ViewController : UIViewController
{
    IBOutlet UINavigationBar *nav;
    IBOutlet UIImageView *coverView;
    IBOutlet UIButton *broadcast;
    IBOutlet UITableView *table;
    IBOutlet UIImageView *background;
    
    RHUser *user;
    NSMutableArray *plays;
    RHSong *lastSong;
    NSMutableData *response;
    MPMusicPlayerController *itunes;
}

@property (nonatomic, retain) IBOutlet UINavigationBar *nav;
@property (nonatomic, retain) IBOutlet UIImageView *coverView;
@property (nonatomic, retain) IBOutlet UIButton *broadcast;
@property (nonatomic, retain) IBOutlet UITableView *table;
@property (nonatomic, retain) IBOutlet UIImageView *background;

@property (nonatomic, retain) RHUser *user;
@property (nonatomic, retain) NSMutableArray *plays;
@property (nonatomic, retain) RHSong *lastSong;

- (void)saveDidFail;

@end
