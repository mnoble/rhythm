//
//  ViewController.m
//  Rhythm
//
//  Created by Matthew Noble on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

@synthesize nav, broadcast, coverView, table, background, plays, lastSong, user;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - MediaPlayer Methods

- (void)registerMediaPlayerNotifications
{
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];

    [notificationCenter addObserver:self
                           selector:@selector(handleNowPlayingChanged:)
                               name:MPMusicPlayerControllerNowPlayingItemDidChangeNotification
                             object:itunes];

    [itunes beginGeneratingPlaybackNotifications];
}

- (void)handleNowPlayingChanged:(id)notification
{
    [broadcast setEnabled:YES];
    [broadcast setSelected:NO];
    [self updateAlbumArt];
}

#pragma mark - Timeline

- (void)fetchUpdates
{
    NSURLRequest    *request    = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost:4567/"]];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if (connection)
    {
        response = [NSMutableData data];
    }
}

#pragma mark - View Customization

- (void)drawTitleBar
{
    int width  = nav.frame.size.width;
    int height = nav.frame.size.height;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment   = UITextAlignmentCenter;
    label.textColor       = [UIColor colorWithRed:(29/255.f) green:(35/255.f) blue:(38/255.f) alpha:1];
    label.font            = [UIFont fontWithName:@"OleoScript-Regular" size:24.0];
    label.text            = @"Rhythm";
    label.shadowColor     = [UIColor colorWithRed:(105/255.f) green:(135/255.f) blue:(147/255.f) alpha:1.0];
    label.shadowOffset    = CGSizeMake(0, 1.0);
    
    nav.topItem.titleView = label;
}

- (void)drawContentShadow
{
    [background.layer setMasksToBounds:NO];
    [background.layer setShadowOffset:CGSizeMake(0, -10)];
    [background.layer setShadowRadius:5];
    [background.layer setShadowOpacity:0.35];
}

- (void)updateAlbumArt
{
    RHSong *song = [RHSong currentPlay];
    
    if (song && song.cover)
    {
        [coverView setImage:song.cover];
    }
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    itunes = [MPMusicPlayerController iPodMusicPlayer];
    plays  = [[NSMutableArray alloc] init];
    
    NSError *error = nil;
    [SFHFKeychainUtils storeUsername:@"me@mattenoble.com" andPassword:@"matt0220" forServiceName:@"Rhythm" updateExisting:YES error:&error];
    
    user = [RHUser currentUser];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(broadcastSong:)];
    [doubleTap setNumberOfTapsRequired:2];
    [[self coverView] setUserInteractionEnabled:YES];
    [[self coverView] addGestureRecognizer:doubleTap];
    
    [self drawTitleBar];
    [self drawContentShadow];
    [self updateAlbumArt];
    [self registerMediaPlayerNotifications];
    [self fetchUpdates];
}

#pragma mark - NSURLConnection

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)_response
{
    [response setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [response appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *_response = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    NSArray  *_plays    = [_response JSONValue];
    
    for (NSDictionary *play in _plays)
    {
        [plays addObject:play];
    }
    
    [table reloadData];
}

#pragma mark NSTableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [plays count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"SongCell";
	
    SongCell *cell = (SongCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
		NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"SongCell" owner:self options:nil];
		
		for (id currentObject in topLevelObjects)
        {
			if ([currentObject isKindOfClass:[UITableViewCell class]])
            {
				cell = (SongCell *) currentObject;
				break;
			}
		}
	}
    
    RHSong *song = [plays objectAtIndex:[indexPath row]];
    
    [cell.albumCover setImage:song.cover];
    [cell.title setText:song.title];
    [cell.artistAndAlbum setText:song.artistAndAlbum];
    
    [cell.avatar.layer setCornerRadius:3.0f];
    [cell.avatar.layer setMasksToBounds:YES];
    [cell.albumCover.layer setCornerRadius:3.0f];
    [cell.albumCover.layer setMasksToBounds:YES];
	
    return cell;
}

#pragma mark - Helpers

- (BOOL)isNewSong:(RHSong *)song
{
    if (plays.count == 0)
    {
        return YES;
    }
    
    RHSong *_lastSong = [plays objectAtIndex:0];
    return ![[_lastSong hash] isEqualToString:[song hash]];
}

#pragma mark - Actions

- (IBAction)broadcastSong:(id)sender
{
    RHSong *song = [RHSong currentPlay];
    
    if (song && [self isNewSong:song])
    {
        [song save];
        [self addSongToTimeline:song];
    }
}

- (void)addSongToTimeline:(RHSong *)song
{
    [plays insertObject:song atIndex:0];
    [table reloadData];
}

- (void)saveDidFail
{
    [plays removeObjectAtIndex:0];
    [table reloadData];
}

@end
