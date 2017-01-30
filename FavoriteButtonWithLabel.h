//
//  CustomButtonWithLabel.h
//  ShiftBook
//
//  Created by Alaattin Bedir on 7/16/12.
//  Copyright (c) 2012 Triodor-Lely. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavoriteButtonWithLabel : UIButton{
    UIImageView *_favoriteImageView;
    UILabel *_favoriteLabel;
}

@property (nonatomic, strong) UIImageView *favoriteImageView;
@property (nonatomic, strong) UILabel *favoriteLabel;

@end
