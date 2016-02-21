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

@property (strong, nonatomic)  UIImageView *pickbackground;


@property (strong, nonatomic)  UIImageView *pickbackground2;
@property (strong, nonatomic)  UIImageView *pickbackground3;
@property (strong, nonatomic)  UIImageView *pickbackground4;
@property (strong, nonatomic)  UIImageView *pickbackground5;


@property (strong, nonatomic)  UILabel *networksLabel;
@property (nonatomic, retain) UIView * Line;
@property (nonatomic, retain) UINavigationBar * navBar;


@end



@implementation AccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    [self.navigationItem setHidesBackButton:YES];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    // [self initViewItems];
    [self styleNavBar];
    
    [self addProfileBackground];
    [self addProfileBackground2];
    [self addProfileBackground3];
    [self addProfileBackground4];
    [self addProfileBackground5];
    
    [self addEditIcon];
    [self setupEditLabel];
    
    [self addEduIcon];
    [self setupEduLabel];
    [self setupEduText];
    
    [self addWorkIcon];
    [self setupWorkLabel];
    [self setupWorkText];
    
    [self addinfoIcon];
    [self setupInfoLabel];
    [self setupInfoText];

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
    UIImage* image5 = [[DataAccess singletonInstance] getProfileImage4];
    
    
    if (image != nil) {
        self.pickbackground.image = image;
    }else{
        self.pickbackground.image = [UIImage imageNamed:@"image_placeholder.png"];
    }
    
    if (image2 != nil) {
        self.pickbackground2.image = image2;
    }else{
        self.pickbackground2.image = [UIImage imageNamed:@"image_placeholder.png"];
    }
    
    if (image3 != nil) {
        self.pickbackground3.image = image3;
    }else{
        self.pickbackground3.image = [UIImage imageNamed:@"image_placeholder.png"];
    }
    
    if (image4 != nil) {
        self.pickbackground4.image = image4;
    }else {
        self.pickbackground4.image = [UIImage imageNamed:@"image_placeholder.png"];
    }

    if (image5 != nil) {
        self.pickbackground5.image = image5;
    }else {
        self.pickbackground5.image = [UIImage imageNamed:@"image_placeholder.png"];
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
    self.navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), height)];
    self.navBar.translucent = YES;
    // 3. add a new navigation item w/title to the new nav bar
    UINavigationItem *newItem = [[UINavigationItem alloc] init];
    
    UIButton* customButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.navBar.backgroundColor = [UIColor whiteColor];
    self.navBar.barTintColor = [UIColor whiteColor];
    
    
    
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

    [self.navBar setItems:@[newItem]];
    [self.view addSubview:self.navBar];
    [self.navBar addSubview:backView];
    
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
    
    NSDictionary *viewsDictionary = @{@"back":backView, @"nav": self.navBar, @"image": viewImage, @"name": nameLabel};
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.navBar attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:backView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-pad-[back]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:20]} views:viewsDictionary];
    [self.view addConstraint:constraint1];
    [self.view addConstraints:constraint2];
    
    
    CGFloat image_size = 0, v_pad = 0, h_pad = 0, n_pad = 10;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        image_size = 30;
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
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





- (void)addProfileBackground {
    
    self.pickbackground = [[UIImageView alloc]init];
    
    self.pickbackground.backgroundColor = [self cdBlue];
    CGFloat width = 0;
    self.pickbackground.translatesAutoresizingMaskIntoConstraints = NO;
    [self.pickbackground invalidateIntrinsicContentSize];
    
    self.pickbackground.layer.masksToBounds = NO;
    self.pickbackground.layer.shadowOffset = CGSizeMake(-.1, .2);
    self.pickbackground.layer.shadowRadius = .5;
    self.pickbackground.layer.shadowOpacity = 0.5;
    
    self.pickbackground.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *pictureTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(picturePressed1:)];
    [self.pickbackground addGestureRecognizer:pictureTap];
    
    
    [self.view addSubview:self.pickbackground];
    
    CGFloat pad = 0, pad2 = 0, height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 0;
        pad2 = 0;
        height = 110;
        width = self.view.frame.size.width / 3;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 8;
        height = 152;
        width = 160;
        width = self.view.frame.size.width / 3;
        
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 8;
        height = 164;
        width = 180;
        width = self.view.frame.size.width / 3;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 8;
        pad2 = 13;
        height = 117;
        width = self.view.frame.size.width / 3;
        
    }
    
    
    
    NSDictionary *viewsDictionary = @{@"back":self.pickbackground, @"nav": self.navBar};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-pad-[back]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[nav]-pad-[back]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraints:constraint1];
    [self.view addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.pickbackground attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.view addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.pickbackground attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.view addConstraint:constraint4];
    
}


- (void)addProfileBackground2 {
    
    self.pickbackground2 = [[UIImageView alloc]init];
    
    self.pickbackground2.backgroundColor = [UIColor whiteColor];
    CGFloat width = 0; //CGRectGetWidth([[UIScreen mainScreen] bounds]) - 8;
    self.pickbackground2.translatesAutoresizingMaskIntoConstraints = NO;
    [self.pickbackground2 invalidateIntrinsicContentSize];
    
    //  self.pickbackground.alpha = 2.0;
    
    
    self.pickbackground2.layer.masksToBounds = NO;
    self.pickbackground2.layer.shadowOffset = CGSizeMake(-.1, .2);
    self.pickbackground2.layer.shadowRadius = .5;
    self.pickbackground2.layer.shadowOpacity = 0.5;
    
    self.pickbackground2.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *pictureTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(picturePressed2:)];
    [self.pickbackground2 addGestureRecognizer:pictureTap];
    
    
    [self.view addSubview:self.pickbackground2];
    
    CGFloat pad = 0, pad2 = 0, height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 0;
        pad2 = 0;
        height = 110;
        width = self.view.frame.size.width / 3;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 8;
        height = 152;
        width = self.view.frame.size.width / 3;
        pad2 = 15;
        
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 8;
        height = 164;
        width = self.view.frame.size.width / 3;
        pad2 = 17;
        
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 8;
        pad2 = 13;
        height = 117;
        width = self.view.frame.size.width / 3;
        
    }
    
    
    
    NSDictionary *viewsDictionary = @{@"side":self.pickbackground, @"back": self.pickbackground2, @"nav": self.navBar};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[side]-pad-[back]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[nav]-pad-[back]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraints:constraint1];
    [self.view addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.pickbackground2 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.view addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.pickbackground2 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.view addConstraint:constraint4];
    
}


- (void)addProfileBackground3 {
    
    self.pickbackground3 = [[UIImageView alloc]init];
    
    self.pickbackground3.backgroundColor = [UIColor whiteColor];
    CGFloat width = 0; //CGRectGetWidth([[UIScreen mainScreen] bounds]) - 8;
    self.pickbackground3.translatesAutoresizingMaskIntoConstraints = NO;
    [self.pickbackground3 invalidateIntrinsicContentSize];
    
    //  self.pickbackground.alpha = 2.0;
    
    
    self.pickbackground3.layer.masksToBounds = NO;
    self.pickbackground3.layer.shadowOffset = CGSizeMake(-.1, .2);
    self.pickbackground3.layer.shadowRadius = .5;
    self.pickbackground3.layer.shadowOpacity = 0.5;
    
    self.pickbackground3.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *pictureTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(picturePressed3:)];
    [self.pickbackground3 addGestureRecognizer:pictureTap];
    
    [self.view addSubview:self.pickbackground3];
    
    CGFloat pad = 0, pad2 = 0, height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 0;
        pad2 = 0;
        height = 110;
        width = self.view.frame.size.width / 3;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 8;
        height = 152;
        width = self.view.frame.size.width / 3;
        pad2 = 15;
        
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 8;
        height = 164;
        width = self.view.frame.size.width / 3;
        pad2 = 17;
        
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 8;
        pad2 = 13;
        height = 117;
        width = self.view.frame.size.width / 3;
        
    }
    
    
    
    NSDictionary *viewsDictionary = @{@"top": self.pickbackground3, @"nav": self.navBar};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[top]-pad-|" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[nav]-pad-[top]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraints:constraint1];
    [self.view addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.pickbackground3 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.view addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.pickbackground3 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.view addConstraint:constraint4];
    
}


- (void)addProfileBackground4 {
    
    self.pickbackground4 = [[UIImageView alloc]init];
    
    self.pickbackground4.backgroundColor = [UIColor whiteColor];
    CGFloat width = 0; //CGRectGetWidth([[UIScreen mainScreen] bounds]) - 8;
    self.pickbackground4.translatesAutoresizingMaskIntoConstraints = NO;
    [self.pickbackground4 invalidateIntrinsicContentSize];
    
    //  self.pickbackground.alpha = 2.0;
    
    self.pickbackground4.userInteractionEnabled = YES;

    
    UITapGestureRecognizer *pictureTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(picturePressed4:)];
    [self.pickbackground4 addGestureRecognizer:pictureTap];
    
    
    self.pickbackground4.layer.masksToBounds = NO;
    self.pickbackground4.layer.shadowOffset = CGSizeMake(-.1, .2);
    self.pickbackground4.layer.shadowRadius = .5;
    self.pickbackground4.layer.shadowOpacity = 0.5;
    
    
    [self.view addSubview:self.pickbackground4];
    
    CGFloat pad = 0, pad2 = 0, height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 0;
        pad2 = 0;
        height = 110;
        width = self.view.frame.size.width / 3;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 8;
        height = 152;
        width = self.view.frame.size.width / 3;
        pad2 = 15;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 8;
        height = 164;
        width = self.view.frame.size.width / 3;
        pad2 = 17;
        
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 8;
        pad2 = 13;
        height = 117;
        width = self.view.frame.size.width / 3;
    }
    
    
    
    NSDictionary *viewsDictionary = @{@"back":self.pickbackground4, @"top": self.pickbackground};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-pad-[back]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[top]-pad-[back]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraints:constraint1];
    [self.view addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.pickbackground4 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.view addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.pickbackground4 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.view addConstraint:constraint4];
    
}

- (void)addProfileBackground5 {
    
    self.pickbackground5 = [[UIImageView alloc]init];
    
    self.pickbackground5.backgroundColor = [UIColor whiteColor];
    CGFloat width = 0; //CGRectGetWidth([[UIScreen mainScreen] bounds]) - 8;
    self.pickbackground5.translatesAutoresizingMaskIntoConstraints = NO;
    [self.pickbackground5 invalidateIntrinsicContentSize];
    
    //  self.pickbackground.alpha = 2.0;
    self.pickbackground5.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *pictureTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(picturePressed5:)];
    [self.pickbackground5 addGestureRecognizer:pictureTap];

    
    self.pickbackground5.layer.masksToBounds = NO;
    self.pickbackground5.layer.shadowOffset = CGSizeMake(-.1, .2);
    self.pickbackground5.layer.shadowRadius = .5;
    self.pickbackground5.layer.shadowOpacity = 0.5;
    
    
    [self.view addSubview:self.pickbackground5];
    
    CGFloat pad = 0, pad2 = 0, height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 0;
        pad2 = 0;
        height = 110;
        width = self.view.frame.size.width / 3;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 8;
        height = 152;
        width = self.view.frame.size.width / 3;
        pad2 = 15;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 8;
        height = 164;
        width = self.view.frame.size.width / 3;
        pad2 = 17;
        
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 8;
        pad2 = 13;
        height = 117;
        width = self.view.frame.size.width / 3;
    }
    
    
    
    NSDictionary *viewsDictionary = @{@"back":self.pickbackground5, @"side": self.pickbackground4, @"top": self.pickbackground2};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[side]-pad-[back]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[top]-pad-[back]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraints:constraint1];
    [self.view addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.pickbackground5 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.view addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.pickbackground5 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.view addConstraint:constraint4];
    
}


- (void)addEditIcon {
    
    self.editIcon = [[UIImageView alloc]init];
    
    
    
    self.editIcon.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.editIcon invalidateIntrinsicContentSize];
    
    
    
    self.editIcon.backgroundColor = [UIColor blueColor];
    
    
    
    self.editIcon.alpha = 0.1;
    
    self.editIcon.layer.cornerRadius = 10;
    
    
    
    self.editIcon.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *pictureTap =
    
    [[UITapGestureRecognizer alloc] initWithTarget:self
     
                                            action:@selector(goToEdit:)];
    
    [self.editIcon addGestureRecognizer:pictureTap];
    
    
    
    [self.view addSubview:self.editIcon];
    
    
    
    CGFloat pad = 0, height = 0, width;
    
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
        
    {
        
        pad = 40;
        height = 28;
        width = 55;
        
        self.editIcon.layer.masksToBounds = YES;
        
        self.editIcon.layer.shadowOffset = CGSizeMake(-.1, .2);
        
        self.editIcon.layer.shadowRadius = .5;
        
        self.editIcon.layer.shadowOpacity = 0.5;
        
    }
    
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
        
    {
        
        pad = 40;
        
        height = 205;
        
        width = 205;
        
        self.editIcon.layer.masksToBounds = YES;
        
        self.editIcon.layer.shadowOffset = CGSizeMake(-.1, .2);
        
        self.editIcon.layer.shadowRadius = .5;
        
        self.editIcon.layer.shadowOpacity = 0.5;
        
        
        
    }
    
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
        
    {
        
        pad = 40;
        
        height = 205;
        
        width = 205;
        
        self.editIcon.layer.masksToBounds = YES;
        
        self.editIcon.layer.shadowOffset = CGSizeMake(-.1, .2);
        
        self.editIcon.layer.shadowRadius = .5;
        
        self.editIcon.layer.shadowOpacity = 0.5;
        
        
        
    }
    
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        
        pad = 40;
        
        height = 205;
        
        width = 205;
        
        self.editIcon.layer.masksToBounds = YES;
        
        self.editIcon.layer.shadowOffset = CGSizeMake(-.1, .2);
        
        self.editIcon.layer.shadowRadius = .5;
        
        self.editIcon.layer.shadowOpacity = 0.5;
        
    }
    
    
    
    NSDictionary *viewsDictionary = @{@"top" : self.pickbackground5, @"icon" : self.editIcon};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[top]-pad-[icon]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:25]} views:viewsDictionary];
    [self.view addConstraints:constraint1];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[icon]-pad-|" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:20]} views:viewsDictionary];
    [self.view addConstraints:constraint2];
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.editIcon attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    
    [self.view addConstraint:constraint3];
    
    
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.editIcon attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    
    [self.view addConstraint:constraint4];
    

    
}




- (void)setupEditLabel {
    
    
    self.editLabel = [[UILabel alloc] init];
    [self.editLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.editLabel invalidateIntrinsicContentSize];
    self.editLabel.textColor = [UIColor whiteColor];
    
    self.editLabel.text = @"EDIT";
    
    
    self.editLabel.layer.masksToBounds = NO;
    
    //   self.nameLabel.layer.shouldRasterize = YES;
    
    CGFloat pad = 0, pad2 = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        self.editLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:13];
        pad = 35;
        pad2 = 17;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        self.editLabel.font = [UIFont systemFontOfSize:26];
        pad = 8;
        pad2 = 12;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 9;
        pad2 = 16;
        self.editLabel.font = [UIFont systemFontOfSize:27];
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 6;
        pad2 = 8;
        self.editLabel.font = [UIFont systemFontOfSize:19];
        
    }
    
    self.editLabel.alpha = 100.0;
    
    [self.editIcon addSubview:self.editLabel];
    
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.editLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.editIcon attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    [self.view addConstraint:constraint1];
    NSLayoutConstraint *constraint2 = [NSLayoutConstraint constraintWithItem:self.editLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.editIcon attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    [self.view addConstraint:constraint2];
    

}


- (void)addinfoIcon {
    
    
    
    self.infoIcon = [[UIImageView alloc]init];
    
    
    
    self.infoIcon.backgroundColor = [UIColor blueColor];
    
    self.infoIcon.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.infoIcon invalidateIntrinsicContentSize];
    
    
    
    [self.infoIcon setBackgroundColor:[UIColor clearColor]];
    
    
    
    
    self.infoIcon.image = [UIImage imageNamed:@"info"];
    
    
    
    self.infoIcon.alpha = 2.0;
    
    
    
    self.infoIcon.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *pictureTap =
    
    [[UITapGestureRecognizer alloc] initWithTarget:self
     
                                            action:@selector(goToPic:)];
    
    [self.infoIcon addGestureRecognizer:pictureTap];
    
    
    
    [self.view addSubview:self.infoIcon];
    
    
    
    CGFloat pad = 0, height = 0, width;
    
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
        
    {
        
        pad = 40;
        height = 25;
        width = 25;
        
        self.infoIcon.layer.masksToBounds = YES;
        
        self.infoIcon.layer.shadowOffset = CGSizeMake(-.1, .2);
        
        self.infoIcon.layer.shadowRadius = .5;
        
        self.infoIcon.layer.shadowOpacity = 0.5;
        
    }
    
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
        
    {
        
        pad = 40;
        
        height = 205;
        
        width = 205;
        
        self.infoIcon.layer.cornerRadius = 102.50000;
        
        self.infoIcon.layer.masksToBounds = YES;
        
        self.infoIcon.layer.shadowOffset = CGSizeMake(-.1, .2);
        
        self.infoIcon.layer.shadowRadius = .5;
        
        self.infoIcon.layer.shadowOpacity = 0.5;
        
        
        
    }
    
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
        
    {
        
        pad = 40;
        
        height = 205;
        
        width = 205;
        
        self.infoIcon.layer.cornerRadius = 102.50000;
        
        self.infoIcon.layer.masksToBounds = YES;
        
        self.infoIcon.layer.shadowOffset = CGSizeMake(-.1, .2);
        
        self.infoIcon.layer.shadowRadius = .5;
        
        self.infoIcon.layer.shadowOpacity = 0.5;
        
        
        
    }
    
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        
        pad = 40;
        
        height = 205;
        
        width = 205;
        
        self.infoIcon.layer.cornerRadius = 102.50000;
        
        self.infoIcon.layer.masksToBounds = YES;
        
        self.infoIcon.layer.shadowOffset = CGSizeMake(-.1, .2);
        
        self.infoIcon.layer.shadowRadius = .5;
        
        self.infoIcon.layer.shadowOpacity = 0.5;
        
    }
    
    
    
    // CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]) - widthOffset;
    
    
    
    
    
    
    
    
    NSDictionary *viewsDictionary = @{@"top" : self.workIcon, @"icon" : self.infoIcon};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[top]-pad-[icon]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:33]} views:viewsDictionary];
    [self.view addConstraints:constraint1];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-pad-[icon]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:20]} views:viewsDictionary];
    [self.view addConstraints:constraint2];
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.infoIcon attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    
    [self.view addConstraint:constraint3];
    
    
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.infoIcon attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    
    [self.view addConstraint:constraint4];
    
    
    
}



- (void)addEduIcon {
    
    
    
    self.educationIcon = [[UIImageView alloc]init];
    
    
    
    self.educationIcon.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.educationIcon invalidateIntrinsicContentSize];
    
    
    
    [self.educationIcon setBackgroundColor:[UIColor clearColor]];
    
    
    
    
    self.educationIcon.image = [UIImage imageNamed:@"edu"];
    
    
    
    self.educationIcon.alpha = 2.0;
    
    
    
    self.educationIcon.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *pictureTap =
    
    [[UITapGestureRecognizer alloc] initWithTarget:self
     
                                            action:@selector(goToPic:)];
    
    [self.educationIcon addGestureRecognizer:pictureTap];
    
    
    
    [self.view addSubview:self.educationIcon];
    
    
    
    CGFloat pad = 0, height = 0, width;
    
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
        
    {
        
        pad = 40;
        height = 25;
        width = 25;
        
        self.educationIcon.layer.masksToBounds = YES;
        
        self.educationIcon.layer.shadowOffset = CGSizeMake(-.1, .2);
        
        self.educationIcon.layer.shadowRadius = .5;
        
        self.educationIcon.layer.shadowOpacity = 0.5;
        
    }
    
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
        
    {
        
        pad = 40;
        
        height = 205;
        
        width = 205;
        
        self.educationIcon.layer.cornerRadius = 102.50000;
        
        self.educationIcon.layer.masksToBounds = YES;
        
        self.educationIcon.layer.shadowOffset = CGSizeMake(-.1, .2);
        
        self.educationIcon.layer.shadowRadius = .5;
        
        self.educationIcon.layer.shadowOpacity = 0.5;
        
        
        
    }
    
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
        
    {
        
        pad = 40;
        
        height = 205;
        
        width = 205;
        
        self.educationIcon.layer.cornerRadius = 102.50000;
        
        self.educationIcon.layer.masksToBounds = YES;
        
        self.educationIcon.layer.shadowOffset = CGSizeMake(-.1, .2);
        
        self.educationIcon.layer.shadowRadius = .5;
        
        self.educationIcon.layer.shadowOpacity = 0.5;
        
        
        
    }
    
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        
        pad = 40;
        
        height = 205;
        
        width = 205;
        
        self.educationIcon.layer.cornerRadius = 102.50000;
        
        self.educationIcon.layer.masksToBounds = YES;
        
        self.educationIcon.layer.shadowOffset = CGSizeMake(-.1, .2);
        
        self.educationIcon.layer.shadowRadius = .5;
        
        self.educationIcon.layer.shadowOpacity = 0.5;
        
    }
    
    
    
    // CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]) - widthOffset;
    
    
    
    
    
    
    
    
    NSDictionary *viewsDictionary = @{@"top" : self.pickbackground4, @"icon" : self.educationIcon};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[top]-pad-[icon]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:38]} views:viewsDictionary];
    [self.view addConstraints:constraint1];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-pad-[icon]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:20]} views:viewsDictionary];
    [self.view addConstraints:constraint2];
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.educationIcon attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    
    [self.view addConstraint:constraint3];
    
    
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.educationIcon attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    
    [self.view addConstraint:constraint4];
    
    
    
}


- (void)addWorkIcon {
    
    
    
    self.workIcon = [[UIImageView alloc]init];
    
    
    
    self.workIcon.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.workIcon invalidateIntrinsicContentSize];
    
    
    
    [self.workIcon setBackgroundColor:[UIColor clearColor]];
    
    
    
    
    self.workIcon.image = [UIImage imageNamed:@"work"];
    
    
    
    self.workIcon.alpha = 2.0;
    
    
    
    self.workIcon.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *pictureTap =
    
    [[UITapGestureRecognizer alloc] initWithTarget:self
     
                                            action:@selector(goToPic:)];
    
    [self.workIcon addGestureRecognizer:pictureTap];
    
    
    
    [self.view addSubview:self.workIcon];
    
    
    
    CGFloat pad = 0, height = 0, width;
    
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
        
    {
        
        pad = 40;
        height = 25;
        width = 25;
        
        self.workIcon.layer.masksToBounds = YES;
        
        self.workIcon.layer.shadowOffset = CGSizeMake(-.1, .2);
        
        self.workIcon.layer.shadowRadius = .5;
        
        self.workIcon.layer.shadowOpacity = 0.5;
        
    }
    
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
        
    {
        
        pad = 40;
        
        height = 205;
        
        width = 205;
        
        self.workIcon.layer.masksToBounds = YES;
        
        self.workIcon.layer.shadowOffset = CGSizeMake(-.1, .2);
        
        self.workIcon.layer.shadowRadius = .5;
        
        self.workIcon.layer.shadowOpacity = 0.5;
        
        
        
    }
    
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
        
    {
        
        pad = 40;
        
        height = 205;
        
        width = 205;
        
        self.workIcon.layer.masksToBounds = YES;
        
        self.workIcon.layer.shadowOffset = CGSizeMake(-.1, .2);
        
        self.workIcon.layer.shadowRadius = .5;
        
        self.workIcon.layer.shadowOpacity = 0.5;
        
        
        
    }
    
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        
        pad = 40;
        
        height = 205;
        
        width = 205;
        
        self.workIcon.layer.masksToBounds = YES;
        
        self.workIcon.layer.shadowOffset = CGSizeMake(-.1, .2);
        
        self.workIcon.layer.shadowRadius = .5;
        
        self.workIcon.layer.shadowOpacity = 0.5;
        
    }
    
    
    
    NSDictionary *viewsDictionary = @{@"top" : self.educationIcon, @"icon" : self.workIcon};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[top]-pad-[icon]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:38]} views:viewsDictionary];
    [self.view addConstraints:constraint1];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-pad-[icon]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:20]} views:viewsDictionary];
    [self.view addConstraints:constraint2];
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.workIcon attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    
    [self.view addConstraint:constraint3];
    
    
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.workIcon attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    
    [self.view addConstraint:constraint4];
    
    
    
}


- (void)setupEduLabel {
    
    
    self.eduLabel = [[UILabel alloc] init];
    [self.eduLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.eduLabel invalidateIntrinsicContentSize];
    self.eduLabel.textColor = [UIColor lightGrayColor];
    
    self.eduLabel.text = @"Education";
    
    
    self.eduLabel.layer.masksToBounds = NO;
    
    //   self.nameLabel.layer.shouldRasterize = YES;
    
    CGFloat pad = 0, pad2 = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        self.eduLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:17];
        pad = 35;
        pad2 = 17;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        self.eduLabel.font = [UIFont systemFontOfSize:26];
        pad = 8;
        pad2 = 12;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 9;
        pad2 = 16;
        self.eduLabel.font = [UIFont systemFontOfSize:27];
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 6;
        pad2 = 8;
        self.eduLabel.font = [UIFont systemFontOfSize:19];
        
    }
    
    self.eduLabel.alpha = 100.0;
    
    [self.view addSubview:self.eduLabel];
    
    NSDictionary *viewsDictionary = @{@"label" : self.eduLabel, @"side" : self.educationIcon, @"top": self.pickbackground4};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[top]-pad-[label]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraints:constraint1];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[side]-pad-[label]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    [self.view addConstraints:constraint2];
    
}

- (void)setupEduText {
    
    
    self.eduTextLabel = [[UILabel alloc] init];
    [self.eduTextLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.eduTextLabel invalidateIntrinsicContentSize];
    self.eduTextLabel.textColor = [UIColor lightGrayColor];
    
    self.eduTextLabel.text = @"Florida State University";
    
    
    self.eduTextLabel.layer.masksToBounds = NO;
    
    //   self.nameLabel.layer.shouldRasterize = YES;
    
    CGFloat pad = 0, pad2 = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        self.eduTextLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
        pad = 3;
        pad2 = 18;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        self.eduTextLabel.font = [UIFont systemFontOfSize:26];
        pad = 8;
        pad2 = 12;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 9;
        pad2 = 16;
        self.eduTextLabel.font = [UIFont systemFontOfSize:27];
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 6;
        pad2 = 8;
        self.eduTextLabel.font = [UIFont systemFontOfSize:19];
        
    }
    
    self.eduTextLabel.alpha = 100.0;
    
    [self.view addSubview:self.eduTextLabel];
    
    NSDictionary *viewsDictionary = @{@"label" : self.eduTextLabel, @"side" : self.educationIcon, @"top": self.eduLabel};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[top]-pad-[label]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraints:constraint1];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[side]-pad-[label]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    [self.view addConstraints:constraint2];
    
}


- (void)setupWorkLabel {
    
    
    self.workLabel = [[UILabel alloc] init];
    [self.workLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.workLabel invalidateIntrinsicContentSize];
    self.workLabel.textColor = [UIColor lightGrayColor];
    
    self.workLabel.text = @"Job";
    
    
    self.workLabel.layer.masksToBounds = NO;
    
    //   self.nameLabel.layer.shouldRasterize = YES;
    
    CGFloat pad = 0, pad2 = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        self.workLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:17];
        pad = 25;
        pad2 = 17;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        self.workLabel.font = [UIFont systemFontOfSize:26];
        pad = 8;
        pad2 = 12;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 9;
        pad2 = 16;
        self.workLabel.font = [UIFont systemFontOfSize:27];
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 6;
        pad2 = 8;
        self.workLabel.font = [UIFont systemFontOfSize:19];
        
    }
    
    self.workLabel.alpha = 100.0;
    
    [self.view addSubview:self.workLabel];
    
    NSDictionary *viewsDictionary = @{@"label" : self.workLabel, @"side" : self.workIcon, @"top": self.eduTextLabel};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[top]-pad-[label]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraints:constraint1];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[side]-pad-[label]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    [self.view addConstraints:constraint2];
    
}

- (void)setupWorkText {
    
    
    self.workTextLabel = [[UILabel alloc] init];
    [self.workTextLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.workTextLabel invalidateIntrinsicContentSize];
    self.workTextLabel.textColor = [UIColor lightGrayColor];
    
    self.workTextLabel.text = @"Software Engineer at Nowhere";
    
    
    self.workTextLabel.layer.masksToBounds = NO;
    
    //   self.nameLabel.layer.shouldRasterize = YES;
    
    CGFloat pad = 0, pad2 = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        self.workTextLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
        pad = 3;
        pad2 = 18;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        self.workTextLabel.font = [UIFont systemFontOfSize:26];
        pad = 8;
        pad2 = 12;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 9;
        pad2 = 16;
        self.workTextLabel.font = [UIFont systemFontOfSize:27];
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 6;
        pad2 = 8;
        self.workTextLabel.font = [UIFont systemFontOfSize:19];
        
    }
    
    self.workTextLabel.alpha = 100.0;
    
    [self.view addSubview:self.workTextLabel];
    
    NSDictionary *viewsDictionary = @{@"label" : self.workTextLabel, @"side" : self.workIcon, @"top": self.workLabel};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[top]-pad-[label]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraints:constraint1];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[side]-pad-[label]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    [self.view addConstraints:constraint2];
    
}


- (void)setupInfoLabel {
    
    
    self.infoLabel = [[UILabel alloc] init];
    [self.infoLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.infoLabel invalidateIntrinsicContentSize];
    self.infoLabel.textColor = [UIColor lightGrayColor];
    
    self.infoLabel.text = @"Info";
    
    
    self.infoLabel.layer.masksToBounds = NO;
    
    //   self.nameLabel.layer.shouldRasterize = YES;
    
    CGFloat pad = 0, pad2 = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        self.infoLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:17];
        pad = 20;
        pad2 = 20;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        self.infoLabel.font = [UIFont systemFontOfSize:26];
        pad = 8;
        pad2 = 12;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 9;
        pad2 = 16;
        self.infoLabel.font = [UIFont systemFontOfSize:27];
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 6;
        pad2 = 8;
        self.infoLabel.font = [UIFont systemFontOfSize:19];
        
    }
    
    self.infoLabel.alpha = 100.0;
    
    [self.view addSubview:self.infoLabel];
    
    NSDictionary *viewsDictionary = @{@"label" : self.infoLabel, @"side" : self.infoIcon, @"top": self.workTextLabel};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[top]-pad-[label]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraints:constraint1];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[side]-pad-[label]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    [self.view addConstraints:constraint2];
    
}



- (void)setupInfoText {
    
    
    self.infoTextLabel = [[UITextView alloc] init];
    [self.infoTextLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.infoTextLabel invalidateIntrinsicContentSize];
    self.infoTextLabel.textColor = [UIColor lightGrayColor];
    self.infoTextLabel.backgroundColor = [UIColor clearColor];
    
    self.infoTextLabel.text = @"Lover of long walks on the beach. Candlelit dinners under the stars. BE A GENTLEMAN. Not here for a one night stand. snapchat: @wineloverxx3";
    
    
    self.infoTextLabel.layer.masksToBounds = NO;
    
    //   self.nameLabel.layer.shouldRasterize = YES;
    
    CGFloat pad = 0, pad2 = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        self.infoTextLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
        pad = -5;
        pad2 = 14;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        self.infoTextLabel.font = [UIFont systemFontOfSize:26];
        pad = 8;
        pad2 = 12;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 9;
        pad2 = 16;
        self.infoTextLabel.font = [UIFont systemFontOfSize:27];
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 6;
        pad2 = 8;
        self.infoTextLabel.font = [UIFont systemFontOfSize:19];
        
    }
    
    self.infoTextLabel.alpha = 100.0;
    
    [self.view addSubview:self.infoTextLabel];
    
    NSDictionary *viewsDictionary = @{@"label" : self.infoTextLabel, @"side" : self.infoIcon, @"top": self.infoLabel};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[top]-pad-[label]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraints:constraint1];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[side]-pad-[label]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    [self.view addConstraints:constraint2];
    
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.infoTextLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:200];
    [self.view addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.infoTextLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:235];
    [self.view addConstraint:constraint4];
    
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

- (void)picturePressed5:(id)sender {
    
    PhotoManager *box = [PhotoManager singletonInstance];
    
    box.boxID = @"5";
    
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

-(UIColor*)redishColor{
    return [UIColor colorWithRed:225.0f/255.0f green:117.0f/255.0f blue:117.0f/255.0f alpha:1.0];
}




@end
