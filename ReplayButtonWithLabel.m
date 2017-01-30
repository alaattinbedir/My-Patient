//
//  ReplayButtonWithLabel.m
//  ShiftBook
//
//  Created by Alaattin Bedir on 7/16/12.
//  Copyright (c) 2012 Triodor-Lely. All rights reserved.
//

#import "ReplayButtonWithLabel.h"

@implementation ReplayButtonWithLabel
@synthesize replayButtonImageView = _replayButtonImageView;
@synthesize replayButtonLabel = _replayButtonLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //icon of the background button of node custom cell
        _replayButtonImageView = [[UIImageView alloc]init];
        [_replayButtonImageView setImage:[UIImage imageNamed:@"reply.png"]];
        
        //title of the background button of node custom cell
        _replayButtonLabel = [[UILabel alloc]init];
        [_replayButtonLabel setText:@"Call"];
        [_replayButtonLabel setFont:[UIFont systemFontOfSize:9]];
        [_replayButtonLabel setBackgroundColor:[UIColor clearColor]];
        [_replayButtonLabel setTextColor:[UIColor darkTextColor]];
        [_replayButtonLabel setTextAlignment:NSTextAlignmentCenter];
        
        [self addSubview:_replayButtonImageView];
        [self addSubview:_replayButtonLabel];
        // Initialization code
    }
    return self;
}

-(void)layoutSubviews
{
    _replayButtonImageView.frame = CGRectMake(10, -3, 37, 37);
    _replayButtonLabel.frame = CGRectMake(0, 30, 55, 21);
}

@end
