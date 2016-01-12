//
//  WebViewController.m
//  portal
//
//  Created by Neil Ballard on 1/10/16.
//  Copyright © 2016 Neil_appworld. All rights reserved.
//

#import "WebViewController.h"
#import "DeviceManager.h"
#import "DataAccess.h"

@interface WebViewController ()

@property (nonatomic, retain) UINavigationBar * navBar;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self styleNavBar];
    [self setupWebView];
    [self openWebView];
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
    self.navBar.backgroundColor = [UIColor whiteColor];
    self.navBar.barTintColor = [UIColor whiteColor];
    
    
    
    UIImage *image = [[UIImage imageNamed:@"noButton"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(goback)];
    
    
    newItem.rightBarButtonItem = rightBtn;
    
    
    
    
    
    // newItem.titleView = backView;
    // 4. add the nav bar to the main view
    [self.navBar setItems:@[newItem]];
    [self.view addSubview:self.navBar];
    
    
}



-(void)goback{
    
    [self.navigationController popViewControllerAnimated:NO];
    
}

-(void)setupWebView{
    


    
    self.webview = [[UIWebView alloc]init];
    

    
    self.webview.backgroundColor = [UIColor grayColor];
    self.webview.translatesAutoresizingMaskIntoConstraints = NO;
    [self.webview invalidateIntrinsicContentSize];
    
    //  self.pickbackground.alpha = 2.0;
    
    
    self.webview.layer.masksToBounds = NO;
    self.webview.layer.shadowOffset = CGSizeMake(-.1, .2);
    self.webview.layer.shadowRadius = .5;
    self.webview.layer.shadowOpacity = 0.5;
    
    self.webview.userInteractionEnabled = YES;
    
    
    [self.view addSubview:self.webview];
    
    CGFloat heightOffset = 0, height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        heightOffset = 64;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        heightOffset = 70;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        heightOffset = 80;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        heightOffset = 55;
    }
    
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    height = CGRectGetHeight([[UIScreen mainScreen] bounds]) - heightOffset;
    

    
    
    
    NSDictionary *viewsDictionary = @{@"back":self.webview, @"top": self.navBar};
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.webview attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-pad-[back]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:heightOffset]} views:viewsDictionary];
    [self.view addConstraint:constraint1];
    [self.view addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.webview attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.view addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.webview attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.view addConstraint:constraint4];
    
    
}

-(void)openWebView{
    
    
  //  NSString  *instaURLStr = @"https://www.instagram.com/_ryanpowers_/";
 //   NSString *fbURL = [[DataAccess singletonInstance ] getFacebookLink];
    NSString *fbURL = [[DataAccess singletonInstance ] getLinkedinLink];
    NSLog(@"linkedinURL url == = --- %@", fbURL);
    NSURL *url = [NSURL URLWithString:fbURL];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.webview loadRequest:urlRequest];
    
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
