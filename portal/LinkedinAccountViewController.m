//
//  LinkedinAccountViewController.m
//  portal
//
//  Created by Neil Ballard on 11/14/15.
//  Copyright © 2015 Neil_appworld. All rights reserved.
//

#import "LinkedinAccountViewController.h"
#import "DataAccess.h"
#import "HomeViewController.h"
#import "DeviceManager.h"
#import "LinkedinFieldViewController.h"
#import "AccountViewController.h"


@interface LinkedinAccountViewController ()

@property (nonatomic, retain) UIView * background;
@property (nonatomic, strong) IBOutlet UIButton *LinkedinButton;
@property (nonatomic,unsafe_unretained) CGRect mainScreenBounds;
@property (nonatomic, strong) NSMutableDictionary *viewsDictionary;

@property (nonatomic, retain) UINavigationBar * navBar;
@property (nonatomic, retain) UIView * firstLine;


@end

@implementation LinkedinAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGRect full = [[UIScreen mainScreen]bounds];
    
    
    self.background = [[UIView alloc] initWithFrame:full];
    self.background.hidden = NO;
    self.background.contentMode = UIViewContentModeScaleAspectFill;
    self.background.backgroundColor = [self grayColor];
    [self.view addSubview:self.background];

    [self styleNavBar];
    [self setupnetworkLabel];
    [self addFirstLine];
    [self setLinkedinLoginBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if ([[DataAccess singletonInstance] AddedLinkedin]){
        NSMutableArray *allViewControllers = [NSMutableArray arrayWithArray:[self.navigationController viewControllers]];
        for (UIViewController *aViewController in allViewControllers) {
            if ([aViewController isKindOfClass:[AccountViewController class]]) {
                [self.navigationController popToViewController:aViewController animated:NO];
            }
        }
    }
    
}

- (void)setupnetworkLabel {
    UIFont *font;
    
    CGFloat height = 0;
    
    self.networksLabel = [[UILabel alloc] init];
    
    self.networksLabel.font = [UIFont systemFontOfSize:5];
    height = 15;
    
    
    
    [self.networksLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.networksLabel invalidateIntrinsicContentSize];
    self.networksLabel.font = font;
    self.networksLabel.textColor = [UIColor lightGrayColor];
    
    self.networksLabel.text = @"Linkedin";
    
    [self.view addSubview:self.networksLabel];
    
    NSDictionary *viewsDictionary = @{@"top":self.navBar, @"label" : self.networksLabel};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-17-[label]" options:0 metrics:nil views:viewsDictionary];
    [self.view addConstraints:constraint1];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[top]-6-[label]" options:0 metrics:nil views:viewsDictionary];
    [self.view addConstraints:constraint2];
    
}


- (void)addFirstLine{
    
    self.firstLine = [[UIView alloc]init];
    
    self.firstLine.backgroundColor = [self lineColor];
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    self.firstLine.translatesAutoresizingMaskIntoConstraints = NO;
    [self.firstLine invalidateIntrinsicContentSize];
    
    
    
    [self.view addSubview:self.firstLine];
    
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
    
    
    
    NSDictionary *viewsDictionary = @{@"top":self.networksLabel, @"line": self.firstLine};
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.firstLine attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[top]-pad-[line]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraint:constraint1];
    [self.view addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.firstLine attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.view addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.firstLine attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.view addConstraint:constraint4];
    
}


-(void)LinkedinButtonClicked
{
    [LISDKSessionManager
     createSessionWithAuth:[NSArray arrayWithObjects:LISDK_BASIC_PROFILE_PERMISSION, nil]
     state:nil
     showGoToAppStoreDialog:YES
     successBlock:^(NSString *returnState) {
         NSLog(@"%s","success called!");
         LISDKSession *session = [[LISDKSessionManager sharedInstance] session];
         
         NSLog(@"linkedin signed in %@", session);
         [[DataAccess singletonInstance] setAddedLinkedin:YES];
         [[DataAccess singletonInstance] setUselinkedinOptionStatus:YES];
         [self.navigationController popViewControllerAnimated:YES];
         
       //  LinkedinFieldViewController *root = [[LinkedinFieldViewController alloc] init];
       //  [self.navigationItem setHidesBackButton:YES];
       //  [self.navigationController setNavigationBarHidden:NO animated:NO];
      //   [self.navigationController pushViewController:root animated:YES];
         
     }
     errorBlock:^(NSError *error) {
         NSLog(@"%s","error called!");
     }
     ];
    
    
}

-(void)setLinkedinLoginBtn{
    
    
    self.LinkedinButton = [[UIButton alloc] init];
    self.LinkedinButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.LinkedinButton.backgroundColor = [self linkedinBlue];
    [self.LinkedinButton setTitle: @"Connect Linkedin" forState: UIControlStateNormal];
    // Handle clicks on the button
    [self.LinkedinButton
     addTarget:self
     action:@selector(LinkedinButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.LinkedinButton.alpha = 1.0;
    self.LinkedinButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
    
     self.LinkedinButton.layer.cornerRadius = 3.0;
    
    self.LinkedinButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.LinkedinButton invalidateIntrinsicContentSize];
    
    CGFloat buttonWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]) - 30;
    
    [self.LinkedinButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.LinkedinButton.titleEdgeInsets = UIEdgeInsetsMake(15, 0, 15, 0);
    
    CGFloat pad = 0, height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 10;
        height = 50;
        self.LinkedinButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 10;
        height = ceilf(103/2);
        self.LinkedinButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:24];
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 10;
        height = ceilf(171/3);
        self.LinkedinButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:25];
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 10;
        height = 35;
        self.LinkedinButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15];
    }
    
    
    [self.view addSubview:self.LinkedinButton];
    
    NSDictionary *viewsDictionary = @{@"LinkButton" : self.LinkedinButton};
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.LinkedinButton attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[LinkButton]-pad-|" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraint:constraint1];
    [self.view addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.LinkedinButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.view addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.LinkedinButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:buttonWidth];
    [self.view addConstraint:constraint4];
    
    
    
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
    
    
  /*
    UIButton *titleView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [titleView setUserInteractionEnabled:NO];
    
    UIImage *connections_image = [[UIImage imageNamed:@"connections"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [titleView setBackgroundImage:connections_image forState:UIControlStateNormal];
    //    NSString *titleText = @"Name";
    //    [titleView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    //    [titleView setTitle:titleText forState:UIControlStateNormal];
    
    
    newItem.titleView = titleView; */
    
    
    
    
    
    // newItem.titleView = backView;
    // 4. add the nav bar to the main view
    [self.navBar setItems:@[newItem]];
    [self.view addSubview:self.navBar];
    
    
}


- (UIColor *) linkedinBlue
{
    return [UIColor colorWithRed:0.00 green:0.48 blue:0.71 alpha:1.0];
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

-(UIColor*)lineColor{
    
    return [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1.0];
    
    
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
