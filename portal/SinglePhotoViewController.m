//
//  SinglePhotoViewController.m
//  portal
//
//  Created by Neil Ballard on 10/17/15.
//  Copyright © 2015 Neil_appworld. All rights reserved.
//

#import "SinglePhotoViewController.h"
#import "DeviceManager.h"
#import "AccountViewController.h"
#import "DataAccess.h"
#import "PhotoManager.h"

@interface SinglePhotoViewController ()

@property (nonatomic, strong) UIImageView *photoView;
@property (strong, nonatomic) IBOutlet UIView *headerView;

@end

@implementation SinglePhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    self.navigationController.navigationBarHidden = YES;
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = NO;
    [self addHeaderView];
    [self addProfileImage];
    [self setOkBtn];
    [self setCancelBtn];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;

}


-(void)addHeaderView{
    
    self.headerView = [[UIImageView alloc]init];
    
    self.headerView.backgroundColor = [UIColor blackColor];
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    self.headerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.headerView invalidateIntrinsicContentSize];
    
    
    
    self.headerView.alpha = 100.0;
    
    
    [self.view addSubview:self.headerView];
    
    CGFloat pad = 0, pad2 = 0, height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 0;
        height = 83;
        pad2 = 0;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 0;
        height = 90;
        pad2 = 0;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 0;
        height = 95;
        pad2 = 0;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 0;
        height = 80;
        pad2 = 0;
        
    }
    
    
    
    NSDictionary *viewsDictionary = @{@"black":self.headerView};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-pad-[black]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-pad-[black]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraints:constraint1];
    [self.view addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.headerView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.view addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.headerView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.view addConstraint:constraint4];
    
}


-(void)setOkBtn{
    
    self.okBtn = [[UIButton alloc] init];
    self.okBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.okBtn.backgroundColor = [UIColor clearColor];
    [self.okBtn setTitle:@"OK" forState: UIControlStateNormal];
    
    // Handle clicks on the button
    [self.okBtn
     addTarget:self
     action:@selector(OKBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.okBtn.alpha = 1.0;
    self.okBtn.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
    
    
    self.okBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [self.okBtn invalidateIntrinsicContentSize];
    
    
    [self.okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    CGFloat pad = 0, pad2 = 0, height = 0, buttonWidth = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 15;
        pad2 = 10;
        height = 50;
        buttonWidth = 50;
        self.okBtn.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 15;
        pad2 = 10;
        height = ceilf(103/2);
        buttonWidth = 50;
        self.okBtn.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:24];
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 15;
        pad2 = 10;
        height = ceilf(171/3);
        self.okBtn.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:25];
        buttonWidth = 50;

    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 15;
        pad2 = 10;
        height = 35;
        self.okBtn.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15];
        buttonWidth = 50;

    }
    
    
    [self.view addSubview:self.okBtn];
    
    NSDictionary *viewsDictionary = @{@"Button" : self.okBtn};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[Button]-pad-|" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-pad-[Button]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraints:constraint1];
    [self.view addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.okBtn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.view addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.okBtn attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:buttonWidth];
    [self.view addConstraint:constraint4];
    
    
    
}


-(void)setCancelBtn{
    self.cancelBtn = [[UIButton alloc] init];
    self.cancelBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelBtn.backgroundColor = [UIColor clearColor];
    [self.cancelBtn setTitle:@"Cancel" forState: UIControlStateNormal];
    
    // Handle clicks on the button
    [self.cancelBtn
     addTarget:self
     action:@selector(CancelBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.cancelBtn.alpha = 1.0;
    self.cancelBtn.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
    
    
    self.cancelBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [self.cancelBtn invalidateIntrinsicContentSize];
    
    
    [self.cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    CGFloat pad = 0, pad2 = 0,  height = 0, buttonWidth = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 15;
        pad2 = 0;
        height = 50;
        buttonWidth = 100;
        self.cancelBtn.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 15;
        pad2 = 0;
        height = ceilf(103/2);
        buttonWidth = 100;
        self.cancelBtn.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:24];
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 15;
        pad2 = 0;
        height = ceilf(171/3);
        self.cancelBtn.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:25];
        buttonWidth = 100;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 15;
        pad2 = 10;
        height = 35;
        self.cancelBtn.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15];
        buttonWidth = 100;
        
    }
    
    
    [self.view addSubview:self.cancelBtn];
    
    NSDictionary *viewsDictionary = @{@"Button" : self.cancelBtn};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-pad-[Button]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-pad-[Button]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraints:constraint1];
    [self.view addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.cancelBtn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.view addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.cancelBtn attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:buttonWidth];
    [self.view addConstraint:constraint4];
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addProfileImage {
    
    SinglePhotoViewController *singletonInstance = [SinglePhotoViewController singletonInstance];
    self.photoView = [[UIImageView alloc]init];
    
      CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]);

    self.photoView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.photoView invalidateIntrinsicContentSize];
    
    [self.view addSubview:self.photoView];

    
    self.photoView.image = singletonInstance.photo;
    
    
    
    CGFloat pad = 0, pad2 = 0, height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 85;
        height = 400;
        pad2 = 0;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 90;
        height = 470;
        pad2 = 0;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 96;
        height = 500;
        pad2 = 0;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 70;
        height = 330;
        pad2 = 0;
        
    }
    
    
    
    NSDictionary *viewsDictionary = @{@"image":self.photoView};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-pad-[image]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-pad-[image]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraints:constraint1];
    [self.view addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.photoView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.view addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.photoView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.view addConstraint:constraint4];

}

-(void)OKBtnPressed
{
    //   DataAccess *singletonInstance = [DataAccess singletonInstance];
    SinglePhotoViewController *singlePhoto = [SinglePhotoViewController singletonInstance];
    
    //   [singletonInstance setProfileImage:singlePhoto.photo];
    //   [singletonInstance setProfileImageStatus:YES];
    
    PhotoManager *box = [PhotoManager singletonInstance];
    
    
    if ([box.boxID isEqualToString:@"1"]) {
    [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(singlePhoto.photo) forKey:@"ProfileImage"];
    } else if([box.boxID isEqualToString:@"2"]){
    [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(singlePhoto.photo) forKey:@"ProfileImage2"];
    }else if([box.boxID isEqualToString:@"3"]){
        [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(singlePhoto.photo) forKey:@"ProfileImage3"];
    }else if([box.boxID isEqualToString:@"4"]){
        [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(singlePhoto.photo) forKey:@"ProfileImage4"];
    }
    

    
    NSArray *viewControllers = [[self navigationController] viewControllers];
    for( int i=0;i<[viewControllers count];i++){
        id obj=[viewControllers objectAtIndex:i];
        if([obj isKindOfClass:[AccountViewController class]]){
            [[self navigationController] popToViewController:obj animated:NO];
            return;
        }
    }
    
    
}

-(void)CancelBtnPressed
{

    [self.navigationController popViewControllerAnimated:NO];
    
}



+ (id)singletonInstance {
    
    static SinglePhotoViewController *sharedDataAccess = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDataAccess = [[self alloc] init];
    });
    
    return sharedDataAccess;
    
}

@end
