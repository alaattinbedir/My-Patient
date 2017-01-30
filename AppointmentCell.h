//
//  AppointmentCell.h
//  MobilePatientTracker
//
//  Created by Alaattin Bedir on 12/8/13.
//  Copyright (c) 2013 Alaattin Bedir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "NodeCell.h"
#import "FavoriteButtonWithLabel.h"
#import "ReplayButtonWithLabel.h"

@interface AppointmentCell : NodeCell
{
    CAGradientLayer *_normalLayer;
    CAGradientLayer *_selectedLayer;
    UIView *_whiteLine;
    UIView *_blackLine;
    UIImageView *_profileImage;
    UIImageView *_disclosureImage;
    UIImageView *_clockImageView;
    UILabel *_titleLabel;
    UILabel *_detailLabel;
    UILabel *_timeLabel;
    ReplayButtonWithLabel *_replayButton;
    FavoriteButtonWithLabel *_favoriteButton;
    UIImage *_favoriteButtonImage;
    CGFloat detailLabelWidth;
    UILabel *_roleLabel;
}

@property(nonatomic, strong) UIImageView *profileImage;
@property(nonatomic, strong) UIImageView *disclosureImage;
@property(nonatomic, strong) UIImageView *clockImageView;
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *detailLabel;
@property(nonatomic, strong) UILabel *timeLabel;
@property(nonatomic, strong) ReplayButtonWithLabel *replayButton;
@property(nonatomic, strong) FavoriteButtonWithLabel *favoriteButton;
@property(nonatomic, strong) UIImage *favoriteButtonImage;
//@property(nonatomic, strong) BadgeView *profileImageBadge;
@property(nonatomic, strong) UILabel *roleLabel;




-(void)setFavoriteButtonImage:(UIImage *)favoriteButtonImage;

@end
