//
//  MatchMessengerViewController.m
//  pairedUP
//
//  Created by Neil Ballard on 1/15/16.
//  Copyright © 2016 Neil_appworld. All rights reserved.
//

#import "MatchMessengerViewController.h"
#import "DeviceManager.h"
#import "DataAccess.h"
#import "UserAlbumsViewController.h"

@interface MatchMessengerViewController ()

@property (nonatomic) BOOL shouldDisplayAvatarItem;
@property (nonatomic) NSMutableArray *objectChanges;
@property (nonatomic) NSHashTable *sectionHeaders;
@property (nonatomic) NSHashTable *sectionFooters;

@property (nonatomic) BOOL showingMoreMessagesIndicator;
@property (nonatomic) BOOL hasAppeared;
@property (nonatomic) BOOL shouldShareLocation;
@property (nonatomic) BOOL canDisableAddressBar;
@property (nonatomic) dispatch_queue_t animationQueue;


@end

@implementation MatchMessengerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden = YES;
    [self.navigationItem setHidesBackButton:YES];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self styleNavBar];
    
    
}


- (void)styleNavBar {
    
    CGFloat height = 0, ypad = 0;
    
    height = 64;
    ypad = 36;
    
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        height = 64;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        height = 70;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        height = 70;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        height = 55;
    }
    
    
    // 1. hide the existing nav bar
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    // 2. create a new nav bar and style it
    UINavigationBar *newNavBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), height)];
    newNavBar.translucent = YES;
    // 3. add a new navigation item w/title to the new nav bar
    UINavigationItem *newItem = [[UINavigationItem alloc] init];
    
    UIButton* customButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    newNavBar.backgroundColor = [UIColor whiteColor];
    newNavBar.barTintColor = [UIColor whiteColor];
    
    
    
    UIView *backView =[[UIView alloc] init];// Here you can set View width and height as per your requirement for displaying titleImageView position in navigationbar
    backView.translatesAutoresizingMaskIntoConstraints = NO;
    [backView invalidateIntrinsicContentSize];
    customButton.translatesAutoresizingMaskIntoConstraints = NO;
    [customButton invalidateIntrinsicContentSize];
    customButton.backgroundColor = [UIColor blueColor];
    
    customButton.userInteractionEnabled = YES;
    [customButton addTarget:self
                     action:@selector(Edit:) forControlEvents:UIControlEventTouchUpInside];
    
    //    UIBarButtonItem* customBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:customButton];
    
    
    
    UIImage *proIcon = [[DataAccess singletonInstance] getProfileImage];
    UIImageView *viewImage = [[UIImageView alloc] init];
    viewImage.image = proIcon;
    viewImage.translatesAutoresizingMaskIntoConstraints = NO;
    [viewImage invalidateIntrinsicContentSize];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    
    nameLabel.font = [UIFont systemFontOfSize:18];
    
    
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        nameLabel.font = [UIFont systemFontOfSize:18];
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        nameLabel.font = [UIFont systemFontOfSize:18];
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        nameLabel.font = [UIFont systemFontOfSize:23];
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        nameLabel.font = [UIFont systemFontOfSize:18];
    }
    
    
    height = 15;
    
    viewImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *pictureTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(goToPic:)];
    [viewImage addGestureRecognizer:pictureTap];
    
    
    
    [nameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [nameLabel invalidateIntrinsicContentSize];
    nameLabel.textColor = [UIColor blackColor];
    
    nameLabel.text = [[DataAccess singletonInstance] getName];
    
    
    //  UIFont *fontStyle =  [NSFontAttributeName: UIFont(name: "Avenir Next", size: 27)!]
    UIImage *image = [[UIImage imageNamed:@"logo"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(goBack:)];
    
    
    newItem.leftBarButtonItem = leftBtn;
    
    
    [backView addSubview:nameLabel];
    
    
    
    
    viewImage.alpha = 1.0;
    viewImage.layer.masksToBounds = YES;
    
    
    
    
    //   backView.backgroundColor = [UIColor redColor];
    
    
    
    
    //  [backView addSubview:customButton];
    
    
    //  viewImage.backgroundColor = [UIColor clearColor];
    
    
    
    
    
    
    
    
    
    // newItem.titleView = backView;
    // 4. add the nav bar to the main view
    [newNavBar setItems:@[newItem]];
    [self.view addSubview:newNavBar];
    [newNavBar addSubview:backView];
    
    [backView addSubview:viewImage];
    
    
    /*
     NSDictionary *viewsDictionary = @{@"back":backView, @"nav": newNavBar};
     NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.topbackground attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
     NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-pad-[back]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:ypad]} views:viewsDictionary];
     [self.view addConstraint:constraint1];
     [self.view addConstraints:constraint2];
     */
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:backView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40];
    [self.view addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:backView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:100];
    [self.view addConstraint:constraint4];
    
    NSDictionary *viewsDictionary = @{@"back":backView, @"nav": newNavBar, @"image": viewImage, @"name": nameLabel};
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:newNavBar attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:backView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-pad-[back]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:20]} views:viewsDictionary];
    [self.view addConstraint:constraint1];
    [self.view addConstraints:constraint2];
    
    
    CGFloat image_height = 0, image_width = 0, v_pad = 0, h_pad = 0, n_pad = 10;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        image_height = 29;
        image_width = 31;
        v_pad = 5;
        n_pad = 10;
        viewImage.layer.cornerRadius = 15;
        h_pad = -13;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        image_height = 29;
        image_width = 31;
        v_pad = 8;
        viewImage.layer.cornerRadius = 18;
        n_pad = 16;
        h_pad = -18;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        image_height = 29;
        image_width = 31;
        v_pad = 10;
        viewImage.layer.cornerRadius = 20;
        n_pad = 18;
        h_pad = -25;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        
        image_height = 29;
        image_width = 31;
        v_pad = 0;
        viewImage.layer.cornerRadius = 14;
        n_pad = 5;
        h_pad = -11;
        
    }
    
    
    //    NSLayoutConstraint *constraint10 = [NSLayoutConstraint constraintWithItem:backView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:viewImage attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSArray *constraint10 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-pad-[image]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:10]} views:viewsDictionary];
    [self.view addConstraints:constraint10];
    NSArray *constraint20 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-pad-[image]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:v_pad]} views:viewsDictionary];
    //   [self.view addConstraint:constraint10];
    [self.view addConstraints:constraint20];
    NSLayoutConstraint *constraint5 = [NSLayoutConstraint constraintWithItem:viewImage attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:image_height];
    [self.view addConstraint:constraint5];
    
    NSLayoutConstraint *constraint6 = [NSLayoutConstraint constraintWithItem:viewImage attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:image_width];
    [self.view addConstraint:constraint6];
    
    
    
    NSLayoutConstraint *constraint15 = [NSLayoutConstraint constraintWithItem:backView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:nameLabel attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:h_pad];
    NSArray *constraint12 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-pad-[name]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:n_pad]} views:viewsDictionary];
    [self.view addConstraints:constraint12];
    [self.view addConstraint:constraint15];
    
    
    /*
     NSLayoutConstraint *constraint7 = [NSLayoutConstraint constraintWithItem:customButton.imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:35];
     [self.view addConstraint:constraint7];
     
     NSLayoutConstraint *constraint8 = [NSLayoutConstraint constraintWithItem:customButton.imageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:35];
     [self.view addConstraint:constraint8];
     
     */
}


+ (NSCache *)sharedMediaAttachmentCache
{
    static NSCache *_sharedCache;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedCache = [NSCache new];
    });
    return _sharedCache;
}







-(IBAction)goBack:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}



-(IBAction)goToPic:(id)sender{
    
    
    UserAlbumsViewController *account = [[UserAlbumsViewController alloc] init];
    [self.navigationItem setHidesBackButton:YES];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self.navigationController pushViewController:account animated:NO];
    
}


-(UIColor*)navColor{
    
    return [UIColor colorWithRed:0.0 green:172.0f/255.0f blue:237.0f/255.0f alpha:1.0];
}


- (void)registerForNotifications
{
    
    // Application State Notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleApplicationWillEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
}


@end
