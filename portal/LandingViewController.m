//
//  LandingViewController.m
//  pairedUP
//
//  Created by Neil Ballard on 1/31/16.
//  Copyright © 2016 Neil_appworld. All rights reserved.
//

#import "LandingViewController.h"
#import "DeviceManager.h"
#import "DataAccess.h"
#import "UserMenuViewController.h"
#import "MatchTabBarController.h"

@interface LandingViewController ()

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *tempView;
@property (nonatomic, assign) CGPoint offset;
@property (nonatomic, retain) UIView * background;
@property (strong, nonatomic) IBOutlet UIImageView *slide1;
@property (strong, nonatomic) IBOutlet UIImageView *slide2;
@property (strong, nonatomic) IBOutlet UIImageView *slide3;
@property (nonatomic, retain) UIView * overlay;
@property (nonatomic, retain) UIImageView * logo;
@property (nonatomic, strong) IBOutlet UIButton *LoginButton;

@end

@implementation LandingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden = YES;
    [self.navigationItem setHidesBackButton:YES];
    CGRect fullScreenRect=[[UIScreen mainScreen] bounds];
    
    
    
    self.tempView = [[UIView alloc] init];
    [self.tempView setFrame:fullScreenRect];
    self.tempView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.tempView removeFromSuperview];
    
    
    self.tempView.backgroundColor = [UIColor whiteColor];
    
    self.scrollView.delegate = self;
    
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    self.scrollView.backgroundColor = [UIColor whiteColor];
    
    
    UIView *tempView = self.tempView;
    UIScrollView *scrollView = self.scrollView;
    
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(scrollView, tempView);
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.tempView];
    
    self.scrollView.pagingEnabled = YES;
    
    [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tempView]|" options:0 metrics: 0 views:viewsDictionary]];
    [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tempView]|" options:0 metrics: 0 views:viewsDictionary]];
    [self.tempView addConstraint:[NSLayoutConstraint constraintWithItem:self.tempView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:fullScreenRect.size.width * 4]];
    
    NSArray *scrollConstraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[scrollView]|" options:0 metrics:0 views:viewsDictionary];
    [self.view addConstraints:scrollConstraint1];
    NSArray *scrollConstraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[scrollView]|" options:0 metrics: 0 views:viewsDictionary];
    [self.view addConstraints:scrollConstraint2];
    
    [self.scrollView setExclusiveTouch:NO];
    
    //   CGFloat contentHeightModifier = 0.0;
    CGFloat scroll_height = CGRectGetHeight([[UIScreen mainScreen] bounds]);
    CGFloat scroll_width = CGRectGetWidth([[UIScreen mainScreen] bounds]) * 4;
    
    
    
    [self.tempView addConstraint:[NSLayoutConstraint constraintWithItem:self.tempView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:scroll_height]];
    
    [self.tempView addConstraint:[NSLayoutConstraint constraintWithItem:self.tempView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:scroll_width]];
    
    self.scrollView.contentInset = UIEdgeInsetsMake(0.0,0.0,0.0,0.0);
    CGRect cRect = scrollView.bounds;
    self.scrollView.contentSize = CGSizeMake(cRect.origin.x, self.scrollView.bounds.size.height);
    self.scrollView.contentOffset = CGPointMake(self.scrollView.bounds.size.width, 0);
    
    
    [self addLoginScreen];
    [self setupExplainLabel];
    [self addSlide1];
    [self setupExplainLabel2];
    [self addSlide2];
    [self setupExplainLabel3];
    [self addSlide3];
    [self setupExplainLabel4];
    [self setLoginBtn];


    [self addSplash];
    [self addSplashLogo];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addLoginScreen{
    
    self.background = [[UIView alloc] init];
    self.background.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.background];
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    self.background.translatesAutoresizingMaskIntoConstraints = NO;
    [self.background invalidateIntrinsicContentSize];
    
    
    
    [self.tempView addSubview:self.background];
    
    CGFloat pad = 0, pad2 = 0;
    CGFloat height = CGRectGetHeight([[UIScreen mainScreen] bounds]) - 100;

    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 0;
        pad2 = 0;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 70;
        pad2 = 0;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 76;
        pad2 = 0;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 50;
        pad2 = 0;
        
    }
    
    
    
    NSDictionary *viewsDictionary = @{@"image":self.background};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-pad-[image]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-pad-[image]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.tempView addConstraints:constraint1];
    [self.tempView addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.background attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.tempView addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.background attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.tempView addConstraint:constraint4];
    
}


-(void)addSlide1{
    
    self.slide1 = [[UIImageView alloc] init];
    self.slide1.backgroundColor = [UIColor whiteColor];
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    self.slide1.translatesAutoresizingMaskIntoConstraints = NO;
    [self.slide1 invalidateIntrinsicContentSize];
    
    
    
    [self.tempView addSubview:self.slide1];
    
    CGFloat pad = 0, pad2 = 0;
    CGFloat height = CGRectGetHeight([[UIScreen mainScreen] bounds]) - 100;
    
    
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 0;
        pad2 = 0;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 70;
        pad2 = 0;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 76;
        pad2 = 0;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 50;
        pad2 = 0;
        
    }
    
    
    NSDictionary *viewsDictionary = @{@"slide1":self.slide1, @"login":self.background};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[login]-pad-[slide1]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-pad-[slide1]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.tempView addConstraints:constraint1];
    [self.tempView addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.slide1 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.tempView addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.slide1 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.tempView addConstraint:constraint4];
    
}

-(void)addSlide2{
    
    self.slide2 = [[UIImageView alloc] init];
    self.slide2.contentMode = UIViewContentModeScaleAspectFill;
    self.slide2.backgroundColor = [UIColor whiteColor];
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    self.slide2.translatesAutoresizingMaskIntoConstraints = NO;
    [self.slide2 invalidateIntrinsicContentSize];
    
    
    
    [self.tempView addSubview:self.slide2];
    
    CGFloat pad = 0, pad2 = 0;
    CGFloat height = CGRectGetHeight([[UIScreen mainScreen] bounds]) - 100;
    
    
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 0;
        pad2 = 0;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 70;
        pad2 = 0;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 76;
        pad2 = 0;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 50;
        pad2 = 0;
        
    }
    
    
    NSDictionary *viewsDictionary = @{@"slide2":self.slide2, @"slide1":self.slide1};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[slide1]-pad-[slide2]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-pad-[slide2]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.tempView addConstraints:constraint1];
    [self.tempView addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.slide2 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.tempView addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.slide2 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.tempView addConstraint:constraint4];
    
}

-(void)addSlide3{
    
    self.slide3 = [[UIImageView alloc]init];
    
    self.slide3.backgroundColor = [UIColor whiteColor];
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    self.slide3.translatesAutoresizingMaskIntoConstraints = NO;
    [self.slide3 invalidateIntrinsicContentSize];
    
    
    
    
    [self.tempView addSubview:self.slide3];
    
    CGFloat pad = 0, pad2 = 0;
    CGFloat height = CGRectGetHeight([[UIScreen mainScreen] bounds]) - 100;
    
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 0;
        pad2 = 0;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 70;
        pad2 = 0;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 76;
        pad2 = 0;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 50;
        pad2 = 0;
    }
    
    NSDictionary *viewsDictionary = @{@"slide3":self.slide3, @"slide2":self.slide2};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[slide2]-pad-[slide3]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-pad-[slide3]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.tempView addConstraints:constraint1];
    [self.tempView addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.slide3 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.tempView addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.slide3 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.tempView addConstraint:constraint4];
    
}


-(void)LoginButtonClicked
{
    
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    login.loginBehavior = FBSDKLoginBehaviorNative;
    [login
     logInWithReadPermissions: @[@"email", @"public_profile",  @"user_photos", @"user_birthday"]
     fromViewController:self
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error) {
             NSLog(@"Process error %@", error);
         } else if (result.isCancelled) {
             NSLog(@"Cancelled");
         } else {
             if ([result.grantedPermissions containsObject:@"email"] && [result.grantedPermissions containsObject:@"user_photos"]) {
                 self.scrollView.pagingEnabled = NO;
                 self.overlay.hidden = NO;
                 self.logo.hidden = NO;
                 
                 if ([FBSDKAccessToken currentAccessToken]) {
                     NSString *userid = [FBSDKAccessToken currentAccessToken].userID;
                     [self fetchUserInfo:[[FBSDKAccessToken currentAccessToken] tokenString] completion:^{
                         
                         [self fetchUserPhoto:[[FBSDKAccessToken currentAccessToken] tokenString] completion:^{
                             [[DataAccess singletonInstance] setFacebook:userid];
                             [[DataAccess singletonInstance] setUserLoginStatus:YES];
                             [[DataAccess singletonInstance] setisLoggedInWithFB:YES];
                             [[DataAccess singletonInstance] setInitialUserStatus:YES];
                             [self start];
                             
                         }];
                         
                     }];
                     
                 }else{
                     [self viewDidLoad];
                 }
             }
         }
         
     }];
}

-(void)addSplash{
    
    self.overlay = [[UIView alloc]init];
    
    self.overlay.hidden = YES;
    
    
    self.overlay.backgroundColor = [UIColor whiteColor];
    self.overlay.translatesAutoresizingMaskIntoConstraints = NO;
    [self.overlay invalidateIntrinsicContentSize];
    
    
    
    
    
    
    [self.view addSubview:self.overlay];
    
    
    CGFloat pad = 0, Offset = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 1.5f;
        Offset = 3;
        //   self.background.layer.cornerRadius = 40;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 2;
        Offset = 4;
        //    self.background.layer.cornerRadius = 105;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 2.5f;
        Offset = 5;
        //    self.background.layer.cornerRadius = 105;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 1;
        Offset = 2;
        //    self.background.layer.cornerRadius = 105;
    }
    
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    CGFloat height = CGRectGetHeight([[UIScreen mainScreen] bounds]);
    
    
    
    
    NSDictionary *viewsDictionary = @{@"back":self.overlay};
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.overlay attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[back]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraint:constraint1];
    [self.view addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.overlay attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.view addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.overlay attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.view addConstraint:constraint4];
    
}

- (void)addSplashLogo {
    
    self.logo = [[UIImageView alloc]init];
    self.logo.hidden = YES;
    //  self.logo.backgroundColor = [UIColor blueColor];
    self.logo.translatesAutoresizingMaskIntoConstraints = NO;
    [self.logo invalidateIntrinsicContentSize];
    
    
    self.logo.image = [UIImage imageNamed:@"logo"];
    
    
    self.logo.alpha = 2.0;
    
    
    
    
    [self.overlay addSubview:self.logo];
    
    self.logo.layer.masksToBounds = YES;
    self.logo.layer.shadowOffset = CGSizeMake(-.1, .2);
    self.logo.layer.shadowRadius = .5;
    self.logo.layer.shadowOpacity = 0.5;
    
    CGFloat pad = 0, height = 0, widthOffset;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 110;
        height = 200;
        widthOffset = 100;
        self.logo.layer.masksToBounds = YES;
        self.logo.layer.shadowOffset = CGSizeMake(-.1, .2);
        self.logo.layer.shadowRadius = .5;
        self.logo.layer.shadowOpacity = 0.5;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 40;
        height = 250;
        widthOffset = 110;
        
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 50;
        height = 300;
        widthOffset = 120;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 25;
        height = 200;
        widthOffset = 97;
        
    }
    
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]) - widthOffset;
    
    
    
    NSDictionary *viewsDictionary = @{@"image":self.logo};
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.logo attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.overlay attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-pad-[image]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.overlay addConstraint:constraint1];
    [self.overlay addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.logo attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.overlay addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.logo attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.overlay addConstraint:constraint4];
    
    
}





-(void)fetchUserInfo:(NSString*)access_token completion:(void (^)(void))completionBlock{
    
    self.info_success = NO;
    
    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"first_name, birthday, gender"}]
     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
         if (!error)
         {
             NSString *name = [result objectForKey:@"first_name"];
             [[DataAccess singletonInstance] setName:name];
             NSLog(@"%@", [[DataAccess singletonInstance] getName]);
             NSString *birthday = [result objectForKey:@"birthday"];
             [[DataAccess singletonInstance] setBirthday:birthday];
             
             NSDate* today = [NSDate date];
             NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
             [dateFormatter setDateFormat:@"MM/dd/yyyy"];
             NSDate* birthDate = [dateFormatter dateFromString:birthday];
             NSDateComponents* ageComponents = [[NSCalendar currentCalendar]
                                                components:NSCalendarUnitYear
                                                fromDate:birthDate
                                                toDate:today
                                                options:0];
             NSInteger numAge = [ageComponents year];
             NSString *age = [NSString stringWithFormat:@"%d", numAge];
             [[DataAccess singletonInstance] setAge:age];
            
             NSString *gender = [result objectForKey:@"gender"];
             [[DataAccess singletonInstance] setGender:gender];
             
             
             NSLog(@"the gender is %@", [[DataAccess singletonInstance] getGender]);
             NSLog(@"The birthday is: %@", birthday);
             NSLog(@"The age is: %@", age);
             self.info_success = YES;
             
             
         }
         else
         {
             NSLog(@"Error %@",error);
         }
         
         if(self.info_success){
             completionBlock();
         }
     }];
    
}

-(void)fetchUserPhoto:(NSString*)access_token completion:(void (^)(void))completionBlock{
    
    self.photo_success = NO;
    
    
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                  initWithGraphPath:[NSString stringWithFormat:@"me/picture?type=large&redirect=false"]
                                  parameters:nil
                                  HTTPMethod:@"GET"];
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                          id result,
                                          NSError *error) {
        if (!error){
            
            NSDictionary *res = [result objectForKey:@"data"];
            
            
            NSDictionary *imageUrl = [res objectForKey:@"url"];
            
            
            
            UIImage *proImage =  [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]]];
            
            [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(proImage) forKey:@"ProfileImage"];
            
            NSLog(@"The image be : %@", proImage);
            
            self.photo_success = YES;
            
        }
        else {
            NSLog(@"result: %@",[error description]);
        }
        
        if(self.photo_success){
            completionBlock();
        }
        
    }];
    
}

- (UIColor *) facebookBlue
{
    return [UIColor colorWithRed:0.23 green:0.35 blue:0.60 alpha:1.0];
}



- (UIColor *) linkedinBlue
{
    return [UIColor colorWithRed:0.00 green:0.48 blue:0.71 alpha:1.0];
}

-(void)setLoginBtn{
    
    
    self.LoginButton = [[UIButton alloc] init];
    self.LoginButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.LoginButton.backgroundColor = [self facebookBlue];
    [self.LoginButton setTitle: @"Login With Facebook" forState: UIControlStateNormal];
    // Handle clicks on the button
    [self.LoginButton
     addTarget:self
     action:@selector(LoginButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.LoginButton.alpha = 1.0;
    self.LoginButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
    
    self.LoginButton.layer.cornerRadius = 3.0;
    
    self.LoginButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.LoginButton invalidateIntrinsicContentSize];
    
    CGFloat buttonWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]) - 30;
    
    [self.LoginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.LoginButton.titleEdgeInsets = UIEdgeInsetsMake(15, 0, 15, 0);
    
    CGFloat pad = 0, height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 10;
        height = 50;
        self.LoginButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 10;
        height = ceilf(103/2);
        self.LoginButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:24];
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 10;
        height = ceilf(171/3);
        self.LoginButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:25];
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 10;
        height = 35;
        self.LoginButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15];
    }
    
    
    [self.view addSubview:self.LoginButton];
    
    NSDictionary *viewsDictionary = @{@"fbButton" : self.LoginButton};
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.LoginButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[fbButton]-pad-|" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraint:constraint1];
    [self.view addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.LoginButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.view addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.LoginButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:buttonWidth];
    [self.view addConstraint:constraint4];
    
    
    
}


-(void)start{
    
    [[DataAccess singletonInstance] setMatchName:@"Jess"];
    UIImage *matchImage = [UIImage imageNamed:@"_avatar_cook"];
    [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(matchImage) forKey:@"matchImage"];
    [[DataAccess singletonInstance] saveIncomingAvatarSetting:YES];
    [[DataAccess singletonInstance] saveOutgoingAvatarSetting:YES];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    NSDictionary *textAttributes = @{ NSFontAttributeName : [UIFont fontWithName:@"Superclarendon-Regular" size:21.0],
                                      NSForegroundColorAttributeName : [self navColor]};
    
    UIColor *bkVC1 = [UIColor colorWithRed:0.000 green:0.475 blue:0.647 alpha:1.000];
    UIColor *bkVC2 = [UIColor colorWithRed:0.000 green:0.729 blue:0.984 alpha:1.000];
    UIColor *bkVC3 = [UIColor colorWithRed:0.753 green:0.929 blue:0.996 alpha:1.000];
    
    
    UserMenuViewController *vc1 = [[UserMenuViewController alloc] initWithText:@"Page #1" backgroundColor:bkVC1];
    vc1.pagerObj = [DMPagerNavigationBarItem newItemWithText: [[NSAttributedString alloc] initWithString:@"Settings" attributes:textAttributes]
                                                     andIcon: [UIImage imageNamed:@"settings"]];
    //   vc1.pagerObj.renderingMode = DMPagerNavigationBarItemModeOnlyText;
    
    
    SwipeViewController *vc2 = [[SwipeViewController alloc] initWithText:@"Page #2" backgroundColor:bkVC2];
    vc2.pagerObj = [DMPagerNavigationBarItem newItemWithText: [[NSAttributedString alloc] initWithString:@"POD" attributes:textAttributes]
                                                     andIcon: [UIImage imageNamed:@"logo"]];
    //    vc2.pagerItem.renderingMode = DMPagerNavigationBarItemModeOnlyImage;
    
    MatchTabBarController *vc3 = [[MatchTabBarController alloc] initWithText:@"Page #3" backgroundColor:bkVC3];
    vc3.pagerObj = [DMPagerNavigationBarItem newItemWithText: [[NSAttributedString alloc] initWithString:@"CHAT" attributes:textAttributes]
                                                     andIcon: [UIImage imageNamed:@"chat_icon"]];
    //  vc3.pagerObj.renderingMode = DMPagerNavigationBarItemModeOnlyText;
    
    
    // Create pager with items
    self.pagerController = [[DMPagerViewController alloc] initWithViewControllers: @[vc1,vc2,vc3]];
    self.pagerController.useNavigationBar = YES;
    self.pagerController.navigationBar.style = DMPagerNavigationBarStyleClose;
    
    
    // Setup pager's navigation bar colors
    UIColor *activeColor = [self navColor];
    //[UIColor colorWithRed:0.000 green:0.235 blue:0.322 alpha:1.000];
    UIColor *inactiveColor = [UIColor colorWithRed:.84 green:.84 blue:.84 alpha:1.0];
    self.pagerController.navigationBar.inactiveItemColor = inactiveColor;
    self.pagerController.navigationBar.activeItemColor = activeColor;
    
    
    NSMutableArray *viewControllers = [NSMutableArray arrayWithArray:[self.navigationController viewControllers]];
    [viewControllers replaceObjectAtIndex:0 withObject:self.pagerController];
    [self.navigationController setViewControllers:viewControllers];
    
    
}


- (void)setupExplainLabel {
    
    
    self.explainLabel = [[UILabel alloc] init];
    [self.explainLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.explainLabel invalidateIntrinsicContentSize];
    self.explainLabel.textColor = [UIColor blackColor];
    
    self.explainLabel.text = @"This is an introduction. Swipe to view next slide(s)";
    
    
    self.explainLabel.layer.masksToBounds = NO;
    
    //   self.explainLabel.layer.shouldRasterize = YES;
    
    CGFloat pad = 0, pad2 = 0;
    self.explainLabel.font = [UIFont systemFontOfSize:11];
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 17;
        pad2 = 10;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 8;
        pad2 = 16;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 9;
        pad2 = 16;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 6;
        pad2 = 8;
        
    }
    
    self.explainLabel.alpha = 100.0;
    
    [self.background addSubview:self.explainLabel];
    
    NSDictionary *viewsDictionary = @{@"label" : self.explainLabel};
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.explainLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.background attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    [self.background addConstraint:constraint1];
    NSLayoutConstraint *constraint2 = [NSLayoutConstraint constraintWithItem:self.explainLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.background attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    [self.background addConstraint:constraint2];
    
    
}

- (void)setupExplainLabel2 {
    
    
    self.explainLabel2 = [[UILabel alloc] init];
    [self.explainLabel2 setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.explainLabel2 invalidateIntrinsicContentSize];
    self.explainLabel2.textColor = [UIColor blackColor];
    
    self.explainLabel2.text = @"This is an introduction. Swipe to view next slide(s)";
    
    
    self.explainLabel2.layer.masksToBounds = NO;
    
    //   self.explainLabel2.layer.shouldRasterize = YES;
    
    CGFloat pad = 0, pad2 = 0;
    self.explainLabel2.font = [UIFont systemFontOfSize:11];
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 17;
        pad2 = 10;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 8;
        pad2 = 16;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 9;
        pad2 = 16;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 6;
        pad2 = 8;
        
    }
    
    self.explainLabel2.alpha = 100.0;
    
    [self.slide1 addSubview:self.explainLabel2];
    
    NSDictionary *viewsDictionary = @{@"label" : self.explainLabel2};
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.explainLabel2 attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.slide1 attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    [self.slide1 addConstraint:constraint1];
    NSLayoutConstraint *constraint2 = [NSLayoutConstraint constraintWithItem:self.explainLabel2 attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.slide1 attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    [self.slide1 addConstraint:constraint2];
    
}


- (void)setupExplainLabel3 {
    
    
    self.explainLabel3 = [[UILabel alloc] init];
    [self.explainLabel3 setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.explainLabel3 invalidateIntrinsicContentSize];
    self.explainLabel3.textColor = [UIColor blackColor];
    
    self.explainLabel3.text = @"This is an introduction. Swipe to view next slide(s)";
    
    
    self.explainLabel3.layer.masksToBounds = NO;
    
    //   self.explainLabel3.layer.shouldRasterize = YES;
    
    CGFloat pad = 0, pad2 = 0;
    self.explainLabel3.font = [UIFont systemFontOfSize:11];
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 17;
        pad2 = 10;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 8;
        pad2 = 16;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 9;
        pad2 = 16;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 6;
        pad2 = 8;
        
    }
    
    self.explainLabel3.alpha = 100.0;
    
    [self.slide2 addSubview:self.explainLabel3];
    
    NSDictionary *viewsDictionary = @{@"label" : self.explainLabel3};
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.explainLabel3 attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.slide2 attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    [self.slide2 addConstraint:constraint1];
    NSLayoutConstraint *constraint2 = [NSLayoutConstraint constraintWithItem:self.explainLabel3 attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.slide2 attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    [self.slide2 addConstraint:constraint2];
    
}

- (void)setupExplainLabel4 {
    
    
    self.explainLabel4 = [[UILabel alloc] init];
    [self.explainLabel4 setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.explainLabel4 invalidateIntrinsicContentSize];
    self.explainLabel4.textColor = [UIColor blackColor];
    
    self.explainLabel4.text = @"This is an introduction. Swipe to view next slide(s)";
    
    
    self.explainLabel4.layer.masksToBounds = NO;
    
    //   self.explainLabel3.layer.shouldRasterize = YES;
    
    CGFloat pad = 0, pad2 = 0;
    self.explainLabel4.font = [UIFont systemFontOfSize:11];
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 17;
        pad2 = 10;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 8;
        pad2 = 16;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 9;
        pad2 = 16;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 6;
        pad2 = 8;
        
    }
    
    self.explainLabel4.alpha = 100.0;
    
    [self.slide3 addSubview:self.explainLabel4];
    
    NSDictionary *viewsDictionary = @{@"label" : self.explainLabel4};
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.explainLabel4 attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.slide3 attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    [self.slide3 addConstraint:constraint1];
    NSLayoutConstraint *constraint2 = [NSLayoutConstraint constraintWithItem:self.explainLabel4 attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.slide3 attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    [self.slide3 addConstraint:constraint2];
    
}



-(UIColor*)navColor{
    
    return [UIColor colorWithRed:0.0 green:172.0f/255.0f blue:237.0f/255.0f alpha:1.0];
}


@end
