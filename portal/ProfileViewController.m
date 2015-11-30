//
//  ProfileViewController.m
//  portal
//
//  Created by Neil Ballard on 11/17/15.
//  Copyright © 2015 Neil_appworld. All rights reserved.
//

#import "ProfileViewController.h"
#import "DeviceManager.h"
#import "AlbumsTableViewController.h"
#import "DataAccess.h"
#import "InstagramFieldViewController.h"
#import "MyProfileTableViewCell.h"
#import "AccountViewController.h"
#import "ProfilePictureViewController.h"



@interface ProfileViewController ()

@property (nonatomic, retain) UIView * background;
@property (strong, nonatomic) IBOutlet UIImageView *pic;
@property (strong, nonatomic) IBOutlet UIView *topbackground;
@property (strong, nonatomic) IBOutlet UIView *pickbackground;
@property (strong, nonatomic) IBOutlet UIView *socialbackground;
@property (strong, nonatomic) IBOutlet UIView *snapchatbackground;
@property (strong, nonatomic) IBOutlet UITextView *snapchatlabel;

@property (nonatomic, retain) UINavigationBar * navBar;


@property (strong, nonatomic) IBOutlet UIButton *facebookIcon;
@property (strong, nonatomic) IBOutlet UIButton *instagramIcon;
@property (strong, nonatomic) IBOutlet UIButton *linkedinIcon;
@property (strong, nonatomic) IBOutlet UIButton *snapchatIcon;



@end

@implementation ProfileViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.facebook = [[DataAccess singletonInstance] getFacebook];
    self.instagram = [[DataAccess singletonInstance] getInstagram];
    self.linkedinId =  [[DataAccess singletonInstance] getLinkedin];
    self.snapchat = [[DataAccess singletonInstance] getSnapchat];


    
    CGRect full = [[UIScreen mainScreen]bounds];
    self.navigationController.navigationBarHidden = NO;
    
    self.background = [[UIView alloc] initWithFrame:full];
    self.background.hidden = NO;
    self.background.backgroundColor = [self grayColor];
    self.background.contentMode = UIViewContentModeScaleAspectFill;
    self.pickbackground.userInteractionEnabled = YES;
    [self.view addSubview:self.background];
    
    
    [self styleNavBar];
    // [self initViewItems];
    [self addTopBackground];
    [self addProfileBackground];
    [self addProfileImage];

    [self addSocialBackground];
    [self addFacebookIcon];
    [self addInstagramIcon];
    [self addLinkedinIcon];
    [self addSnapchatIcon];
    [self addSnapchatBackground];
    [self addSnapchatLabel];
    //  [self addIcons];
    //  [self addLabels];
    //  [self addLines];
    //  [self addConstraints];
    
    
}


-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:YES];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self.navigationItem setHidesBackButton:NO];
    [self styleNavBar];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)styleNavBar {
    
    CGFloat height = 0, ypad = 0;
    
    height = 64;
    ypad = 36;
    
    
    // 1. hide the existing nav bar
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    // 2. create a new nav bar and style it
    self.navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), height)];
    self.navBar.translucent = YES;
    // 3. add a new navigation item w/title to the new nav bar
    UINavigationItem *newItem = [[UINavigationItem alloc] init];
    self.navBar.backgroundColor = [UIColor whiteColor];
    
    
    UIImage *image = [[UIImage imageNamed:@"back_button"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(goback)];
    
    
    newItem.leftBarButtonItem = leftBtn;
    
    
    
    UIButton *titleView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [titleView setUserInteractionEnabled:NO];
    
    UIImage *connections_image = [[UIImage imageNamed:@"connections"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [titleView setBackgroundImage:connections_image forState:UIControlStateNormal];
    //NSString *titleText = @"Portal";
    //[titleView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    //  [titleView setTitle:titleText forState:UIControlStateNormal];
    
    
    newItem.titleView = titleView;
    
    
    
    
    
    // newItem.titleView = backView;
    // 4. add the nav bar to the main view
    [self.navBar setItems:@[newItem]];
    [self.view addSubview:self.navBar];
    
    
}


- (void)addTopBackground {
    
    self.topbackground = [[UIView alloc]initWithFrame:self.view.frame];
    
    self.topbackground.backgroundColor = [self grayColor];
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    self.topbackground.translatesAutoresizingMaskIntoConstraints = NO;
    [self.topbackground invalidateIntrinsicContentSize];
    
    
    self.topbackground.userInteractionEnabled = YES;
    
    [self.view addSubview:self.topbackground];
    
    CGFloat pad = 0, height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 64;
        height = 270;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 64;
        height = 270;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 64;
        height = 270;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 64;
        height = 270;
    }
    
    
    
    NSDictionary *viewsDictionary = @{@"back":self.topbackground, @"nav": self.navigationItem};
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.topbackground attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-pad-[back]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraint:constraint1];
    [self.view addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.topbackground attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.view addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.topbackground attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.view addConstraint:constraint4];
    
}

- (void)addProfileImage {
    
    self.pic = [[UIImageView alloc]initWithFrame:self.pickbackground.frame];
    
    self.pic.backgroundColor = [UIColor blueColor];
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]) - 10;
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

    
    
    
    [self.pickbackground addSubview:self.pic];
    
    CGFloat pad = 0, height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 1;
        height = 479;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 0;
        height = 254;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 0;
        height = 254;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 0;
        height = 254;
    }
    

    
    
    
    NSDictionary *viewsDictionary = @{@"image":self.pic, @"nav": self.navigationItem};
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.pickbackground attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.pic attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-pad-[image]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.pickbackground addConstraint:constraint1];
    [self.pickbackground addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.pic attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.pickbackground addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.pic attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.pickbackground addConstraint:constraint4];
    
    
    
    
    
    
}



- (void)addProfileBackground {
    
    self.pickbackground = [[UIView alloc]initWithFrame:self.topbackground.frame];
    
    self.pickbackground.backgroundColor = [UIColor grayColor];
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]) - 8;
    self.pickbackground.translatesAutoresizingMaskIntoConstraints = NO;
    [self.pickbackground invalidateIntrinsicContentSize];
    
    //  self.pickbackground.alpha = 2.0;
    
    
    self.pickbackground.layer.masksToBounds = NO;
    self.pickbackground.layer.shadowOffset = CGSizeMake(-.1, .2);
    self.pickbackground.layer.shadowRadius = .5;
    self.pickbackground.layer.shadowOpacity = 0.5;
    
    self.pickbackground.userInteractionEnabled = YES;
    
    
    [self.topbackground addSubview:self.pickbackground];
    
    CGFloat pad = 0, height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 8;
        height = 481;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 8;
        height = 500;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 8;
        height = 256;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 8;
        height = 500;
    }
    
    
    
    NSDictionary *viewsDictionary = @{@"back":self.pickbackground, @"top": self.topbackground};
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.topbackground attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.pickbackground attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-pad-[back]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.topbackground addConstraint:constraint1];
    [self.view addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.pickbackground attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.topbackground addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.pickbackground attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.topbackground addConstraint:constraint4];
    
}


- (void)addSocialBackground {
    
    self.socialbackground = [[UIView alloc]initWithFrame:self.pic.frame];
    
    self.socialbackground.backgroundColor = [self grayColor];
  //  CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]) - 8;
    self.socialbackground.translatesAutoresizingMaskIntoConstraints = NO;
    [self.socialbackground invalidateIntrinsicContentSize];
    
    self.socialbackground.alpha = 0.5;
    self.socialbackground.layer.cornerRadius = 20;
    
    self.socialbackground.userInteractionEnabled = YES;

    
    
    self.socialbackground.layer.masksToBounds = NO;
    self.socialbackground.layer.shadowOffset = CGSizeMake(-.1, .2);
    self.socialbackground.layer.shadowRadius = .5;
    self.socialbackground.layer.shadowOpacity = 0.5;
    
    
    [self.view addSubview:self.socialbackground];
    
    CGFloat pad = 0, height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 8;
        height = 60;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 8;
        height = 60;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 8;
        height = 60;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 8;
        height = 60;
    }
    
    
    
    NSDictionary *viewsDictionary = @{@"back":self.socialbackground, @"top": self.topbackground};
        NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[back]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[back]-20-|" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraints:constraint1];
    [self.view addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.socialbackground attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.view addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.socialbackground attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:200];
    [self.view addConstraint:constraint4];
    
}

- (void)addFacebookIcon{
    
    self.facebookIcon = [[UIButton alloc]initWithFrame:self.socialbackground.frame];
    UIImage *image = [UIImage imageNamed:@"facebook_icon"];

    self.facebookIcon.backgroundColor = [UIColor blackColor];
    //  CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]) - 8;
    self.facebookIcon.translatesAutoresizingMaskIntoConstraints = NO;
    [self.facebookIcon invalidateIntrinsicContentSize];
    
    [self.facebookIcon setBackgroundImage:image forState:UIControlStateNormal];
    
    if (self.facebook != nil && [[DataAccess singletonInstance] useFBOption]) {
        self.facebookIcon.userInteractionEnabled = YES;
        [self.facebookIcon
         addTarget:self
         action:@selector(FacebookButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        self.facebookIcon.alpha = 2.0;
    }else{
        self.facebookIcon.userInteractionEnabled = NO;
        self.facebookIcon.alpha = 0.2;
    }

    
    
    
    
    [self.facebookIcon setBackgroundColor:[UIColor  clearColor]];

    

    
    self.facebookIcon.layer.masksToBounds = YES;
    //    self.socialbackground.layer.shadowOffset = CGSizeMake(-.1, .2);
    //    self.socialbackground.layer.shadowRadius = .5;
    //    self.socialbackground.layer.shadowOpacity = 0.5;
    

    
    [self.socialbackground addSubview:self.facebookIcon];
    
    CGFloat pad = 0, height = 0, pad2 = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 15;
        height = 35;
        pad2 = 11;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 17;
        height = 30;
        pad2 = 11;

    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 17;
        height = 30;
        pad2 = 11;

    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 17;
        height = 30;
        pad2 = 11;

    }
    
    
    
    NSDictionary *viewsDictionary = @{@"back":self.socialbackground, @"icon": self.facebookIcon};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-pad-[icon]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-pad-[icon]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraints:constraint1];
    [self.view addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.facebookIcon attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.view addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.facebookIcon attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:35];
    [self.view addConstraint:constraint4];
    
}


- (void)addInstagramIcon{
    
    self.instagramIcon = [[UIButton alloc]init];
    
    self.instagramIcon.backgroundColor = [UIColor blackColor];
    //  CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]) - 8;
    self.instagramIcon.translatesAutoresizingMaskIntoConstraints = NO;
    [self.instagramIcon invalidateIntrinsicContentSize];
    
    UIImage *image = [UIImage imageNamed:@"instagram_icon"];

    [self.instagramIcon setBackgroundColor:[UIColor  clearColor]];
    [self.instagramIcon setBackgroundImage:image forState:UIControlStateNormal];
    

    
    if (self.instagram != nil) {
        
        self.instagramIcon.alpha =1.0;
        self.instagramIcon.userInteractionEnabled = YES;
        [self.instagramIcon
         addTarget:self
         action:@selector(InstagramButtonClicked) forControlEvents:UIControlEventTouchUpInside];

    }else{
        self.instagramIcon.userInteractionEnabled = NO;
        self.instagramIcon.alpha = 0.2;
    }

    
    
    self.instagramIcon.layer.masksToBounds = NO;
    //    self.socialbackground.layer.shadowOffset = CGSizeMake(-.1, .2);
    //    self.socialbackground.layer.shadowRadius = .5;
    //    self.socialbackground.layer.shadowOpacity = 0.5;
    
    [self.instagramIcon
     addTarget:self
     action:@selector(InstagramButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.socialbackground addSubview:self.instagramIcon];
    
    CGFloat pad = 0, pad2 = 0, height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 15;
        
        height = 35;
        pad2 = 11;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 17;
        height = 30;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 17;
        height = 30;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 17;
        height = 30;
    }
    
    
    
    NSDictionary *viewsDictionary = @{@"back":self.socialbackground, @"icon": self.instagramIcon, @"fb": self.facebookIcon};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[fb]-pad-[icon]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-pad-[icon]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraints:constraint1];
    [self.view addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.instagramIcon attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.view addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.instagramIcon attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:35];
    [self.view addConstraint:constraint4];
    
}


- (void)addLinkedinIcon{
    
    self.linkedinIcon = [[UIButton alloc]init];
    
    self.linkedinIcon.backgroundColor = [UIColor blackColor];
    //  CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]) - 8;
    self.linkedinIcon.translatesAutoresizingMaskIntoConstraints = NO;
    [self.linkedinIcon invalidateIntrinsicContentSize];
    
    UIImage *image = [UIImage imageNamed:@"linkedin_icon"];
    
    [self.linkedinIcon setBackgroundImage:image forState:UIControlStateNormal];
    
    [self.linkedinIcon setBackgroundColor:[UIColor  clearColor]];

    
    if (self.linkedinId != nil && [[DataAccess singletonInstance] uselinkedinOption]) {
        
        self.linkedinIcon.alpha =1.0;
        self.linkedinIcon.userInteractionEnabled = YES;
        [self.linkedinIcon
         addTarget:self
         action:@selector(LinkedinButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        
    }else{
        self.linkedinIcon.userInteractionEnabled = NO;
        self.linkedinIcon.alpha = 0.2;
    }
    


    
    self.linkedinIcon.layer.masksToBounds = NO;
    //    self.socialbackground.layer.shadowOffset = CGSizeMake(-.1, .2);
    //    self.socialbackground.layer.shadowRadius = .5;
    //    self.socialbackground.layer.shadowOpacity = 0.5;
    

    
    
    [self.socialbackground addSubview:self.linkedinIcon];
    
    CGFloat pad = 0, height = 0 , pad2 = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 15;
        height = 35;
        pad2 = 11;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 17;
        height = 30;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 17;
        height = 30;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 17;
        height = 30;
    }
    
    
    
    NSDictionary *viewsDictionary = @{@"back":self.socialbackground, @"icon": self.instagramIcon, @"link": self.linkedinIcon};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[icon]-pad-[link]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-pad-[link]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraints:constraint1];
    [self.view addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.linkedinIcon attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.view addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.linkedinIcon attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:35];
    [self.view addConstraint:constraint4];
    
}





- (void)addSnapchatIcon{
    
    self.snapchatIcon = [[UIButton alloc]init];
    
    self.snapchatIcon.backgroundColor = [UIColor blackColor];
    //  CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]) - 8;
    self.snapchatIcon.translatesAutoresizingMaskIntoConstraints = NO;
    [self.snapchatIcon invalidateIntrinsicContentSize];
    
    
    if (self.snapchat != nil) {
        
        self.snapchatIcon.alpha =1.0;
        self.snapchatIcon.userInteractionEnabled = YES;
        [self.snapchatIcon
         addTarget:self
         action:@selector(SnapchatButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        
    }else{
        self.snapchatIcon.userInteractionEnabled = NO;
        self.snapchatIcon.alpha = 0.2;
    }
    
    

    
    UIImage *image = [UIImage imageNamed:@"snapchat_icon"];
    
    [self.snapchatIcon setBackgroundImage:image forState:UIControlStateNormal];
    
    [self.snapchatIcon setBackgroundColor:[UIColor  clearColor]];


    
    self.snapchatIcon.layer.masksToBounds = NO;
    //    self.socialbackground.layer.shadowOffset = CGSizeMake(-.1, .2);
    //    self.socialbackground.layer.shadowRadius = .5;
    //    self.socialbackground.layer.shadowOpacity = 0.5;
    
    
    [self.socialbackground addSubview:self.snapchatIcon];
    
    CGFloat pad = 0, height = 0, pad2 = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 15;
        height = 35;
        pad2 = 11;

    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 17;
        height = 30;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 17;
        height = 30;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 17;
        height = 30;
    }
    
    
    
    NSDictionary *viewsDictionary = @{@"back":self.socialbackground, @"icon": self.linkedinIcon, @"snap": self.snapchatIcon};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[icon]-pad-[snap]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-pad-[snap]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraints:constraint1];
    [self.view addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.snapchatIcon attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.view addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.snapchatIcon attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:35];
    [self.view addConstraint:constraint4];
    
}

- (void)addSnapchatBackground {
    
    self.snapchatbackground = [[UIView alloc]initWithFrame:self.pic.frame];
    
    self.snapchatbackground.backgroundColor = [self grayColor];
    //  CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]) - 8;
    self.snapchatbackground.translatesAutoresizingMaskIntoConstraints = NO;
    [self.snapchatbackground invalidateIntrinsicContentSize];
    
    self.snapchatbackground.alpha = 0.5;
    self.snapchatbackground.layer.cornerRadius = 20;
    
    self.snapchatbackground.hidden = YES;
    
    self.snapchatbackground.userInteractionEnabled = YES;
    
    
    
    self.snapchatbackground.layer.masksToBounds = NO;
    self.snapchatbackground.layer.shadowOffset = CGSizeMake(-.1, .2);
    self.snapchatbackground.layer.shadowRadius = .5;
    self.snapchatbackground.layer.shadowOpacity = 0.5;
    
    
    [self.view addSubview:self.snapchatbackground];
    
    CGFloat pad = 0, height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 8;
        height = 60;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 8;
        height = 60;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 8;
        height = 60;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 8;
        height = 60;
    }
    
    
    
    NSDictionary *viewsDictionary = @{@"back":self.snapchatbackground, @"bottom": self.socialbackground};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[back]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[back]-10-[bottom]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraints:constraint1];
    [self.view addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.snapchatbackground attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.view addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.snapchatbackground attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:200];
    [self.view addConstraint:constraint4];
    
}


- (void)addSnapchatLabel {
    UIFont *font;
    CGFloat height = 0;
    
    self.snapchatlabel.hidden = YES;
    
    self.snapchatlabel = [[UITextView alloc] init];
    
    self.snapchatlabel.textContainer.maximumNumberOfLines = 1;
    
    CGFloat pad = 10, pad2 = 8;
    
    self.snapchatlabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:13];
    height = 15;
    
    self.snapchatlabel.backgroundColor = [UIColor clearColor];
    

    self.snapchatlabel.editable = NO;
    self.snapchatlabel.selectable = YES;
    
    
    [self.snapchatlabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.snapchatlabel invalidateIntrinsicContentSize];
    self.snapchatlabel.font = font;
    self.snapchatlabel.textColor = [UIColor blackColor];
    
    self.snapchatlabel.text = @"twelve_characters and other";
    //[[DataAccess singletonInstance] getSnapchat];
    
    [self.snapchatbackground addSubview:self.snapchatlabel];
    
    
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.snapchatbackground attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.snapchatlabel attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    [self.snapchatbackground addConstraint:constraint1];
    NSLayoutConstraint *constraint2 = [NSLayoutConstraint constraintWithItem:self.snapchatbackground attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.snapchatlabel attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    [self.snapchatbackground addConstraint:constraint2];
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.snapchatlabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30];
    [self.snapchatbackground addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.snapchatlabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:150];
    [self.snapchatbackground addConstraint:constraint4];

    
}


-(void)FacebookButtonClicked{
    
//    NSString *facebook =  [[DataAccess singletonInstance] getFacebook];
    
    NSString *url = @"fb://profile/";
  //  NSURL *bUrl = [NSURL URLWithString:url];
  //  NSURL *fbURL = [bUrl URLByAppendingPathComponent:facebook];
    
    NSURL *fbURL = [NSURL URLWithString:url];
    
    NSLog(@"%@", fbURL);
    
    //    if ([[UIApplication sharedApplication] canOpenURL:instagramURL]) {
    NSLog(@"trying to open");
    [[UIApplication sharedApplication] openURL:fbURL];
    //   }
    
    // fb://profile/<id>
}


-(void)InstagramButtonClicked{
    
    NSString *insta =  [[DataAccess singletonInstance] getInstagram];
    
    NSString *url = @"instagram://user?username=";
    NSString *bURL = [url stringByAppendingString:insta];
    NSURL *instagramURL = [NSURL URLWithString:bURL];
    //NSURL *instagramURL = [bUrl URLByAppendingPathComponent:insta];

    NSLog(@"%@", instagramURL);
    
    //    if ([[UIApplication sharedApplication] canOpenURL:instagramURL]) {
    NSLog(@"trying to open");
    [[UIApplication sharedApplication] openURL:instagramURL];
    //   }

}



-(void)LinkedinButtonClicked{
    
    //    NSURL *linkURL = [NSURL URLWithString:@"linkedin://#profile/45b862b6"];
    //    [[UIApplication sharedApplication] openURL:linkURL];
    
    
    
    [[LISDKDeeplinkHelper sharedInstance] viewOtherProfile:self.linkedinId withState:self.linkedinId showGoToAppStoreDialog:YES success:nil error:nil];
 
}

-(void)SnapchatButtonClicked{
    
    self.snapchatlabel.hidden = NO;
    self.snapchatbackground.hidden = NO;

  
}


-(UIColor*)titleColor{
    
    return [UIColor colorWithRed:0.20 green:0.80 blue:1.00 alpha:1.0];
}



-(UIColor*)grayColor{
    
    return [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.0];
}

-(void)goback{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}



@end
