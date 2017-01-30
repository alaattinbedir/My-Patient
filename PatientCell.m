//
//  SBAllPostCell.m
//  ShiftBook
//
//  Created by Alaattin Bedir on 6/5/12.
//  Copyright (c) 2012 Triodor-Lely. All rights reserved.
//

#import "PatientCell.h"

@implementation PatientCell

@synthesize profileImage = _profileImage;
@synthesize titleLabel = _titleLabel;
@synthesize detailLabel = _detailLabel;
@synthesize disclosureImage = _disclosureImage;
@synthesize clockImageView = _clockImageView;
@synthesize replayButton = _replayButton;
@synthesize favoriteButton = _favoriteButton;
@synthesize favoriteButtonImage = _favoriteButtonImage;
//@synthesize profileImageBadge;
@synthesize roleLabel = _roleLabel;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        CGRect cellFrame = self.bounds;
        self.frame = cellFrame; 
        
        self.offsetX = 120.0f;
        
        self.backgroundColor = [UIColor colorWithR:246 G:246 B:246 A:1];
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(78, 6, cellFrame.size.width - 60, 24)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor colorWithR:76 G:76 B:76 A:1];
        _titleLabel.font = [UIFont boldSystemFontOfSize:21];
        [self.frontView addSubview:_titleLabel];
        
        _roleLabel = [[UILabel alloc] initWithFrame:CGRectMake(78, 27, cellFrame.size.width - 60, 20)];
        _roleLabel.backgroundColor = [UIColor clearColor];
        _roleLabel.textColor = [UIColor colorWithR:128 G:128 B:128 A:1];
        _roleLabel.font = [UIFont smallFont];
        [self.frontView addSubview:_roleLabel];
        
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(78, 43, cellFrame.size.width - 80, 20)];
        _detailLabel.backgroundColor = [UIColor clearColor];
        _detailLabel.textColor = [UIColor colorWithR:51 G:51 B:51 A:1];
        _detailLabel.numberOfLines = 1;
        _detailLabel.font = [UIFont smallerFont];
        [self.frontView addSubview:_detailLabel];
               
        _clockImageView = [[UIImageView alloc] initWithFrame:CGRectMake(cellFrame.size.width - 100, 13.7, 10, 10)];
        [self.frontView addSubview:_clockImageView];
        
        _profileImage = [[UIImageView alloc] initWithFrame:CGRectMake(18, 10, 50, 50)];
        _profileImage.layer.borderColor = PROFILE_IMAGE_BORDER_COLOR;
        _profileImage.layer.borderWidth = PROFILE_IMAGE_BORDER_WIDTH;
        _profileImage.layer.cornerRadius = PROFILE_IMAGE_CORNER_RADIUS;
        [self.frontView addSubview:_profileImage];
        
        //create a custom badge
//        profileImageBadge = [BadgeView customBadgeWithString:@"" 
//                                                   withStringColor:[UIColor whiteColor] 
//                                                    withInsetColor:PROFILE_IMAGE_BADGE_INSET_COLOR
//                                                    withBadgeFrame:YES 
//                                         withBadgeFrameColor:PROFILE_IMAGE_BADGE_FRAME_COLOR
//                                                         withScale:0.8
//                                                       withShining:YES];        
//        profileImageBadge.frame = CGRectMake(56, 6, profileImageBadge.frame.size.width, profileImageBadge.frame.size.height);
//        profileImageBadge.tag = 1;
//        [self.frontView addSubview:profileImageBadge];
        
        //Create a sample action button to handle cell actions
        _replayButton = [[ReplayButtonWithLabel alloc] initWithFrame:CGRectMake(10, 15, 50, 50)];
        [_replayButton setBackgroundImage:[UIImage imageNamed:@"reply.png"] forState:UIControlStateNormal];
        [_replayButton setBackgroundColor:[UIColor clearColor]];
        
        //add replay button into backgroundview
        [self.backgroundView addSubview:_replayButton];        

        //Create a sample action button to handle cell actions
        _favoriteButton = [[FavoriteButtonWithLabel alloc] initWithFrame:CGRectMake(63, 15, 50, 50)];
        [_favoriteButton setBackgroundImage:[UIImage imageNamed:@"favorite.png"] forState:UIControlStateNormal];
        [_favoriteButton setBackgroundColor:[UIColor clearColor]];
        
        //add replay button into backgroundview
        [self.backgroundView addSubview:_favoriteButton];
 
    }
    return self;
}

-(void)setFavoriteButtonImage:(UIImage *)favoriteButtonImage{
    _favoriteButton.favoriteImageView.image = favoriteButtonImage;
    _favoriteButton.favoriteImageView.frame = CGRectMake(9, 5, 32, 32);
}

@end
