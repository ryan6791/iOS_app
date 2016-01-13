//
//  DraggableView.m
//  portal
//
//  Created by Neil Ballard on 10/9/15.
//  Copyright © 2015 Neil_appworld. All rights reserved.
//

#define ACTION_MARGIN 120 //%%% distance from center where the action applies. Higher = swipe further in order for the action to be called
#define SCALE_STRENGTH 4 //%%% how quickly the card shrinks. Higher = slower shrinking
#define SCALE_MAX .93 //%%% upper bar for how much the card shrinks. Higher = shrinks less
#define ROTATION_MAX 1 //%%% the maximum rotation allowed in radians.  Higher = card can keep rotating longer
#define ROTATION_STRENGTH 320 //%%% strength of rotation. Higher = weaker rotation
#define ROTATION_ANGLE M_PI/8 //%%% Higher = stronger rotation angle


#import "DraggableView.h"

@implementation DraggableView {
    CGFloat xFromCenter;
    CGFloat yFromCenter;
}

//delegate is instance of ViewController
@synthesize delegate;


@synthesize panGestureRecognizer;
@synthesize pickbackground;
@synthesize overlayView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
        

        
        self.backgroundColor = [UIColor whiteColor];

        
        
        
        panGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(beingDragged:)];
        
        [self addGestureRecognizer:panGestureRecognizer];
//        [self addSubview:information];
        
        [self addProfileBackground];
        [self addProfileImage];
        [self addSocialBackground];
        [self setupNameLabel];
        [self setupdateLabel];

        
        overlayView = [[OverlayView alloc]initWithFrame:CGRectMake(self.frame.size.width/2-100, 0, 100, 100)];
        overlayView.alpha = 0;
        [self addSubview:overlayView];
    }
    return self;
}

-(void)setupView
{
    self.layer.cornerRadius = 4;
    self.layer.shadowRadius = 3;
    self.layer.shadowOpacity = 0.2;
    self.layer.shadowOffset = CGSizeMake(1, 1);
}

- (void)addProfileBackground {
    
    self.pickbackground = [[UIView alloc]initWithFrame:self.frame];
    
    self.pickbackground.backgroundColor = [self grayColor];
    self.pickbackground.translatesAutoresizingMaskIntoConstraints = NO;
    [self.pickbackground invalidateIntrinsicContentSize];
    
    //  self.pickbackground.alpha = 2.0;
    
    
    self.pickbackground.layer.masksToBounds = NO;
    self.pickbackground.layer.shadowOffset = CGSizeMake(-.1, .2);
    self.pickbackground.layer.shadowRadius = .5;
    self.pickbackground.layer.shadowOpacity = 0.5;
    
    self.pickbackground.userInteractionEnabled = YES;
    
    
    [self addSubview:self.pickbackground];
    
    CGFloat pad = 0, height = 0;
    CGFloat width = 250;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 6;
        height = 415;
        width = 292;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 7;
        height= 505;
        width = 322;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 8;
        height = 533;
        width = 350;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 5;
        height = 351;
        width = 292;
    }
    
    
    
    NSDictionary *viewsDictionary = @{@"back":self.pickbackground, @"top": self};
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.pickbackground attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-pad-[back]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self addConstraint:constraint1];
    [self addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.pickbackground attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.pickbackground attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self addConstraint:constraint4];
    
}

- (void)addProfileImage {
    
    self.pic = [[UIImageView alloc]initWithFrame:self.pickbackground.frame];
    
    self.pic.backgroundColor = [UIColor blueColor];
    CGFloat width = 0;
    self.pic.translatesAutoresizingMaskIntoConstraints = NO;
    [self.pic invalidateIntrinsicContentSize];
    
    NSData* imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"ProfileImage"];
    UIImage* image = [UIImage imageWithData:imageData];
    
    
    
    
    if (image != nil) {
        self.pic.image = [[DataAccess singletonInstance] getProfileImage];
    }else{
        self.pic.image = [UIImage imageNamed:@"image_placeholder.png"];
    }
    
    self.pic.alpha = 2.0;
    
    self.pic.userInteractionEnabled = YES;

    UITapGestureRecognizer *socialTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(goThere:)];
    [self.pic addGestureRecognizer:socialTap];
    
    
    
    [self.pickbackground addSubview:self.pic];
    
    CGFloat pad = 0, height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 1;
        height = 413;
        width = 290;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 1;
        height = 503;
        width = 320;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 1;
        height = 531;
        width = 348;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 1;
        height = 349;
        width = 290;
    }
    
    
    
    
    
    NSDictionary *viewsDictionary = @{@"image":self.pic};
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.pickbackground attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.pic attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-pad-[image]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.pickbackground addConstraint:constraint1];
    [self.pickbackground addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.pic attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.pickbackground addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.pic attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.pickbackground addConstraint:constraint4];
    
}

- (void)addSocialBackground {
    
    self.socialbackground = [[UIView alloc]initWithFrame:self.pic.frame];
    
    self.socialbackground.backgroundColor = [UIColor clearColor];//[self grayColor];
    //  CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]) - 8;
    self.socialbackground.translatesAutoresizingMaskIntoConstraints = NO;
    [self.socialbackground invalidateIntrinsicContentSize];
    
 //   self.socialbackground.alpha = 0.1;
    self.socialbackground.layer.cornerRadius = 20;
    
    self.socialbackground.userInteractionEnabled = YES;
    
    
    
    self.socialbackground.layer.masksToBounds = NO;
    self.socialbackground.layer.shadowOffset = CGSizeMake(-.1, .2);
    self.socialbackground.layer.shadowRadius = .5;
    self.socialbackground.layer.shadowOpacity = 0.5;
    
    UITapGestureRecognizer *socialTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(socialPressed:)];
    [self.socialbackground addGestureRecognizer:socialTap];


    
    
    [self.pic addSubview:self.socialbackground];
    
    CGFloat pad = 0, pad2 = 0, height = 0, width = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 10;
        pad2 = 5;
        height = 60;
        width = 190;
        self.socialbackground.layer.cornerRadius = 20;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 8;
        pad2 = 5;
        height = 60;
        width = 220;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 8;
        height = 65;
        width = 225;
        pad2 = 5;
        
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 8;
        pad2 = 5;
        height = 45;
        width = 160;
        self.socialbackground.layer.cornerRadius = 15;
        
    }
    
    
    
    
    NSDictionary *viewsDictionary = @{@"back":self.socialbackground, @"top": self.pickbackground};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-pad-[back]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[back]-pad-|" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    [self addConstraints:constraint1];
    [self addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.socialbackground attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.socialbackground attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self addConstraint:constraint4];
    
}

- (void)setupNameLabel {
    
    
    self.nameLabel = [[UILabel alloc] init];
    [self.nameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.nameLabel invalidateIntrinsicContentSize];
    self.nameLabel.textColor = [UIColor whiteColor];
    
    self.nameLabel.text = [[DataAccess singletonInstance] getName];
    
    self.nameLabel.text = [self.nameLabel.text stringByAppendingString:@", 24"];
    
    self.nameLabel.layer.shadowRadius = 3.0;
    self.nameLabel.layer.shadowOpacity = 0.5;
    
        self.nameLabel.layer.masksToBounds = NO;
    
    self.nameLabel.layer.shouldRasterize = YES;
    
    CGFloat pad = 0, pad2 = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        self.nameLabel.font = [UIFont systemFontOfSize:24];
        pad = 7;
        pad2 = 5;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        self.nameLabel.font = [UIFont systemFontOfSize:26];
        pad = 8;
        pad2 = 8;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 9;
        pad2 = 8;
        self.nameLabel.font = [UIFont systemFontOfSize:27];
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 6;
        pad2 = 4;
        self.nameLabel.font = [UIFont systemFontOfSize:19];
        
    }
    
    self.nameLabel.alpha = 100.0;
    
    [self.socialbackground addSubview:self.nameLabel];
    
    NSDictionary *viewsDictionary = @{@"top":self.pic, @"label" : self.nameLabel};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-pad-[label]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self addConstraints:constraint1];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-pad-[label]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    [self addConstraints:constraint2];
    
}


- (void)setupdateLabel {
    
    
    self.contact_time = [[UILabel alloc] init];
    
    
    
    
    [self.contact_time setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contact_time invalidateIntrinsicContentSize];
    self.contact_time.textColor = [UIColor whiteColor];
    
    self.contact_time.text = @"Encountered an hour ago";
    
    self.contact_time.layer.shadowRadius = 3.0;
    self.contact_time.layer.shadowOpacity = 0.5;
    
    self.contact_time.layer.masksToBounds = NO;
    
    self.contact_time.layer.shouldRasterize = YES;
    
    CGFloat pad = 0, pad2 = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        self.contact_time.font = [UIFont systemFontOfSize:14];
        pad = 7;
        pad2 = 7;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        self.contact_time.font = [UIFont systemFontOfSize:15];
        pad = 8;
        pad2 = 6;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 9;
        pad2 = 7;
        self.contact_time.font = [UIFont systemFontOfSize:17];
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 6;
        pad2 = 5;
        self.contact_time.font = [UIFont systemFontOfSize:11];
        //    self.nameLabel.font = [UIFont systemFontOfSize:4];
        
    }
    
    [self.socialbackground addSubview:self.contact_time];
    
    NSDictionary *viewsDictionary = @{@"label" : self.contact_time};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-pad-[label]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self addConstraints:constraint1];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[label]-pad-|" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    [self addConstraints:constraint2];
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

//%%% called when you move your finger across the screen.
// called many times a second
-(void)beingDragged:(UIPanGestureRecognizer *)gestureRecognizer
{
    //%%% this extracts the coordinate data from your swipe movement. (i.e. How much did you move?)
    xFromCenter = [gestureRecognizer translationInView:self].x; //%%% positive for right swipe, negative for left
    yFromCenter = [gestureRecognizer translationInView:self].y; //%%% positive for up, negative for down
    
    //%%% checks what state the gesture is in. (are you just starting, letting go, or in the middle of a swipe?)
    switch (gestureRecognizer.state) {
            //%%% just started swiping
        case UIGestureRecognizerStateBegan:{
            self.originalPoint = self.center;
            break;
        };
            //%%% in the middle of a swipe
        case UIGestureRecognizerStateChanged:{
            //%%% dictates rotation (see ROTATION_MAX and ROTATION_STRENGTH for details)
            CGFloat rotationStrength = MIN(xFromCenter / ROTATION_STRENGTH, ROTATION_MAX);
            
            //%%% degree change in radians
            CGFloat rotationAngel = (CGFloat) (ROTATION_ANGLE * rotationStrength);
            
            //%%% amount the height changes when you move the card up to a certain point
            CGFloat scale = MAX(1 - fabsf(rotationStrength) / SCALE_STRENGTH, SCALE_MAX);
            
            //%%% move the object's center by center + gesture coordinate
            self.center = CGPointMake(self.originalPoint.x + xFromCenter, self.originalPoint.y + yFromCenter);
            
            //%%% rotate by certain amount
            CGAffineTransform transform = CGAffineTransformMakeRotation(rotationAngel);
            
            //%%% scale by certain amount
            CGAffineTransform scaleTransform = CGAffineTransformScale(transform, scale, scale);
            
            //%%% apply transformations
            self.transform = scaleTransform;
            [self updateOverlay:xFromCenter];
            
            break;
        };
            //%%% let go of the card
        case UIGestureRecognizerStateEnded: {
            [self afterSwipeAction];
            break;
        };
        case UIGestureRecognizerStatePossible:break;
        case UIGestureRecognizerStateCancelled:break;
        case UIGestureRecognizerStateFailed:break;
    }
}

//%%% checks to see if you are moving right or left and applies the correct overlay image
-(void)updateOverlay:(CGFloat)distance
{
    if (distance > 0) {
        overlayView.mode = GGOverlayViewModeRight;
    } else {
        overlayView.mode = GGOverlayViewModeLeft;
    }
    
    overlayView.alpha = MIN(fabsf(distance)/100, 0.4);
}

//%%% called when the card is let go
- (void)afterSwipeAction
{
    if (xFromCenter > ACTION_MARGIN) {
        [self rightAction];
    } else if (xFromCenter < -ACTION_MARGIN) {
        [self leftAction];
    } else { //%%% resets the card
        [UIView animateWithDuration:0.3
                         animations:^{
                             self.center = self.originalPoint;
                             self.transform = CGAffineTransformMakeRotation(0);
                             overlayView.alpha = 0;
                         }];
    }
}

//%%% called when a swipe exceeds the ACTION_MARGIN to the right
-(void)rightAction
{
    CGPoint finishPoint = CGPointMake(500, 2*yFromCenter +self.originalPoint.y);
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.center = finishPoint;
                     }completion:^(BOOL complete){
                         [self removeFromSuperview];
                     }];
    
    [delegate cardSwipedRight:self];
    
    NSLog(@"YES");
}

//%%% called when a swip exceeds the ACTION_MARGIN to the left
-(void)leftAction
{
    CGPoint finishPoint = CGPointMake(-500, 2*yFromCenter +self.originalPoint.y);
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.center = finishPoint;
                     }completion:^(BOOL complete){
                         [self removeFromSuperview];
                     }];
    
    [delegate cardSwipedLeft:self];
    
    NSLog(@"NO");
}

-(void)rightClickAction
{
    CGPoint finishPoint = CGPointMake(600, self.center.y);
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.center = finishPoint;
                         self.transform = CGAffineTransformMakeRotation(1);
                     }completion:^(BOOL complete){
                         [self removeFromSuperview];
                     }];
    
    [delegate cardSwipedRight:self];
    
    NSLog(@"YES");
}

-(void)leftClickAction
{
    CGPoint finishPoint = CGPointMake(-600, self.center.y);
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.center = finishPoint;
                         self.transform = CGAffineTransformMakeRotation(-1);
                     }completion:^(BOOL complete){
                         [self removeFromSuperview];
                     }];
    
    [delegate cardSwipedLeft:self];
    
    NSLog(@"NO");
}



//UI Colors

-(UIColor*)grayColor{
    
    return [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.0];
}

-(UIColor*)titleColor{
    
    return [UIColor colorWithRed:0.20 green:0.80 blue:1.00 alpha:1.0];
}


-(UIColor*)backgroundColor{
    
    return [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.0];
    
    
}

//

-(UIColor*)lineColor{
    
    return [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1.0];
    
    
}

- (void)goThere:(id)sender {
        
    NSNotification* notification = [NSNotification notificationWithName:@"pushDetailView" object:self];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    /*
    NSNumber *indexPathRow = [NSNumber numberWithInt: indexPath.row];
    NSNotification* notification = [NSNotification notificationWithName:@"pushDetailView" indexPathRow object:indexPathRow];
    [[NSNotificationCenter defaultCenter] postNotification:notification]; */

}




@end
