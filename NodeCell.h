//
//  NodeCell.h
//  ScratchedTableViewCell
//
//  Created by Fatih Yasar on 6/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIFont+Addition.h"

#define NODECELL_HEIGHT     70


enum NodeCellStyle {
    NodeCellStyleAlarms = 1,
};
typedef int NodeCellStyle;


typedef enum {    
    NodeCellStateClosed = 0,        // Cell state is closed
    NodeCellStateOpen = 1           // Cell state is open
} NodeCellState;


@protocol NodeCellDelegate;

@interface NodeCell : UITableViewCell<UIGestureRecognizerDelegate>
{
    
}

@property (nonatomic, weak) id <NodeCellDelegate> delegate;
@property (nonatomic, assign) NodeCellState state;
@property (nonatomic, assign) BOOL enableSwipe;
@property (nonatomic, assign) BOOL disableSelection;
@property (nonatomic, strong) UIView *frontView;
@property (nonatomic, strong) UIView *cellOverlayView;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, assign) float offsetX;
@property (nonatomic, assign) float leftInset;
@property(nonatomic,assign)NodeCellStyle style;

@property(nonatomic,assign)CGFloat cellMargin;
@property(nonatomic,assign,getter = isShowingDisclosureButton)BOOL showDisclosureButton;

@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UILabel *subTitleLabel;

@property(nonatomic,assign)int cellIndex;

///Slide out current cell
- (void)slideOut;
- (void)selectOut;
+ (NodeCell *)findInstanceOnTree:(id)node;
+ (NSString *)cellIdentifier:(NSIndexPath *)indexPath;
-(UIButton*)addActionButtonWithImage:(UIImage*)image title:(NSString*)title index:(int)idx target:(id)target selector:(SEL)selector;
@end

///Nodecell delegate to make communication between owner and nodecell
@protocol NodeCellDelegate <NSObject>
@required
//-(void)didNodeCellSelected:(NodeCell *)cell;
-(void)didNodeCellSlideIn:(NodeCell *)cell;
-(void)didNodeCellSlideOut:(NodeCell *)cell;
@end

