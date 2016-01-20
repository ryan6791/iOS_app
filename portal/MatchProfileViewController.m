//
//  MatchProfileViewController.m
//  pairedUP
//
//  Created by Neil Ballard on 1/17/16.
//  Copyright © 2016 Neil_appworld. All rights reserved.
//

#import "MatchProfileViewController.h"
#import "DeviceManager.h"
#import "DataAccess.h"
#import "MessagesViewController.h"
#import "UserAlbumsViewController.h"


@interface MatchProfileViewController ()

@end

@implementation MatchProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self styleNavBar];
    [self addProfileImage];
    [self setupNameLabel];
    [self setupInfoTextView];

    
    [self addDivideLine];
    [self setupDumpLabel];
    [self setupReportLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        height = 80;
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
    self.navBar.barTintColor = [UIColor whiteColor];//[UIColor blueColor];
    //  self.navBar.tintColor = [UIColor clearColor];
    self.navBar.translucent = NO;
    
    
    
    UIImage *chat_image = [[UIImage imageNamed:@"chat_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithImage:chat_image  style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonPressed:)];
    
    UIImage *image = [[UIImage imageNamed:@"logo"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(leftButtonPressed:)];
    
    
    newItem.rightBarButtonItem = rightBtn;
    newItem.leftBarButtonItem = leftBtn;
    
    
    UIButton *titleView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [titleView setUserInteractionEnabled:NO];
    
    NSString *titleText = [[DataAccess singletonInstance] getMatchName];
    [titleView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [titleView setTitle:titleText forState:UIControlStateNormal];
    
    titleView.titleLabel.font = [UIFont fontWithName:@"Superclarendon-Regular" size:21.0];
    
    titleView.layer.shadowRadius = 0.05;
    titleView.layer.shadowOpacity = 0.02;
    
    titleView.layer.masksToBounds = NO;
    
    //  titleView.layer.shouldRasterize = YES;
    
    
    newItem.titleView = titleView;
    
    
    
    // newItem.titleView = backView;
    // 4. add the nav bar to the main view
    [self.navBar setItems:@[newItem]];
    [self.view addSubview:self.navBar];
    

}


- (void)addProfileImage {
    
    self.pic = [[UIImageView alloc]init];
    
    self.pic.backgroundColor = [UIColor blueColor];
    self.pic.translatesAutoresizingMaskIntoConstraints = NO;
    [self.pic invalidateIntrinsicContentSize];
    
    NSData* imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"matchImage"];
    UIImage* image = [UIImage imageWithData:imageData];
    
    
    if (image != nil) {
        self.pic.image = image;
    }else{
        self.pic.image = [UIImage imageNamed:@"image_placeholder.png"];
    }
    
    self.pic.alpha = 2.0;
    
    self.pic.userInteractionEnabled = YES;
    UITapGestureRecognizer *pictureTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(goToPic:)];
    [self.pic addGestureRecognizer:pictureTap];
    
    [self.view addSubview:self.pic];
    
    CGFloat pad = 0, height = 0, widthOffset;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 40;
        height = 200;
        widthOffset = 100;
        self.pic.layer.cornerRadius = 105;
        self.pic.layer.masksToBounds = YES;
        self.pic.layer.shadowOffset = CGSizeMake(-.1, .2);
        self.pic.layer.shadowRadius = .5;
        self.pic.layer.shadowOpacity = 0.5;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 40;
        height = 250;
        widthOffset = 110;
        self.pic.layer.cornerRadius = 115;
        self.pic.layer.masksToBounds = YES;
        self.pic.layer.shadowOffset = CGSizeMake(-.1, .2);
        self.pic.layer.shadowRadius = .5;
        self.pic.layer.shadowOpacity = 0.5;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 50;
        height = 300;
        widthOffset = 120;
        self.pic.layer.cornerRadius = 105;
        self.pic.layer.masksToBounds = YES;
        self.pic.layer.shadowOffset = CGSizeMake(-.1, .2);
        self.pic.layer.shadowRadius = .5;
        self.pic.layer.shadowOpacity = 0.5;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 25;
        height = 200;
        widthOffset = 97;
        self.pic.layer.cornerRadius = 105;
        self.pic.layer.masksToBounds = YES;
        self.pic.layer.shadowOffset = CGSizeMake(-.1, .2);
        self.pic.layer.shadowRadius = .5;
        self.pic.layer.shadowOpacity = 0.5;
    }
    
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]) - widthOffset;
    
    
    
    NSDictionary *viewsDictionary = @{@"image":self.pic, @"nav": self.navBar};
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.pic attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[nav]-pad-[image]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraint:constraint1];
    [self.view addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.pic attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.view addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.pic attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.view addConstraint:constraint4];
    
    
}

- (void)setupNameLabel {
    
    
    self.nameLabel = [[UILabel alloc] init];
    [self.nameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.nameLabel invalidateIntrinsicContentSize];
    self.nameLabel.textColor = [UIColor blackColor];
    
    self.nameLabel.text = [[DataAccess singletonInstance] getMatchName];
    
    self.nameLabel.text = [self.nameLabel.text stringByAppendingString:@", 24"];
    
    
    self.nameLabel.layer.masksToBounds = NO;
    
    //   self.nameLabel.layer.shouldRasterize = YES;
    
    CGFloat pad = 0, pad2 = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        self.nameLabel.font = [UIFont systemFontOfSize:24];
        pad = 17;
        pad2 = 10;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        self.nameLabel.font = [UIFont systemFontOfSize:26];
        pad = 8;
        pad2 = 12;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 9;
        pad2 = 16;
        self.nameLabel.font = [UIFont systemFontOfSize:27];
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 6;
        pad2 = 8;
        self.nameLabel.font = [UIFont systemFontOfSize:19];
        
    }
    
    self.nameLabel.alpha = 100.0;
    
    [self.view addSubview:self.nameLabel];
    
    NSDictionary *viewsDictionary = @{@"pic":self.pic, @"label" : self.nameLabel};
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    [self.view addConstraint:constraint1];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[pic]-pad-[label]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    [self.view addConstraints:constraint2];
    
}

- (void)setupInfoTextView {
    
    
    self.infoText = [[UITextView alloc] init];
    [self.infoText setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.infoText invalidateIntrinsicContentSize];
    self.infoText.textColor = [UIColor lightGrayColor];
    
    
    self.infoText.text = @"Lover of long walks on the beach. Candlelit dinners under the stars. BE A GENTLEMAN. Not here for a one night stand. snapchat: @wineloverxx3";
    
    
    self.infoText.layer.masksToBounds = NO;
    
    //   self.nameLabel.layer.shouldRasterize = YES;
    
    CGFloat pad = 0, pad2 = 0, widthOffset = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        self.infoText.font = [UIFont systemFontOfSize:15];
        pad = 17;
        pad2 = 10;
        widthOffset = 70;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        self.infoText.font = [UIFont systemFontOfSize:19];
        pad = 8;
        pad2 = 16;
        widthOffset = 60;

    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 9;
        pad2 = 16;
        self.infoText.font = [UIFont systemFontOfSize:21];
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 6;
        pad2 = 8;
        self.infoText.font = [UIFont systemFontOfSize:17];
        
    }
    
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]) - widthOffset;
    
    self.infoText.alpha = 100.0;
    
    [self.view addSubview:self.infoText];
    
    NSDictionary *viewsDictionary = @{@"text":self.infoText, @"label" : self.nameLabel};
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.infoText attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    [self.view addConstraint:constraint1];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[label]-pad-[text]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    [self.view addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.infoText attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:100];
    [self.view addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.infoText attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.view addConstraint:constraint4];
    
}


- (void)addDivideLine {
    
    self.divideLine = [[UIView alloc]init];
    
    self.divideLine.backgroundColor = [UIColor lightTextColor];
    self.divideLine.translatesAutoresizingMaskIntoConstraints = NO;
    [self.divideLine invalidateIntrinsicContentSize];
    
    
    self.divideLine.alpha = 2.0;
    
    self.divideLine.layer.masksToBounds = YES;
    self.divideLine.layer.shadowOffset = CGSizeMake(-.1, .2);
    self.divideLine.layer.shadowRadius = .5;
    self.divideLine.layer.shadowOpacity = 0.5;
    
    [self.view addSubview:self.divideLine];
    
    CGFloat pad = 0, height = 0, width = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 10;
        height = 50;
        width = 1;

    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 5;
        height = 15;
        width = 1;

    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 5;
        height = 15;
        width = 1;

        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 5;
        height = 15;
        width = 1;

    }
    
    
    
    
    NSDictionary *viewsDictionary = @{@"line": self.divideLine};
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.divideLine attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[line]-pad-|" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraint:constraint1];
    [self.view addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.divideLine attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.view addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.divideLine attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.view addConstraint:constraint4];
    
    
}


- (void)setupDumpLabel {
    
    
    self.dumpLabel = [[UILabel alloc] init];
    [self.dumpLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.dumpLabel invalidateIntrinsicContentSize];
    self.dumpLabel.textColor = [UIColor lightGrayColor];
    
    self.dumpLabel.text = @"DROP";
    
    
    self.dumpLabel.layer.masksToBounds = NO;
    
    //   self.nameLabel.layer.shouldRasterize = YES;
    
    CGFloat pad = 0, pad2 = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        self.dumpLabel.font = [UIFont systemFontOfSize:24];
        pad = 17;
        pad2 = 20;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        self.dumpLabel.font = [UIFont systemFontOfSize:26];
        pad = 8;
        pad2 = 16;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 9;
        pad2 = 16;
        self.dumpLabel.font = [UIFont systemFontOfSize:27];
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 6;
        pad2 = 8;
        self.dumpLabel.font = [UIFont systemFontOfSize:19];
        
    }
    
    self.dumpLabel.alpha = 100.0;
    
    [self.view addSubview:self.dumpLabel];
    
    NSDictionary *viewsDictionary = @{@"line":self.divideLine, @"label" : self.dumpLabel};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[label]-pad-[line]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    [self.view addConstraints:constraint1];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[label]-pad-|" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraints:constraint2];
    
}

- (void)setupReportLabel {
    
    
    self.reportLabel = [[UILabel alloc] init];
    [self.reportLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.reportLabel invalidateIntrinsicContentSize];
    self.reportLabel.textColor = [UIColor lightGrayColor];
    
    self.reportLabel.text = @"FLAG";
    
    
    self.reportLabel.layer.masksToBounds = NO;
    
    //   self.nameLabel.layer.shouldRasterize = YES;
    
    CGFloat pad = 0, pad2 = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        self.reportLabel.font = [UIFont systemFontOfSize:24];
        pad = 17;
        pad2 = 20;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        self.reportLabel.font = [UIFont systemFontOfSize:26];
        pad = 8;
        pad2 = 16;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 9;
        pad2 = 16;
        self.reportLabel.font = [UIFont systemFontOfSize:27];
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 6;
        pad2 = 8;
        self.reportLabel.font = [UIFont systemFontOfSize:19];
        
    }
    
    self.reportLabel.alpha = 100.0;
    
    [self.view addSubview:self.reportLabel];
    
    NSDictionary *viewsDictionary = @{@"line":self.divideLine, @"label" : self.reportLabel};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[line]-pad-[label]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    [self.view addConstraints:constraint1];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[label]-pad-|" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraints:constraint2];
    
}


- (void)rightButtonPressed:(id)sender {
    
    
    
    MessagesViewController *vc = [MessagesViewController messagesViewController];
    [self.navigationItem setHidesBackButton:YES];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (void)leftButtonPressed:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)goToPic:(id)sender{
    
    
    UserAlbumsViewController *account = [[UserAlbumsViewController alloc] init];
    [self.navigationItem setHidesBackButton:YES];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self.navigationController pushViewController:account animated:NO];
    
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
