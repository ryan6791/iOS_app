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

@interface SinglePhotoViewController ()

@property (nonatomic, strong) UIImageView *photoView;

@end

@implementation SinglePhotoViewController

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
    
    UIBarButtonItem *okButton = [[UIBarButtonItem alloc] initWithTitle:@"OK" style: UIBarButtonItemStylePlain target:self action:@selector(Ok)];
    self.navigationItem.rightBarButtonItem = okButton;

}



- (IBAction)Back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)Ok
{
 //   DataAccess *singletonInstance = [DataAccess singletonInstance];
    SinglePhotoViewController *singlePhoto = [SinglePhotoViewController singletonInstance];
    
 //   [singletonInstance setProfileImage:singlePhoto.photo];
 //   [singletonInstance setProfileImageStatus:YES];
   
    [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(singlePhoto.photo) forKey:@"ProfileImage"];

    AccountViewController *account = [[AccountViewController alloc] init];
    [self.navigationItem setHidesBackButton:YES];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.navigationController pushViewController:account animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addProfileImage {
    
    SinglePhotoViewController *singletonInstance = [SinglePhotoViewController singletonInstance];
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
    
    self.photoView.image = singletonInstance.photo;
    
    
    
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
    
    [titleView setImage:[UIImage imageNamed:@"logo_.png"] forState:UIControlStateNormal];
    
    self.navigationItem.titleView = titleView;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

+ (id)singletonInstance {
    
    static SinglePhotoViewController *sharedOTTODataAccess = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedOTTODataAccess = [[self alloc] init];
    });
    
    return sharedOTTODataAccess;
    
}

@end
