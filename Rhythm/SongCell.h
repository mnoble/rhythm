//
//  CustomCell.h
//  Rhythm
//
//  Created by Matthew Noble on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SongCell : UITableViewCell
{
    IBOutlet UIImageView *avatar;
    IBOutlet UIImageView *albumCover;
    IBOutlet UILabel     *title;
    IBOutlet UILabel     *artistAndAlbum;
}

@property (nonatomic, retain) IBOutlet UIImageView *avatar;
@property (nonatomic, retain) IBOutlet UIImageView *albumCover;
@property (nonatomic, retain) IBOutlet UILabel     *title;
@property (nonatomic, retain) IBOutlet UILabel     *artistAndAlbum;

@end
