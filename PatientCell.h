//
//  SBAllPostCell.h
//  ShiftBook
//
//  Created by Alaattin Bedir on 6/5/12.
//  Copyright (c) 2012 Triodor-Lely. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "NodeCell.h"
#import "FavoriteButtonWithLabel.h"
#import "ReplayButtonWithLabel.h"

@interface PatientCell : NodeCell
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
@property(nonatomic, strong) ReplayButtonWithLabel *replayButton;
@property(nonatomic, strong) FavoriteButtonWithLabel *favoriteButton;
@property(nonatomic, strong) UIImage *favoriteButtonImage;
//@property(nonatomic, strong) BadgeView *profileImageBadge;
@property(nonatomic, strong) UILabel *roleLabel;




-(void)setFavoriteButtonImage:(UIImage *)favoriteButtonImage;

@end
