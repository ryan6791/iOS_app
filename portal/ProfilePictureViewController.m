//
//  ProfilePictureViewController.m
//  portal
//
//  Created by Neil Ballard on 11/13/15.
//  Copyright © 2015 Neil_appworld. All rights reserved.
//
#import "DeviceManager.h"
#import "AccountViewController.h"
#import "DataAccess.h"
#import "ProfilePictureViewController.h"

@interface ProfilePictureViewController ()

@property (nonatomic, strong) UIImageView *photoView;

@end

@implementation ProfilePictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = NO;
    [self setupTitleViewWithTitleText];
    [self addProfileImage];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style: UIBarButtonItemStylePlain target:self action:@selector(Back)];
    self.navigationItem.leftBarButtonItem = backButton;
    
    
}



- (IBAction)Back
{
    [self.navigationController popViewControllerAnimated:YES];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addProfileImage {
    
    self.photoView = [[UIImageView alloc]init];
    
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    CGFloat height = CGRectGetHeight([[UIScreen mainScreen] bounds]);
    
    self.photoView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.photoView invalidateIntrinsicContentSize];
    
    [self.view addSubview:self.photoView];
    
    CGFloat pad = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
    }
    
    self.photoView.image = [[DataAccess singletonInstance] getProfileImage];
    
    
    
    NSDictionary *viewsDictionary = @{@"image":self.photoView};
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.photoView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:1];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-pad-[image]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraint:constraint1];
    [self.view addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.photoView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.view addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.photoView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.view addConstraint:constraint4];
    
}





- (void)setupTitleViewWithTitleText {
    UIButton *titleView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [titleView setUserInteractionEnabled:NO];
    
    [titleView setImage:[UIImage imageNamed:@"logo"] forState:UIControlStateNormal];
    
    self.navigationItem.titleView = titleView;
}

@end
