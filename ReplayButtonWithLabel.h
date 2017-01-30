//
//  ReplayButtonWithLabel.h
//  ShiftBook
//
//  Created by Alaattin Bedir on 7/16/12.
//  Copyright (c) 2012 Triodor-Lely. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReplayButtonWithLabel : UIButton{
    UIImageView *_replayButtonImageView;
    UILabel *_replayButtonLabel;
}

@property (nonatomic, strong) UIImageView *replayButtonImageView;
@property (nonatomic, strong) UILabel *replayButtonLabel;

@end
