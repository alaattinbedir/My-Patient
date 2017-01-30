//
//  CustomButtonWithLabel.m
//  ShiftBook
//
//  Created by Alaattin Bedir on 7/16/12.
//  Copyright (c) 2012 Triodor-Lely. All rights reserved.
//

#import "FavoriteButtonWithLabel.h"

@implementation FavoriteButtonWithLabel
@synthesize favoriteImageView = _favoriteImageView;
@synthesize favoriteLabel = _favoriteLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //icon of the background button of node custom cell
        _favoriteImageView = [[UIImageView alloc]initWithFrame:CGRectMake(9, 5, 32, 32)];
        [_favoriteImageView setImage:[UIImage imageNamed:@"unfavorit.png"]];
        
        //title of the background button of node custom cell
        _favoriteLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 32, 55, 21)];
        [_favoriteLabel setText:@"Appointment"];
        [_favoriteLabel setFont:[UIFont systemFontOfSize:9]];
        [_favoriteLabel setBackgroundColor:[UIColor clearColor]];
        [_favoriteLabel setTextColor:[UIColor darkTextColor]];
        [_favoriteLabel setTextAlignment:NSTextAlignmentCenter];
        
        [self addSubview:_favoriteImageView];
        [self addSubview:_favoriteLabel];
        
    }
    return self;
}

-(void)layoutSubviews
{
    _favoriteImageView.frame = CGRectMake(9, -3, 37, 37);
    _favoriteLabel.frame = CGRectMake(0, 30, 55, 21);
}

-(void)setFavoriteButtonImage:(UIImage *)favoriteButtonImage{
    self.favoriteImageView.image = favoriteButtonImage;
    self.favoriteImageView.frame = CGRectMake(9, 5, 32, 32);
}

@end
