//
//  MyProfileViewController.m
//  portal
//
//  Created by Neil Ballard on 11/1/15.
//  Copyright © 2015 Neil_appworld. All rights reserved.
//

#import "MyProfileViewController.h"
#import "DeviceManager.h"
#import "AlbumsTableViewController.h"
#import "DataAccess.h"
#import "InstagramFieldViewController.h"
#import "MyProfileTableViewCell.h"
#import "AccountViewController.h"
#import "ProfilePictureViewController.h"


@interface MyProfileViewController ()

@property (nonatomic, retain) UIView * background;
@property (strong, nonatomic) IBOutlet UIImageView *pic;
@property (strong, nonatomic) IBOutlet UIView *topbackground;
@property (strong, nonatomic) IBOutlet UIView *pickbackground;
@property (strong, nonatomic) IBOutlet UIImageView *fb_logo;
@property (strong, nonatomic) IBOutlet UIImageView *insta_logo;
@property (strong, nonatomic) IBOutlet UIImageView *linkedin_logo;
@property (strong, nonatomic) IBOutlet UIImageView *snapchat_logo;

@property (strong, nonatomic) IBOutlet UILabel *networksLabel;
@property (strong, nonatomic) IBOutlet UILabel *fbLabel;
@property (strong, nonatomic) IBOutlet UILabel *instaLabel;
@property (strong, nonatomic) IBOutlet UILabel *linkedinLabel;
@property (strong, nonatomic) IBOutlet UILabel *snapchatLabel;


@property (nonatomic, retain) UIView * Line;
@property (nonatomic, retain) UIView * Line1;
@property (nonatomic, retain) UIView * Line2;
@property (nonatomic, retain) UIView * Line3;
@property (nonatomic, retain) UIView * Line4;

@property (nonatomic,unsafe_unretained) CGRect mainScreenBounds;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UIView * tableBack;

@end

@implementation MyProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGRect full = [[UIScreen mainScreen]bounds];
    self.navigationController.navigationBarHidden = NO;

    self.background = [[UIView alloc] initWithFrame:full];
    self.background.hidden = NO;
    self.background.backgroundColor = [self grayColor];
    self.background.contentMode = UIViewContentModeScaleAspectFill;
    self.pickbackground.userInteractionEnabled = YES;
    [self.view addSubview:self.background];
    
    // [self initViewItems];
    [self addTopBackground];
    [self addProfileBackground];
    [self addProfileImage];
    [self setupnetworkLabel];
    [self addLine];
    
    
    [self addTableContainer];
    
    [self initTableView];
    
    [self addBottomLine];
    
    //  [self addIcons];
    //  [self addLabels];
    //  [self addLines];
    //  [self addConstraints];
    
    
}


- (void)initTableView {
    CGRect frame = [[UIScreen mainScreen] bounds];
    self.tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableBack addSubview:self.tableView];
    self.tableView.scrollEnabled = NO;
    self.tableView.backgroundColor = [self grayColor];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 1)];
    
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    
    
    CGFloat pad = 0, height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 0;
        height = 100;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 0;
        height = 250;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 0;
        height = 250;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 0;
        height = 250;
    }
    
    
    
    NSDictionary *viewsDictionary = @{@"top":self.tableBack, @"table": self.tableView};
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.tableBack attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSLayoutConstraint *YConstraint = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.tableBack attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    [self.view addConstraint:YConstraint];
    [self.tableBack addConstraint:constraint1];
    
    /*
     NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.pic attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
     [self.pickbackground addConstraint:constraint3];*/
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.tableBack addConstraint:constraint4];
    
}

-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:YES];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self.navigationItem setHidesBackButton:NO];
    [self setupTitleViewWithTitleText];
    
}

- (void)setupTitleViewWithTitleText {
   
    
    UIButton *titleView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [titleView setUserInteractionEnabled:NO];
    
    NSString *titleText = @"Portal";
    [titleView setTitleColor:[self titleColor] forState:UIControlStateNormal];
    
    [titleView setTitle:titleText forState:UIControlStateNormal];
    
    
    self.navigationItem.titleView = titleView;
    
}




- (void)initViewItems {
    
    
    self.snapchatLabel = [[UILabel alloc] init];
    [self.view addSubview:self.snapchatLabel];
    self.fbLabel = [[UILabel alloc] init];
    [self.view addSubview:self.fbLabel];
    self.instaLabel = [[UILabel alloc] init];
    [self.view addSubview:self.instaLabel];
    self.linkedinLabel = [[UILabel alloc] init];
    [self.view addSubview:self.linkedinLabel];
    
    
    
    self.Line1 = [[UIView alloc] init];
    [self.view addSubview:self.Line1];
    self.Line2 = [[UIView alloc] init];
    [self.view addSubview:self.Line2];
    self.Line3 = [[UIView alloc] init];
    [self.view addSubview:self.Line3];
    self.Line4 = [[UIView alloc] init];
    [self.view addSubview:self.Line4];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)addTopBackground {
    
    self.topbackground = [[UIView alloc]init];
    
    self.topbackground.backgroundColor = [self grayColor];
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
    
    self.pic = [[UIImageView alloc]init];
    
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
    
    
    
    [self.pickbackground addSubview:self.pic];
    
    CGFloat pad = 0, height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 1;
        height = 254;
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
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(picturePressed:)];
    [self.pic addGestureRecognizer:tapGesture];
    
    
    if ([[DataAccess singletonInstance] getProfileImage] != nil) {
        self.pic.userInteractionEnabled = YES;
    }
    
    
    
    NSDictionary *viewsDictionary = @{@"image":self.pic, @"nav": self.navigationItem};
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
    
    self.pickbackground.backgroundColor = [UIColor whiteColor];
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]) - 8;
    self.pickbackground.translatesAutoresizingMaskIntoConstraints = NO;
    [self.pickbackground invalidateIntrinsicContentSize];
    
    //  self.pickbackground.alpha = 2.0;
    
    
    self.pickbackground.layer.masksToBounds = NO;
    self.pickbackground.layer.shadowOffset = CGSizeMake(-.1, .2);
    self.pickbackground.layer.shadowRadius = .5;
    self.pickbackground.layer.shadowOpacity = 0.5;
    
    
    [self.topbackground addSubview:self.pickbackground];
    
    CGFloat pad = 0, height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 8;
        height = 256;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 8;
        height = 256;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 8;
        height = 256;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 8;
        height = 256;
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


- (void)addTableContainer {
    
    self.tableBack = [[UIView alloc]init];
    
    self.tableBack.backgroundColor = [self grayColor];
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    self.tableBack.translatesAutoresizingMaskIntoConstraints = NO;
    [self.tableBack invalidateIntrinsicContentSize];
    
    self.tableBack.layer.masksToBounds = NO;
    self.tableBack.layer.shadowOffset = CGSizeMake(-.1, .2);
    self.tableBack.layer.shadowRadius = .5;
    self.tableBack.layer.shadowOpacity = 0.5;
    
    
    [self.view addSubview:self.tableBack];
    
    CGFloat pad = 0, height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 0;
        height = 180;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 10;
        height = 180;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 10;
        height = 180;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 10;
        height = 180;
    }
    
    
    
    NSDictionary *viewsDictionary = @{@"back":self.tableBack, @"top": self.Line};
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.tableBack attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[top]-pad-[back]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraint:constraint1];
    [self.view addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.tableBack attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.view addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.tableBack attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.view addConstraint:constraint4];
    
}


- (void)setupnetworkLabel {
    UIFont *font;
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    
    CGFloat width = window.frame.size.width - 30;
    CGFloat height = 0;
    
    self.networksLabel = [[UILabel alloc] init];
    
    
    
    self.networksLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    height = 15;
    
    
    
    [self.networksLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.networksLabel invalidateIntrinsicContentSize];
    self.networksLabel.font = font;
    self.networksLabel.textColor = [self headerColor];
    
    self.networksLabel.text = @"Networks";
    
    [self.view addSubview:self.networksLabel];
    
    UIView *top = self.topbackground;
    NSDictionary *viewsDictionary = @{@"top":top, @"label" : self.networksLabel};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-17-[label]" options:0 metrics:nil views:viewsDictionary];
    [self.view addConstraints:constraint1];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[top]-6-[label]" options:0 metrics:nil views:viewsDictionary];
    [self.view addConstraints:constraint2];
    
}




- (void)addIcons {
    
    self.fb_logo = [[UIImageView alloc] init];
    self.insta_logo = [[UIImageView alloc] init];
    self.linkedin_logo = [[UIImageView alloc] init];
    self.snapchat_logo = [[UIImageView alloc] init];
    
    self.fb_logo.translatesAutoresizingMaskIntoConstraints = NO;
    [self.fb_logo invalidateIntrinsicContentSize];
    self.insta_logo.translatesAutoresizingMaskIntoConstraints = NO;
    [self.insta_logo invalidateIntrinsicContentSize];
    self.linkedin_logo.translatesAutoresizingMaskIntoConstraints = NO;
    [self.linkedin_logo invalidateIntrinsicContentSize];
    self.snapchat_logo.translatesAutoresizingMaskIntoConstraints = NO;
    [self.snapchat_logo invalidateIntrinsicContentSize];
    
    
    
    self.fb_logo.image = [UIImage imageNamed:@"facebook_icon.png"];
    self.insta_logo.image = [UIImage imageNamed:@"instagram_icon1.png"];
    self.linkedin_logo.image = [UIImage imageNamed:@"linkedin_icon.png"];
    self.snapchat_logo.image = [UIImage imageNamed:@"snapchat_icon.png"];
    
    
    CGFloat pad, pad1 = 0, pad2, height = 0, width = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad1 = 10;
        pad = 20;
        pad2 = 25;
        height = 25;
        width = 25;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 20;
        height = 25;
        width = 25;
        pad2 = 25;
        pad1 = 10;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 20;
        height = 25;
        width = 25;
        pad2 = 25;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 20;
        height = 25;
        width = 25;
        pad2 = 25;
        pad1 = 10;
        
    }
    
    
    [self.view addSubview:self.fb_logo];
    [self.view addSubview:self.insta_logo];
    [self.view addSubview:self.linkedin_logo];
    [self.view addSubview:self.snapchat_logo];
    
    NSDictionary *viewsDictionary = @{@"fb":self.fb_logo, @"snap":self.snapchat_logo, @"insta":self.insta_logo, @"linkedin":self.linkedin_logo, @"top": self.Line};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-pad-[fb]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-pad-[snap]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    NSArray *constraint3 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-27-[insta]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    NSArray *constraint4 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-pad-[linkedin]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    NSArray *constraint5 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[top]-pad1-[fb]-pad-[insta]-pad-[linkedin]-pad-[snap]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad], @"pad1":[NSNumber numberWithFloat:pad1]} views:viewsDictionary];
    [self.view addConstraints:constraint1];
    [self.view addConstraints:constraint2];
    [self.view addConstraints:constraint3];
    [self.view addConstraints:constraint4];
    [self.view addConstraints:constraint5];
    
    NSLayoutConstraint *constraint6 = [NSLayoutConstraint constraintWithItem:self.fb_logo attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.view addConstraint:constraint6];
    
    NSLayoutConstraint *constraint7 = [NSLayoutConstraint constraintWithItem:self.fb_logo attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.view addConstraint:constraint7];
    
    NSLayoutConstraint *constraint8 = [NSLayoutConstraint constraintWithItem:self.insta_logo attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:22];
    [self.view addConstraint:constraint8];
    
    NSLayoutConstraint *constraint9 = [NSLayoutConstraint constraintWithItem:self.insta_logo attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:22];
    [self.view addConstraint:constraint9];
    
    NSLayoutConstraint *constraint10 = [NSLayoutConstraint constraintWithItem:self.linkedin_logo attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.view addConstraint:constraint10];
    
    NSLayoutConstraint *constraint11 = [NSLayoutConstraint constraintWithItem:self.linkedin_logo attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.view addConstraint:constraint11];
    
    NSLayoutConstraint *constraint12 = [NSLayoutConstraint constraintWithItem:self.snapchat_logo attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.view addConstraint:constraint12];
    
    NSLayoutConstraint *constraint13 = [NSLayoutConstraint constraintWithItem:self.snapchat_logo attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.view addConstraint:constraint13];
    
    
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1
    ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Number of rows is the number of time zones in the region for the specified section.
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"MyReuseIdentifier";
    // UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    MyProfileTableViewCell *cell = (MyProfileTableViewCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil) {
        cell = [[MyProfileTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:MyIdentifier];
    }
    
    UIFont *myFont = [ UIFont fontWithName: @"Arial" size: 19.0 ];
    cell.textLabel.font  = myFont;
    
    if (indexPath.row == 0) {
        cell.imageView.image = [UIImage imageNamed:@"facebook_icon.png"];
        cell.textLabel.text = @"Facebook";
        
        if (![[DataAccess singletonInstance] useFBOption]) {
            cell.backgroundColor = [UIColor lightTextColor];
        }
        
        
    }else if (indexPath.row == 1) {
        
        cell.imageView.image = [UIImage imageNamed:@"instagram_icon1.png"];
        cell.textLabel.text = @"Instagram";
        
        if ([[DataAccess singletonInstance] getInstagram] == nil) {
            cell.backgroundColor = [UIColor lightTextColor];
        }
        
        
    }else if (indexPath.row == 2) {
        
        cell.imageView.image = [UIImage imageNamed:@"linkedin_icon.png"];
        cell.textLabel.text = @"Linkedin";
        
        if ([[DataAccess singletonInstance] getLinkedin] == nil) {
            cell.backgroundColor = [UIColor lightTextColor];
        }
        
    }
    else if (indexPath.row == 3) {
        cell.imageView.image = [UIImage imageNamed:@"snapchat_icon.png"];
        cell.textLabel.text = @"Snapchat";
        
        if ([[DataAccess singletonInstance] getSnapchat] == nil) {
            cell.backgroundColor = [UIColor lightTextColor];
        }
        
    }
    
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //  CGFloat height = self.tableBack.frame.size.height;
    return 45; //(height / 5);//[self getCellHeight];
}


/*
 -(CGFloat)getCellHeight {
 CGFloat cellHeight = 0.0;
 if([[DeviceManager sharedInstance] getIsIPhone5Screen])
 {
 cellHeight =  ceilf(163/2);
 }
 else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
 {
 cellHeight = ceilf(180/2);
 }
 else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
 {
 cellHeight = ceil(300/3);
 }
 else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
 cellHeight = ceilf(140/2);
 }
 
 return cellHeight;
 }
 
 -(CGFloat)getAccessoryViewWidth {
 CGFloat modifier = 0.0;
 if([[DeviceManager sharedInstance] getIsIPhone5Screen])
 {
 modifier =  42;
 }
 else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
 {
 modifier = 42;
 }
 else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
 {
 modifier = 48;
 }
 else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
 modifier = 42;
 }
 
 return modifier;
 }
 
 -(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
 if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
 [cell setSeparatorInset:UIEdgeInsetsZero];
 }
 if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
 [cell setLayoutMargins:UIEdgeInsetsZero];
 }
 }*/


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {

        NSString *facebook =  [[DataAccess singletonInstance] getFacebook];
        
        NSURL *fbURL = [NSURL URLWithString:@"fb://profile/1672370996"];
        //    if ([[UIApplication sharedApplication] canOpenURL:instagramURL]) {
        NSLog(@"trying to open");
        [[UIApplication sharedApplication] openURL:fbURL];
        //   }

           // fb://profile/<id>
    }
    else if (indexPath.row == 1) {
        
        NSString *insta =  [[DataAccess singletonInstance] getInstagram];
        
        NSLog(@"Instagram name is: %@", insta);
        NSURL *instagramURL = [NSURL URLWithString:@"instagram://user?username=_ryanpowers_"];
    //    if ([[UIApplication sharedApplication] canOpenURL:instagramURL]) {
            NSLog(@"trying to open");
            [[UIApplication sharedApplication] openURL:instagramURL];
     //   }
    }
    else if(indexPath.row == 2){
    self.linkedinId =  [[DataAccess singletonInstance] getLinkedin];
    //    NSURL *linkURL = [NSURL URLWithString:@"linkedin://#profile/45b862b6"];
    //    [[UIApplication sharedApplication] openURL:linkURL];
        
        
        
   [[LISDKDeeplinkHelper sharedInstance] viewOtherProfile:self.linkedinId withState:self.linkedinId showGoToAppStoreDialog:YES success:nil error:nil];
    
        

        
        
        
        
        
        
    
        
    }else if (indexPath.row == 3){
        NSString *snap =  [[DataAccess singletonInstance] getSnapchat];

        NSURL *snapURL = [NSURL URLWithString:@"snapchat://?u=harryg_sf"];
        //    if ([[UIApplication sharedApplication] canOpenURL:instagramURL]) {
        NSLog(@"trying to open");
        [[UIApplication sharedApplication] openURL:snapURL];
        //   }
        
        //snapchat://?u=username
    }
    
    
}




- (void)addLine{
    
    self.Line = [[UIView alloc]init];
    
    self.Line.backgroundColor = [self lineColor];
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

- (void)addBottomLine{
    
    self.Line2 = [[UIView alloc]init];
    
    self.Line2.backgroundColor = [self lineColor];
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    self.Line2.translatesAutoresizingMaskIntoConstraints = NO;
    [self.Line2 invalidateIntrinsicContentSize];
    
    
    
    [self.tableBack addSubview:self.Line2];
    
    CGFloat pad = 0, height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 0;
        height = 1;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 0;
        height = 1;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 0;
        height = 1;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 0;
        height = 1;
    }
    
    
    
    NSDictionary *viewsDictionary = @{@"top":self.tableView, @"line": self.Line2};
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.tableBack attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.Line2 attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[line]-pad-|" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.tableBack addConstraint:constraint1];
    [self.tableBack addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.Line2 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.tableBack addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.Line2 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.tableBack addConstraint:constraint4];
    
}



- (void)addLabels{
    UIFont *font;
    self.fbLabel = [[UILabel alloc] init];
    self.fbLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    [self.fbLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.fbLabel invalidateIntrinsicContentSize];
    self.fbLabel.font = font;
    self.fbLabel.textColor = [UIColor blackColor];
    
    self.fbLabel.text = @"Facebook";
    
    [self.view addSubview:self.fbLabel];
    
    
    self.instaLabel = [[UILabel alloc] init];
    self.instaLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    [self.instaLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.instaLabel invalidateIntrinsicContentSize];
    self.instaLabel.font = font;
    self.instaLabel.textColor = [UIColor blackColor];
    
    self.instaLabel.text = @"Instagram";
    
    [self.view addSubview:self.instaLabel];
    
    
    self.linkedinLabel = [[UILabel alloc] init];
    self.linkedinLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    [self.linkedinLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.linkedinLabel invalidateIntrinsicContentSize];
    self.linkedinLabel.font = font;
    self.linkedinLabel.textColor = [UIColor blackColor];
    
    self.linkedinLabel.text = @"Linkedin";
    
    [self.view addSubview:self.linkedinLabel];
    
    
    self.snapchatLabel = [[UILabel alloc] init];
    self.snapchatLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    [self.snapchatLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.snapchatLabel invalidateIntrinsicContentSize];
    self.snapchatLabel.font = font;
    self.snapchatLabel.textColor = [UIColor blackColor];
    
    self.snapchatLabel.text = @"Snapchat";
    
    [self.view addSubview:self.snapchatLabel];
    
    
    
}

-(void)addLines{
    
    self.Line1 = [[UIView alloc]init];
    
    //   self.Line1.backgroundColor = [self lineColor];
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]) - 30;
    self.Line1.translatesAutoresizingMaskIntoConstraints = NO;
    [self.Line1 invalidateIntrinsicContentSize];
    
    
    
    [self.view addSubview:self.Line1];
    
    self.Line2 = [[UIView alloc]init];
    
    //    self.Line2.backgroundColor = [self lineColor];
    self.Line2.translatesAutoresizingMaskIntoConstraints = NO;
    [self.Line2 invalidateIntrinsicContentSize];
    
    
    
    [self.view addSubview:self.Line2];
    
    self.Line3 = [[UIView alloc]init];
    
    //  self.Line3.backgroundColor = [self lineColor];
    self.Line3.translatesAutoresizingMaskIntoConstraints = NO;
    [self.Line3 invalidateIntrinsicContentSize];
    
    
    
    [self.view addSubview:self.Line3];
    
    
    CGFloat pad = 0, height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 4;
        height = 1;
        width = 200;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 4;
        height = 1;
        width = 200;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 4;
        height = 1;
        width = 200;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 4;
        height = 1;
        width = 200;
        
    }
    
    
    
    
}

-(void)addConstraints{
    
    
    NSDictionary *viewsDictionary = @{@"top":self.Line, @"line1":self.Line1, @"line2":self.Line2, @"line3":self.Line3, @"fblabel" : self.fbLabel,  @"instalabel" : self.instaLabel,  @"linklabel" : self.linkedinLabel, @"snaplabel" : self.snapchatLabel, @"image": self.fb_logo};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[image]-20-[fblabel]" options:0 metrics:nil views:viewsDictionary];
    [self.view addConstraints:constraint1];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[image]-20-[instalabel]" options:0 metrics:nil views:viewsDictionary];
    [self.view addConstraints:constraint2];
    NSArray *constraint3 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[image]-20-[snaplabel]" options:0 metrics:nil views:viewsDictionary];
    [self.view addConstraints:constraint3];
    NSArray *constraint4 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[image]-20-[linklabel]" options:0 metrics:nil views:viewsDictionary];
    [self.view addConstraints:constraint4];
    NSArray *constraint5 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[image]-20-[line1]" options:0 metrics:nil views:viewsDictionary];
    [self.view addConstraints:constraint5];
    NSArray *constraint6 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[image]-20-[line2]" options:0 metrics:nil views:viewsDictionary];
    [self.view addConstraints:constraint6];
    NSArray *constraint7 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[image]-20-[line3]" options:0 metrics:nil views:viewsDictionary];
    [self.view addConstraints:constraint7];
    
    
    NSArray *constraint8 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[top]-13-[fblabel]-12-[line1]-11-[instalabel]-12-[line2]-11-[linklabel]-12-[line3]-12-[snaplabel]" options:0 metrics:nil views:viewsDictionary];
    [self.view addConstraints:constraint8];
    
    
    CGFloat pad = 0, height = 0, width = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 4;
        height = 1;
        width = 250;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 4;
        height = 1;
        width = 250;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 4;
        height = 1;
        width = 250;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 4;
        height = 1;
        width = 250;
        
    }
    
    
    NSLayoutConstraint *constraint9 = [NSLayoutConstraint constraintWithItem:self.Line1 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.view addConstraint:constraint9];
    
    NSLayoutConstraint *constraint10 = [NSLayoutConstraint constraintWithItem:self.Line1 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.view addConstraint:constraint10];
    
    NSLayoutConstraint *constraint11 = [NSLayoutConstraint constraintWithItem:self.Line2 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.view addConstraint:constraint11];
    
    NSLayoutConstraint *constraint12 = [NSLayoutConstraint constraintWithItem:self.Line2 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.view addConstraint:constraint12];
    
    NSLayoutConstraint *constraint13 = [NSLayoutConstraint constraintWithItem:self.Line3 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.view addConstraint:constraint13];
    
    NSLayoutConstraint *constraint14 = [NSLayoutConstraint constraintWithItem:self.Line3 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.view addConstraint:constraint14];
    
    
    
}






- (void)picturePressed:(id)sender {
    /*
     AlbumsTableViewController *albums = [[AlbumsTableViewController alloc] init];
     [self.navigationItem setHidesBackButton:YES];
     [self.navigationController setNavigationBarHidden:NO animated:NO];
     [self.navigationController pushViewController:albums animated:YES]; */
    
    ProfilePictureViewController *account = [[ProfilePictureViewController alloc] init];
    [self.navigationItem setHidesBackButton:NO];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.navigationController pushViewController:account animated:YES];
    
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

//[UIColor colorWithRed:0.00 green:0.00 blue:0.30 alpha:1.0];

-(UIColor*)headerColor{
    
    return [UIColor colorWithRed:0.00 green:0.00 blue:0.40 alpha:1.0];
    
    
}

@end
