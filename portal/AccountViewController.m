//
//  AccountViewController.m
//  portal
//
//  Created by Neil Ballard on 10/10/15.
//  Copyright © 2015 Neil_appworld. All rights reserved.
//

#import "AccountViewController.h"
#import "DeviceManager.h"
#import "DataAccess.h"
#import "ProfileViewController.h"
#import "FBAlbumsViewController.h"
#import "PhotoManager.h"
#import "BioInfoViewController.h"



@interface AccountViewController ()

@property (nonatomic, retain) UIView * background;
@property (strong, nonatomic) IBOutlet UIImageView *pic;
@property (strong, nonatomic) IBOutlet UIView *topbackground;
@property (strong, nonatomic) IBOutlet UIView *pickbackground;


@property (strong, nonatomic) IBOutlet UIImageView *pic2;
@property (strong, nonatomic) IBOutlet UIView *pickbackground2;
@property (strong, nonatomic) IBOutlet UIImageView *pic3;
@property (strong, nonatomic) IBOutlet UIView *pickbackground3;
@property (strong, nonatomic) IBOutlet UIImageView *pic4;
@property (strong, nonatomic) IBOutlet UIView *pickbackground4;

@property (strong, nonatomic) IBOutlet UILabel *networksLabel;



@property (nonatomic, retain) UIView * Line;


@property (nonatomic,unsafe_unretained) CGRect mainScreenBounds;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UIView * tableBack;



@end

@implementation AccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGRect full = [[UIScreen mainScreen]bounds];
    self.navigationController.navigationBarHidden = YES;
    [self.navigationItem setHidesBackButton:YES];
    self.background = [[UIView alloc] initWithFrame:full];
    self.background.hidden = NO;
    self.background.backgroundColor = [UIColor whiteColor];
    self.background.contentMode = UIViewContentModeScaleAspectFill;
    self.pickbackground.userInteractionEnabled = YES;
    [self.view addSubview:self.background];
    
    // [self initViewItems];
    [self addTopBackground];
    [self styleNavBar];
    
    [self addProfileBackground];
    [self addProfileImage];
    [self addProfileBackground2];
    [self addProfileImage2];
    [self addProfileBackground3];
    [self addProfileImage3];
    [self addProfileBackground4];
    [self addProfileImage4];
    [self setupnetworkLabel];
    [self addLine];
    [self setupnetworkTextBox];
    [self setupUserBioLabel];
    
}

-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:YES];
    

    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self styleNavBar];
    
    UIImage* image = [[DataAccess singletonInstance] getProfileImage];
    UIImage* image2 = [[DataAccess singletonInstance] getProfileImage2];
    UIImage* image3 = [[DataAccess singletonInstance] getProfileImage3];
    UIImage* image4 = [[DataAccess singletonInstance] getProfileImage4];
    
    
    if (image != nil) {
        self.pic.image = image;
    }else{
        self.pic.image = [UIImage imageNamed:@"image_placeholder.png"];
    }
    
    if (image2 != nil) {
        self.pic2.image = image2;
    }else{
        self.pic2.image = [UIImage imageNamed:@"image_placeholder.png"];
    }
    
    if (image3 != nil) {
        self.pic3.image = image3;
    }else{
        self.pic3.image = [UIImage imageNamed:@"image_placeholder.png"];
    }
    
    if (image4 != nil) {
        self.pic4.image = image4;
    }else {
        self.pic4.image = [UIImage imageNamed:@"image_placeholder.png"];
    }
    
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
                                            action:@selector(Edit:)];
    [viewImage addGestureRecognizer:pictureTap];
    
    
    
    [nameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [nameLabel invalidateIntrinsicContentSize];
    nameLabel.textColor = [UIColor blackColor];
    
    nameLabel.text = [[DataAccess singletonInstance] getName];
    
    
    //  UIFont *fontStyle =  [NSFontAttributeName: UIFont(name: "Avenir Next", size: 27)!]
    UIImage *image = [[UIImage imageNamed:@"down_arrow"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(Settings:)];
    
    
    newItem.rightBarButtonItem = rightBtn;
    
    
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
    
    
    CGFloat image_size = 0, v_pad = 0, h_pad = 0, n_pad = 10;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        image_size = 32;
        v_pad = 5;
        n_pad = 10;
        viewImage.layer.cornerRadius = 15;
        h_pad = -13;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        image_size = 35;
        v_pad = 8;
        viewImage.layer.cornerRadius = 18;
        n_pad = 16;
        h_pad = -18;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        image_size = 40;
        v_pad = 10;
        viewImage.layer.cornerRadius = 20;
        n_pad = 18;
        h_pad = -25;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        
        image_size = 28;
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
    NSLayoutConstraint *constraint5 = [NSLayoutConstraint constraintWithItem:viewImage attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:image_size];
    [self.view addConstraint:constraint5];
    
    NSLayoutConstraint *constraint6 = [NSLayoutConstraint constraintWithItem:viewImage attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:image_size];
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





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)addTopBackground {
    
    self.topbackground = [[UIView alloc]init];
    
    self.topbackground.backgroundColor = [UIColor whiteColor];
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    self.topbackground.translatesAutoresizingMaskIntoConstraints = NO;
    [self.topbackground invalidateIntrinsicContentSize];
    
    
    
    [self.view addSubview:self.topbackground];
    
    CGFloat pad = 0, height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 64;
        height = 270;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 70;
        height = 310;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 80;
        height = 320;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 55;
        height = 231;
    }
    
    
    
    NSDictionary *viewsDictionary = @{@"back":self.topbackground};
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
    
    self.pic = [[UIImageView alloc]init];
    
    self.pic.backgroundColor = [UIColor blueColor];
    CGFloat width = 0; // CGRectGetWidth([[UIScreen mainScreen] bounds]) - 10;
    self.pic.translatesAutoresizingMaskIntoConstraints = NO;
    [self.pic invalidateIntrinsicContentSize];
    

    self.pic.alpha = 2.0;
    
    
    [self.pickbackground addSubview:self.pic];
    
    CGFloat pad = 0, height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 1;
        height = 134;
        width = 138;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 1;
        height = 150;
        width = 158;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 1;
        height = 162;
        width = 178;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 1;
        height = 115;
        width = 138;
    }
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(picturePressed1:)];
    [self.pic addGestureRecognizer:tapGesture];
    
    
    if ([[DataAccess singletonInstance] LoggedInWithFB]) {
        self.pic.userInteractionEnabled = YES;
    }
    
    
    NSDictionary *viewsDictionary = @{@"image":self.pic};
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.pic attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.pickbackground attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-pad-[image]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.pickbackground addConstraint:constraint1];
    [self.pickbackground addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.pic attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.pickbackground addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.pic attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.pickbackground addConstraint:constraint4];
    
    
    
    
    
    
}



- (void)addProfileBackground {
    
    self.pickbackground = [[UIView alloc]init];
    
    self.pickbackground.backgroundColor = [self cdBlue];//[UIColor whiteColor];
    CGFloat width = 0; //CGRectGetWidth([[UIScreen mainScreen] bounds]) - 8;
    self.pickbackground.translatesAutoresizingMaskIntoConstraints = NO;
    [self.pickbackground invalidateIntrinsicContentSize];
    
    //  self.pickbackground.alpha = 2.0;
    
    
    self.pickbackground.layer.masksToBounds = NO;
    self.pickbackground.layer.shadowOffset = CGSizeMake(-.1, .2);
    self.pickbackground.layer.shadowRadius = .5;
    self.pickbackground.layer.shadowOpacity = 0.5;
    
    
    [self.topbackground addSubview:self.pickbackground];
    
    CGFloat pad = 0, pad2 = 0, height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 8;
        pad2 = 14;
        height = 136;
        width = 140;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 8;
        height = 152;
        width = 160;
        pad2 = 15;
        
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 8;
        height = 164;
        width = 180;
        pad2 = 17;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 8;
        pad2 = 13;
        height = 117;
        width = 140;
        
    }
    
    
    
    NSDictionary *viewsDictionary = @{@"back":self.pickbackground, @"top": self.topbackground};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-pad-[back]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-pad-[back]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.topbackground addConstraints:constraint1];
    [self.view addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.pickbackground attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.topbackground addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.pickbackground attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.topbackground addConstraint:constraint4];
    
}

- (void)addProfileImage2 {
    
    self.pic2 = [[UIImageView alloc]init];
    
    self.pic2.backgroundColor = [UIColor blueColor];
    CGFloat width = 0; // CGRectGetWidth([[UIScreen mainScreen] bounds]) - 10;
    self.pic2.translatesAutoresizingMaskIntoConstraints = NO;
    [self.pic2 invalidateIntrinsicContentSize];
    
    
    self.pic2.alpha = 2.0;
    
    
    
    [self.pickbackground2 addSubview:self.pic2];
    
    CGFloat pad = 0, height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 1;
        height = 134;
        width = 138;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 1;
        height = 150;
        width = 158;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 1;
        height = 162;
        width = 178;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 1;
        height = 115;
        width = 138;
    }
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(picturePressed2:)];
    [self.pic2 addGestureRecognizer:tapGesture];
    
    
    if ([[DataAccess singletonInstance] LoggedInWithFB]) {
        self.pic2.userInteractionEnabled = YES;
    }
    
    
    NSDictionary *viewsDictionary = @{@"image":self.pic2};
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.pic2 attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.pickbackground2 attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-pad-[image]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.pickbackground2 addConstraint:constraint1];
    [self.pickbackground2 addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.pic2 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.pickbackground2 addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.pic2 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.pickbackground2 addConstraint:constraint4];
    
    
    
    
    
    
}







- (void)addProfileBackground2 {
    
    self.pickbackground2 = [[UIView alloc]init];
    
    self.pickbackground2.backgroundColor = [UIColor whiteColor];
    CGFloat width = 0; //CGRectGetWidth([[UIScreen mainScreen] bounds]) - 8;
    self.pickbackground2.translatesAutoresizingMaskIntoConstraints = NO;
    [self.pickbackground2 invalidateIntrinsicContentSize];
    
    //  self.pickbackground.alpha = 2.0;
    
    
    self.pickbackground2.layer.masksToBounds = NO;
    self.pickbackground2.layer.shadowOffset = CGSizeMake(-.1, .2);
    self.pickbackground2.layer.shadowRadius = .5;
    self.pickbackground2.layer.shadowOpacity = 0.5;
    
    
    [self.topbackground addSubview:self.pickbackground2];
    
    CGFloat pad = 0, pad2 = 0, height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 8;
        pad2 = 14;
        height = 136;
        width = 140;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 8;
        height = 152;
        width = 160;
        pad2 = 15;
        
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 8;
        height = 164;
        width = 180;
        pad2 = 17;
        
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 8;
        pad2 = 13;
        height = 117;
        width = 140;
        
    }
    
    
    
    NSDictionary *viewsDictionary = @{@"back":self.pickbackground, @"top": self.pickbackground2};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-pad-[top]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[back]-pad-[top]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.topbackground addConstraints:constraint1];
    [self.view addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.pickbackground2 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.topbackground addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.pickbackground2 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.topbackground addConstraint:constraint4];
    
}


- (void)addProfileBackground3 {
    
    self.pickbackground3 = [[UIView alloc]init];
    
    self.pickbackground3.backgroundColor = [UIColor whiteColor];
    CGFloat width = 0; //CGRectGetWidth([[UIScreen mainScreen] bounds]) - 8;
    self.pickbackground3.translatesAutoresizingMaskIntoConstraints = NO;
    [self.pickbackground3 invalidateIntrinsicContentSize];
    
    //  self.pickbackground.alpha = 2.0;
    
    
    self.pickbackground3.layer.masksToBounds = NO;
    self.pickbackground3.layer.shadowOffset = CGSizeMake(-.1, .2);
    self.pickbackground3.layer.shadowRadius = .5;
    self.pickbackground3.layer.shadowOpacity = 0.5;
    
    
    [self.topbackground addSubview:self.pickbackground3];
    
    CGFloat pad = 0, pad2 = 0, height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 8;
        pad2 = 14;
        height = 136;
        width = 140;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 8;
        height = 152;
        width = 160;
        pad2 = 15;
        
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 8;
        height = 164;
        width = 180;
        pad2 = 17;
        
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 8;
        pad2 = 13;
        height = 117;
        width = 140;
        
    }
    
    
    
    NSDictionary *viewsDictionary = @{@"top": self.pickbackground3};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[top]-pad-|" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-pad-[top]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.topbackground addConstraints:constraint1];
    [self.view addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.pickbackground3 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.topbackground addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.pickbackground3 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.topbackground addConstraint:constraint4];
    
}

- (void)addProfileImage3 {
    
    self.pic3 = [[UIImageView alloc]init];
    
    self.pic3.backgroundColor = [UIColor blueColor];
    CGFloat width = 0; // CGRectGetWidth([[UIScreen mainScreen] bounds]) - 10;
    self.pic3.translatesAutoresizingMaskIntoConstraints = NO;
    [self.pic3 invalidateIntrinsicContentSize];

    
    self.pic3.alpha = 2.0;
    
    
    
    [self.pickbackground3 addSubview:self.pic3];
    
    CGFloat pad = 0, height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 1;
        height = 134;
        width = 138;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 1;
        height = 150;
        width = 158;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 1;
        height = 162;
        width = 178;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 1;
        height = 115;
        width = 138;
    }
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(picturePressed3:)];
    [self.pic3 addGestureRecognizer:tapGesture];
    
    
    if ([[DataAccess singletonInstance] LoggedInWithFB]) {
        self.pic3.userInteractionEnabled = YES;
    }
    
    
    NSDictionary *viewsDictionary = @{@"image":self.pic3};
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.pic3 attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.pickbackground3 attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-pad-[image]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.pickbackground3 addConstraint:constraint1];
    [self.pickbackground3 addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.pic3 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.pickbackground3 addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.pic3 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.pickbackground3 addConstraint:constraint4];
    
    
    
    
    
    
}

- (void)addProfileImage4 {
    
    self.pic4 = [[UIImageView alloc]init];
    
    self.pic4.backgroundColor = [UIColor blueColor];
    CGFloat width = 0; // CGRectGetWidth([[UIScreen mainScreen] bounds]) - 10;
    self.pic4.translatesAutoresizingMaskIntoConstraints = NO;
    [self.pic4 invalidateIntrinsicContentSize];
    
    self.pic4.alpha = 2.0;
    
    
    
    [self.pickbackground4 addSubview:self.pic4];
    
    CGFloat pad = 0, height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 1;
        height = 134;
        width = 138;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 1;
        height = 150;
        width = 158;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 1;
        height = 162;
        width = 178;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 1;
        height = 115;
        width = 138;
    }
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(picturePressed4:)];
    [self.pic4 addGestureRecognizer:tapGesture];
    
    
    if ([[DataAccess singletonInstance] LoggedInWithFB]) {
        self.pic4.userInteractionEnabled = YES;
    }
    
    
    NSDictionary *viewsDictionary = @{@"image":self.pic4};
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.pic4 attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.pickbackground4 attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-pad-[image]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.pickbackground4 addConstraint:constraint1];
    [self.pickbackground4 addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.pic4 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.pickbackground4 addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.pic4 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.pickbackground4 addConstraint:constraint4];
    
    
    
    
    
    
}







- (void)addProfileBackground4 {
    
    self.pickbackground4 = [[UIView alloc]init];
    
    self.pickbackground4.backgroundColor = [UIColor whiteColor];
    CGFloat width = 0; //CGRectGetWidth([[UIScreen mainScreen] bounds]) - 8;
    self.pickbackground4.translatesAutoresizingMaskIntoConstraints = NO;
    [self.pickbackground4 invalidateIntrinsicContentSize];
    
    //  self.pickbackground.alpha = 2.0;
    
    
    self.pickbackground4.layer.masksToBounds = NO;
    self.pickbackground4.layer.shadowOffset = CGSizeMake(-.1, .2);
    self.pickbackground4.layer.shadowRadius = .5;
    self.pickbackground4.layer.shadowOpacity = 0.5;
    
    
    [self.topbackground addSubview:self.pickbackground4];
    
    CGFloat pad = 0, pad2 = 0, height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 8;
        pad2 = 14;
        height = 136;
        width = 140;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 8;
        height = 152;
        width = 160;
        pad2 = 15;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 8;
        height = 164;
        width = 180;
        pad2 = 17;
        
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 8;
        pad2 = 13;
        height = 117;
        width = 140;
    }
    
    
    
    NSDictionary *viewsDictionary = @{@"back":self.pickbackground3, @"top": self.pickbackground4};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[top]-pad-|" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[back]-pad-[top]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.topbackground addConstraints:constraint1];
    [self.view addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.pickbackground4 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.topbackground addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.pickbackground4 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.topbackground addConstraint:constraint4];
    
}






- (void)setupnetworkLabel {
    UIFont *font;
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    
    CGFloat height = 0;
    
    self.networksLabel = [[UILabel alloc] init];
    
    self.networksLabel.font = [UIFont systemFontOfSize:5];
    height = 15;
    
    CGFloat pad = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 27;
        height = 180;
        self.networksLabel.font = [UIFont systemFontOfSize:16];
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 27;
        height = 180;
        self.networksLabel.font = [UIFont systemFontOfSize:17];
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 8;
        height = 180;
        self.networksLabel.font = [UIFont systemFontOfSize:18];
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 5;
        height = 180;
        self.networksLabel.font = [UIFont systemFontOfSize:15];
        
    }
    
    
    
    [self.networksLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.networksLabel invalidateIntrinsicContentSize];
    self.networksLabel.font = [UIFont fontWithName:@"Verdana" size:17.0f];
    self.networksLabel.textColor = [self cdBlue];
    
    self.networksLabel.text = @"Bio";
    
    [self.view addSubview:self.networksLabel];
    
    UIView *top = self.topbackground;
    NSDictionary *viewsDictionary = @{@"top":top, @"label" : self.networksLabel};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[label]" options:0 metrics:nil views:viewsDictionary];
    [self.view addConstraints:constraint1];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[top]-pad-[label]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraints:constraint2];
    
}


- (void)setupnetworkTextBox {
    
    self.networkTextBox = [[UIView alloc]init];

    self.networkTextBox.layer.cornerRadius = 7.0;
    self.networkTextBox.translatesAutoresizingMaskIntoConstraints = NO;
    [self.networkTextBox invalidateIntrinsicContentSize];


  //  if ([[DataAccess singletonInstance] getInstagram] != nil) {
  //      self.networkTextField.text = [[DataAccess singletonInstance] getInstagram];
  //  }
    
    CGRect screen = [[UIScreen mainScreen] bounds];
    CGFloat height = 0, width = 0, xpad = 0, ypad = 0;
    width = screen.size.width - 30;
    CGFloat font_size = 0;
    
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        height = 150;
        xpad = 15;
        ypad = 3;
        font_size = 12;

    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        height = 200;
        xpad = 15;
        ypad = 5;
        font_size = 13;

    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        height = 45;
        xpad = 15;
        ypad = 10;
        font_size = 14;

    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad])
    {
        height = 30;
        xpad = 15;
        ypad = 0;
        font_size = 11;

    }
    
    UIColor *color = [UIColor lightGrayColor];

    
    self.networkTextBox.userInteractionEnabled = YES;
    UITapGestureRecognizer *textBoxPressed =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(textBoxPressed:)];
    [self.networkTextBox addGestureRecognizer:textBoxPressed];
    
    
    self.networkTextBox.backgroundColor = [UIColor whiteColor];
    self.networkTextBox.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.networkTextBox.layer.borderWidth = 0.5f;
    self.networkTextBox.layer.masksToBounds = YES;
    
    NSMutableDictionary *viewsDictionary = [[NSMutableDictionary alloc] init];
    [viewsDictionary setObject:self.networkTextBox forKey:@"textField"];
    [viewsDictionary setObject:self.Line forKey:@"label"];
    
    [self.view addSubview:self.networkTextBox];
    
    NSArray *hConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-xpad-[textField]" options:0 metrics:@{@"xpad" : [NSNumber numberWithFloat:xpad], @"width" : [NSNumber numberWithFloat:width]} views:viewsDictionary];
    NSArray *vConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[label]-pad-[textField(height)]" options:0 metrics:@{@"height" : [NSNumber numberWithFloat:height], @"pad" : [NSNumber numberWithFloat:ypad]} views:viewsDictionary];
    
    [self.view addConstraints:hConstraints];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.networkTextBox attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width]];
    
    [self.view addConstraints:vConstraints];
    
}





- (void)addLine{
    
    self.Line = [[UIView alloc]init];
    
    self.Line.backgroundColor = [UIColor whiteColor];
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    self.Line.translatesAutoresizingMaskIntoConstraints = NO;
    [self.Line invalidateIntrinsicContentSize];
    
    
    
    [self.view addSubview:self.Line];
    
    CGFloat pad = 0, height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 2;
        height = 1;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 2;
        height = 1;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 2;
        height = 1;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 2;
        height = 1;
    }
    
    
    
    NSDictionary *viewsDictionary = @{@"top":self.networksLabel, @"line": self.Line};
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.Line attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[top]-pad-[line]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraint:constraint1];
    [self.view addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.Line attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.view addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.Line attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.view addConstraint:constraint4];
    
}

- (void)setupUserBioLabel {
        CGFloat height = 0;
    
    self.userBioLabel = [[UILabel alloc] init];
    
    self.userBioLabel.font = [UIFont systemFontOfSize:5];
    height = 15;
    
    CGFloat pad = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 5;
        height = 180;
        self.userBioLabel.font = [UIFont systemFontOfSize:16];
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 27;
        height = 180;
        self.userBioLabel.font = [UIFont systemFontOfSize:17];
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 8;
        height = 180;
        self.userBioLabel.font = [UIFont systemFontOfSize:18];
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 5;
        height = 180;
        self.userBioLabel.font = [UIFont systemFontOfSize:15];
        
    }
    
    
    
    [self.userBioLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.userBioLabel invalidateIntrinsicContentSize];
    self.userBioLabel.font = [UIFont fontWithName:@"Verdana" size:17.0f];
    self.userBioLabel.textColor = [UIColor lightGrayColor];
    
    self.userBioLabel.text = [[DataAccess singletonInstance] getBio];
    NSLog(@"the bio is %@", self.userBioLabel.text);
    
    [self.networkTextBox addSubview:self.userBioLabel];
    
    NSDictionary *viewsDictionary = @{@"label" : self.userBioLabel};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-7-[label]" options:0 metrics:nil views:viewsDictionary];
    [self.view addConstraints:constraint1];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-pad-[label]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraints:constraint2];
    
}



- (void)picturePressed1:(id)sender {
    
    PhotoManager *box = [PhotoManager singletonInstance];
    
    box.boxID = @"1";
    
    FBAlbumsViewController *albums = [[FBAlbumsViewController alloc] init];
    [self.navigationItem setHidesBackButton:YES];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.navigationController pushViewController:albums animated:YES];

    
}

- (void)picturePressed2:(id)sender {
    
    PhotoManager *box = [PhotoManager singletonInstance];
    
    box.boxID = @"2";

    
    FBAlbumsViewController *albums = [[FBAlbumsViewController alloc] init];
    [self.navigationItem setHidesBackButton:YES];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.navigationController pushViewController:albums animated:YES];

    
}

- (void)picturePressed3:(id)sender {
    
    PhotoManager *box = [PhotoManager singletonInstance];
    
    box.boxID = @"3";
    
    FBAlbumsViewController *albums = [[FBAlbumsViewController alloc] init];
    [self.navigationItem setHidesBackButton:YES];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.navigationController pushViewController:albums animated:YES];
    
}

- (void)picturePressed4:(id)sender {
    
    PhotoManager *box = [PhotoManager singletonInstance];
    
    box.boxID = @"4";
    
    FBAlbumsViewController *albums = [[FBAlbumsViewController alloc] init];
    [self.navigationItem setHidesBackButton:YES];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.navigationController pushViewController:albums animated:YES];

    
}

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


-(IBAction)Edit:(id)sender{
    
    ProfileViewController *account = [[ProfileViewController alloc] init];
    [self.navigationItem setHidesBackButton:NO];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.navigationController pushViewController:account animated:NO];
    
}

-(IBAction)textBoxPressed:(id)sender{
    
    BioInfoViewController *account = [[BioInfoViewController alloc] init];
    [self.navigationItem setHidesBackButton:NO];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.navigationController pushViewController:account animated:NO];
    
}

-(IBAction)Settings:(id)sender{
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.35;
    transition.timingFunction =
    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromBottom;
    
    // NSLog(@"%s: self.view.window=%@", _func_, self.view.window);
    UIView *containerView = self.view.window;
    [containerView.layer addAnimation:transition forKey:nil];
    
    [self.navigationController popViewControllerAnimated:NO];
    
    
}



- (UIColor *) cdBlue {
    return [UIColor colorWithRed:0.00 green:0.59 blue:0.84 alpha:1.0];
}





@end
