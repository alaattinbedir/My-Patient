//
//  NodeCell.m
//  ScratchedTableViewCell
//
//  Created by Fatih Yasar on 6/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NodeCell.h"
#import <QuartzCore/QuartzCore.h>





@interface NodeCell ()
{
    UIView *frontViewLeft;
    UIView *cellOverlayView;

    BOOL isCellSelected;
    UISwipeGestureRecognizer *rightSwipeRecognier;
    UISwipeGestureRecognizer *leftSwipeRecognier;
    

    
    UIImageView *swipeIndicatorView;
    NSMutableArray *actionButtons;;
    
    UIImageView *disclosureView;
}

-(void)addSwipeGuestures;
-(void)removeSwipeGuestures;
void LR_offsetView(UIView *view, CGFloat offsetX, CGFloat offsetY);
@end

@implementation NodeCell
@synthesize style,titleLabel,subTitleLabel;
@synthesize delegate;
@synthesize frontView;
@synthesize backgroundView;
@synthesize state;
@synthesize enableSwipe;
@synthesize selected;
@synthesize offsetX;
@synthesize cellOverlayView;
@synthesize leftInset;
@synthesize disableSelection;
@synthesize cellIndex;
@synthesize cellMargin;
@synthesize showDisclosureButton;
-(NSString *)sizeOf:(CGRect)target
{
    return NSStringFromCGRect(target);    
}


- (id)initWithStyle:(UITableViewCellStyle)_style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:_style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.cellMargin=5;
        actionButtons=[[NSMutableArray alloc]init]; 
        self.state = NodeCellStateClosed;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView setBackgroundColor:[UIColor clearColor]];
        //---------------------------------------------------------------------------------
        // Cell customization
        // Selected BackgroundView of Current Cell
        //---------------------------------------------------------------------------------
        CGRect selfRect = self.bounds;
        selfRect.size.height = NODECELL_HEIGHT;
        self.bounds = selfRect;  // change current bounds
        self.leftInset = 8.0;
        
        self.contentView.bounds = selfRect;
        //create a cell overlay
        self.cellOverlayView = [[UIView alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:self.cellOverlayView];
        
        self.offsetX = 150;
        
        //Cell background with shadow
        self.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
//        self.backgroundView.backgroundColor = [UIColor colorWithWhite:246.0/255.0 alpha:1];
        [self.backgroundView setBackgroundColor:[UIColor clearColor]];
        [self.cellOverlayView addSubview:self.backgroundView];
        
        //left View
        frontViewLeft = [[UIView alloc] initWithFrame:CGRectZero];
//        frontViewLeft.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cell-left-top.png"]];
        
        
        //Right View
        self.frontView = [[UIView alloc] initWithFrame:CGRectZero];
        frontView.backgroundColor = [UIColor whiteColor];       //[UIColor colorWithWhite:246.0/255.0 alpha:1];
//        self.frontView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cell-right-top.png"]];
        [self.cellOverlayView addSubview:self.frontView];
        
        
        swipeIndicatorView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"swipe_icon"]];
        [self.frontView addSubview:swipeIndicatorView];
//        9/35
        
        
#warning implement highlited 211 211 211
        //---------------------------------------------------------------------------------
        // Guestures
        //---------------------------------------------------------------------------------
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                       initWithTarget:self 
                                       action:@selector(tapDetected:)];
        tap.numberOfTapsRequired = 1;
        [self.frontView addGestureRecognizer:tap];
        
        
        titleLabel=[[UILabel alloc]initWithFrame:CGRectZero];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel setTextColor:[UIColor cellTextColor]];
        [titleLabel setFont:[UIFont fontWithName:[UIFont currentBoldFontName] size:27]];
        [self.frontView addSubview:titleLabel];

        
        subTitleLabel=[[UILabel alloc]initWithFrame:CGRectZero];
        [subTitleLabel setBackgroundColor:[UIColor clearColor]];
        [subTitleLabel setTextColor:[UIColor cellTextColor]];
        [subTitleLabel setFont:[UIFont smallFont]];
        [self.frontView addSubview:subTitleLabel];
        
        self.enableSwipe = NO;
        
        
//        disclosureView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"right_arrow"]];
//        [self.frontView addSubview:disclosureView];
        
    }
    return self;
}


-(BOOL)isSelected
{
    return isCellSelected;
}

-(void)setShowDisclosureButton:(BOOL)_showDisclosureButton{
    showDisclosureButton=_showDisclosureButton;
    [disclosureView setHidden:!showDisclosureButton];
}
-(void)layoutSubviews
{
    self.backgroundView.frame = self.bounds;
    
    if(self.state == NodeCellStateClosed)
    {
        self.selectedBackgroundView.frame = self.bounds;
        self.backgroundView.frame = self.bounds;
        self.contentView.frame = self.bounds;
        cellOverlayView.frame = self.bounds;
        
        frontViewLeft.frame = CGRectMake(0, 0, self.leftInset, self.bounds.size.height);    
        
        self.frontView.frame = CGRectMake(self.leftInset+self.cellMargin, 0, self.bounds.size.width-(2*self.cellMargin), self.bounds.size.height);
        
    }else {
        CGRect frontViewRect = self.frontView.frame;
        frontViewRect.size.width = self.bounds.size.width;
        self.frontView.frame = frontViewRect;   
    }

    [titleLabel setFrame:CGRectMake(self.enableSwipe?20:10, 10, self.bounds.size.width-50, 25)];
    [subTitleLabel setFrame:CGRectMake(self.enableSwipe?20:10, 10+30, self.bounds.size.width-50, 20)];
    [swipeIndicatorView setFrame:CGRectMake(5, (self.bounds.size.height-35)/2.0, 9.0, 35)];
    
    [disclosureView setCenter:CGPointMake(self.bounds.size.width-20, self.bounds.size.height/2.0)];
    
    [super layoutSubviews];
    
}


+ (NodeCell *)findInstanceOnTree:(id)node
{
    return (NodeCell *)[[[[(UIView *)node superview] superview] superview] superview];
}

+ (NSString *)cellIdentifier:(NSIndexPath *)indexPath
{
    return [NSString stringWithFormat:@"Cell%d%d",indexPath.section,indexPath.row];   
}


///enable or disable swipe guestures
-(void)setEnableSwipe:(BOOL)enable
{
    enableSwipe=enable;
    if(enable){
        [self addSwipeGuestures];
        [swipeIndicatorView setHidden:NO];
    }
    
    else{
        [self removeSwipeGuestures];
        [swipeIndicatorView setHidden:YES];
    }
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
}


-(void)removeSwipeGuestures
{
    [cellOverlayView removeGestureRecognizer:rightSwipeRecognier];
    [cellOverlayView removeGestureRecognizer:leftSwipeRecognier];
}



-(void)addSwipeGuestures
{
    if(rightSwipeRecognier == nil)
    {
        rightSwipeRecognier = [[UISwipeGestureRecognizer alloc] 
                               initWithTarget:self action:@selector(rightSwipeRecognizer:)];
        rightSwipeRecognier.delegate = self;
        [rightSwipeRecognier setDirection:(UISwipeGestureRecognizerDirectionRight)];    
    }
    
    if(leftSwipeRecognier == nil)
    {
        leftSwipeRecognier = [[UISwipeGestureRecognizer alloc] 
                              initWithTarget:self action:@selector(leftSwipeRecognizer:)];
        leftSwipeRecognier.delegate = self;
        [leftSwipeRecognier setDirection:(UISwipeGestureRecognizerDirectionLeft)];    
    }
    [cellOverlayView addGestureRecognizer:rightSwipeRecognier];    
    [cellOverlayView addGestureRecognizer:leftSwipeRecognier];
}




#define kBOUNCE_DISTANCE 20.0

void LR_offsetView(UIView *view, CGFloat offsetX, CGFloat offsetY)
{
    view.frame = CGRectOffset(view.frame, offsetX, offsetY);
}

-(void)applyMove:(UIView *)view andOffsetX:(CGFloat)offsetx andBounceStep1:(CGFloat)step1 andBounceStep2:(CGFloat)step2 
{
    [UIView animateWithDuration:0.1
                          delay:0 
                        options:UIViewAnimationOptionCurveEaseOut|UIViewAnimationOptionAllowUserInteraction 
                     animations:^{ LR_offsetView(view, offsetx, 0); 
                         if(step1 < 0){

                             //leftScratch.hidden = NO;
                         }                            
                     } 
                     completion:^(BOOL f) {
                         [UIView animateWithDuration:0.1 delay:0 
                                             options:UIViewAnimationCurveLinear
                                          animations:^{ LR_offsetView(view, step1, 0);
                                              if(step1 > 0){
                                           
                                                  //leftScratch.hidden = YES;
                                              }                                              

                                          } 
                                          completion:^(BOOL f) {                     
                                              [UIView animateWithDuration:0.1 delay:0 
                                                                  options:UIViewAnimationCurveLinear
                                                               animations:^{ LR_offsetView(view, step2, 0); } 
                                                               completion:NULL];
                                              
                                          }
                          ];   
                     }];
}

- (void)selectOut
{
//    self.frontView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cell-right-top.png"]]; 
//    frontViewLeft.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cell-left-top.png"]]; 
    //UIImageView *leftBgImageView = [[frontViewLeft subviews] objectAtIndex:0];
    //[leftBgImageView setImage:[UIImage imageNamed:@"cell-left-top.png"]];
    isCellSelected = NO;
}

-(void)tapDetected:(UITapGestureRecognizer *)sender
{
    if(self.disableSelection)
        return;
    
    //Close the cell when tap happened
    if(state == NodeCellStateOpen) {
        [self slideOut];             
    }
    else if (sender.state == UIGestureRecognizerStateEnded && state == NodeCellStateClosed)
    {        
        isCellSelected = YES;        
//        self.frontView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cell-right-top-selected.png"]]; 
//        frontViewLeft.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cell-left-top-selected.png"]]; 
        
        UITableView *superTable;
        if (IS_OS_7_OR_LATER) {
            superTable = (UITableView *)self.superview.superview;
        }else
        {
            superTable = (UITableView *)self.superview;
        }
        
        NSIndexPath *path = [superTable indexPathForCell:self]; 
        [superTable.delegate tableView:superTable didSelectRowAtIndexPath:path];
        
        [self performSelector:@selector(selectOut) withObject:nil afterDelay:.5];
    }
}


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    //eliminate UILongPressGestureRecognizer type it is coming from super
    if([gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]])
        return NO;
    if ([gestureRecognizer isKindOfClass:[UISwipeGestureRecognizer class]]) {
        if(self.state ==  NodeCellStateClosed)
            if(((UISwipeGestureRecognizer*)gestureRecognizer).direction==UISwipeGestureRecognizerDirectionLeft)
                return NO;
        
    }
    return YES;
}



///Close swipe handler <--
- (void)leftSwipeRecognizer:(UISwipeGestureRecognizer *)sender
{    
    if(self.state ==  NodeCellStateClosed)
        return;
    
    CGFloat bounceDistance = kBOUNCE_DISTANCE;
    
    self.state = NodeCellStateClosed;
    if (sender.state == UIGestureRecognizerStateEnded)      
    {
        //NSLog(@"Left Swipe");
        [self applyMove:self.frontView andOffsetX:-self.offsetX andBounceStep1:bounceDistance andBounceStep2:-bounceDistance];
        [self.delegate didNodeCellSlideOut:self];
    }
}

-(void)slideOut
{        
    self.state = NodeCellStateClosed;
    CGFloat bounceDistance = kBOUNCE_DISTANCE;
    [self applyMove:self.frontView andOffsetX:-self.offsetX andBounceStep1:bounceDistance andBounceStep2:-bounceDistance];
    [self.delegate didNodeCellSlideOut:self];
}

///Open swipe handler -->
- (void)rightSwipeRecognizer:(UISwipeGestureRecognizer *)sender
{    
    if(self.state ==  NodeCellStateOpen || isCellSelected)
        return;
    CGFloat bounceDistance = kBOUNCE_DISTANCE;
    self.state = NodeCellStateOpen;
    if (sender.state == UIGestureRecognizerStateEnded)      
    {
        //NSLog(@"Right Swipe");
        [self applyMove:self.frontView andOffsetX:self.offsetX andBounceStep1:-bounceDistance andBounceStep2:bounceDistance];
        [self.delegate didNodeCellSlideIn:self];
    }
}

- (void)setHighlighted: (BOOL)highlighted animated: (BOOL)animated
{
    if(highlighted) {
        frontView.backgroundColor = [UIColor colorWithR:212.0 G:212.0 B:212.0 A:1.0];
    } else {
        frontView.backgroundColor = [UIColor whiteColor];//[UIColor colorWithWhite:246.0/255.0 alpha:1.0];
    }
}


-(void)prepareForReuse{
    [super prepareForReuse];
    for (UIButton *btn in actionButtons) {
        [btn removeFromSuperview];
    }
    [actionButtons removeAllObjects];
}

-(UIButton*)addActionButtonWithImage:(UIImage*)image title:(NSString*)title index:(int)idx target:(id)target selector:(SEL)selector{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(5+(idx*70), 5, 70, 60);
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [button setTag:self.cellIndex];
    
    [button setImage:image forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont extraSmallFont]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [button setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    CGFloat spacing = 1.0;
    
    // get the size of the elements here for readability
    CGSize imageSize = button.imageView.frame.size;
    
    // lower the text and push it left to center it
    button.titleEdgeInsets = UIEdgeInsetsMake(
                                              0.0, - imageSize.width, - (imageSize.height + spacing), 0.0);
    
    // the text width might have changed (in case it was shortened before due to
    // lack of space and isn't anymore now), so we get the frame size again
    CGSize titleSize = button.titleLabel.frame.size;
    
    // raise the image and push it right to center it
    button.imageEdgeInsets = UIEdgeInsetsMake(
                                              - (titleSize.height + spacing), 0.0, 0.0, - titleSize.width);
    [actionButtons addObject:button];
    //add test button into backgroundview
    [self.backgroundView addSubview:button];
    return button;
}

@end
