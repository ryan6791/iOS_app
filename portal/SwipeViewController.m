//
//  SwipeViewController.m
//  portal
//
//  Created by Neil Ballard on 12/13/15.
//  Copyright © 2015 Neil_appworld. All rights reserved.
//

#import "SwipeViewController.h"
#import "UserMenuViewController.h"
#import "SwipeAlbumViewController.h"
#import "JSQMessagesViewController.h"
#import "NewMatchViewController.h"
#import "MatchProfileViewController.h"

@interface SwipeViewController ()

@property (nonatomic, strong) UIImageView *settingsIcon;


@end

@implementation SwipeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    

    

    

}

- (instancetype)initWithText:(NSString *) aText backgroundColor:(UIColor *) aBkgColor {
    self = [super init];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushDetailView:) name:@"pushDetailView" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushSettings:) name:@"pushSettings" object:nil];

     //   [self addSettingsIcon];

        
        self.view.userInteractionEnabled = YES;
        
        
        [self addMainView];
        
        /*
         self.view = [[UIView alloc] initWithFrame:CGRectZero];
         self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
         self.view.backgroundColor = aBkgColor;
         
         UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
         label.text = aText;
         label.font = [UIFont boldSystemFontOfSize:40];
         label.numberOfLines = 1;
         label.textAlignment = NSTextAlignmentCenter;
         label.backgroundColor = [UIColor clearColor];
         label.textColor = [UIColor whiteColor];
         label.autoresizingMask = (UIViewAutoresizingFlexibleWidth |
         UIViewAutoresizingFlexibleTopMargin    |
         UIViewAutoresizingFlexibleBottomMargin);
         [self.view addSubview:label];
         
         CGSize bestSize = [label.attributedText boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)
         options:NSStringDrawingTruncatesLastVisibleLine
         context:NULL].size;
         label.frame = CGRectMake(0,
         ((CGRectGetHeight(self.view.frame)-bestSize.height)/2.0f),
         CGRectGetWidth(self.view.frame),
         bestSize.height); */
        
    }
    return self;
}



-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:YES];
    
 //   [self.navigationItem setHidesBackButton:YES];
 //   self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
 //   [self styleNavBar];
    

    
}

-(void)addMainView{
    
    DraggableViewBackground *draggableBackground = [[DraggableViewBackground alloc]init];
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    draggableBackground.translatesAutoresizingMaskIntoConstraints = NO;
    [draggableBackground invalidateIntrinsicContentSize];
    
 //   draggableBackground.layer.masksToBounds = NO;
 //   self.tableBack.layer.shadowOffset = CGSizeMake(-.1, .2);
 //   self.tableBack.layer.shadowRadius = .5;
 ///   self.tableBack.layer.shadowOpacity = 0.5;
    
    //
    
    //
    
    //
    
    //
    
    
    CGFloat pad = 0, sub;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 0;
        sub = 64;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 0;
        sub = 70;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 0;
        sub = 80;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 0;
        sub = 55;
    }
    
    CGFloat height = CGRectGetHeight([[UIScreen mainScreen] bounds]) - sub;

    
    [self.view addSubview:draggableBackground];
    
    
    
    NSDictionary *viewsDictionary = @{@"back":draggableBackground};
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:draggableBackground attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-pad-[back]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraint:constraint1];
    [self.view addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:draggableBackground attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.view addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:draggableBackground attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.view addConstraint:constraint4];
    
}

- (void)addSettingsIcon {
    
    self.settingsIcon = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 30, 30)];
    
    self.settingsIcon.backgroundColor = [UIColor blueColor];
    
    UIImage* image = [UIImage imageNamed:@"settings"];
    
    
    if (image != nil) {
        self.settingsIcon.image = image;
    }else{
        self.settingsIcon.image = [UIImage imageNamed:@"image_placeholder.png"];
    }
    
    self.settingsIcon.alpha = 100.0;
    
    self.settingsIcon.userInteractionEnabled = YES;
    UITapGestureRecognizer *pictureTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(goToPic:)];
    [self.settingsIcon addGestureRecognizer:pictureTap];
    
    [self.pagerNav addSubview:self.settingsIcon];
    
    CGFloat pad = 0, height = 0, width = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 40;
        height = 30;
        width = 30;
   
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 40;
        height = 30;
        width = 30;

        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 50;
        height = 30;
        width = 30;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 25;
        height = 30;
        width = 30;
    }
    
    
    /*
    NSDictionary *viewsDictionary = @{@"image":self.settingsIcon};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-pad-[image]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-pad-[image]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.pagerNav addConstraints:constraint1];
    [self.pagerNav addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.settingsIcon attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.pagerNav addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.settingsIcon attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.pagerNav addConstraint:constraint4];
    */
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)leftButtonPressed:(id)sender {
    
    UserMenuViewController *account = [[UserMenuViewController alloc] init];
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.6f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionReveal;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    [self.navigationItem setHidesBackButton:NO];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.navigationController pushViewController:account animated:YES];
    
}



- (void)rightButtonPressed:(id)sender {
    
    

  //  MessagesViewController *vc = [MessagesViewController messagesViewController];
    MatchProfileViewController *vc = [[MatchProfileViewController alloc]init];
    [self.navigationItem setHidesBackButton:YES];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self.navigationController pushViewController:vc animated:YES];

    
/*
    NewMatchViewController *account = [[NewMatchViewController alloc] init];
    self.providesPresentationContextTransitionStyle = YES;
    self.definesPresentationContext = YES;
    [account setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    account.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:account animated:YES completion:nil]; */
    
}

-(void) pushDetailView:(id)sender
{
    // do your pushViewController

    SwipeAlbumViewController *album = [[SwipeAlbumViewController alloc] init];
    [self.navigationItem setHidesBackButton:NO];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.navigationController pushViewController:album animated:NO];
    
    
    
    /*
     -(void) pushDetailView:(NSNotification*)note
     {
     NSNumber indexPathRow = [note object];
     NSDictionary *product = self.products[[indexPathRow intValue]];
     // and on with your pushViewController code
     }
     */
}

-(void) pushSettings:(id)sender
{
    UserMenuViewController *account = [[UserMenuViewController alloc] init];
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.6f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionReveal;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    [self.navigationItem setHidesBackButton:NO];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.navigationController pushViewController:account animated:YES];
}


- (DMPagerNavigationBarItem *)pagerItem {
    /*
    NSDictionary *textAttributes = @{ NSFontAttributeName : [UIFont systemFontOfSize:12.0f],
                                      NSForegroundColorAttributeName : [UIColor blackColor]};
    
    UIImage *itemIcon = [UIImage imageNamed:@"settings"];
    NSAttributedString *itemTitle = @"hello3";
    self.pagerObj = [DMPagerNavigationBarItem newItemWithText:[[NSAttributedString alloc] initWithString:@"CHAT" attributes:textAttributes] andIcon: itemIcon];
    self.pagerObj.renderingMode = DMPagerNavigationBarItemModeOnlyText; */
    return self.pagerObj;
}


-(UIColor*)navColor{
    
    return [UIColor colorWithRed:0.0 green:172.0f/255.0f blue:237.0f/255.0f alpha:1.0];
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
