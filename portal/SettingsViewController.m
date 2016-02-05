//
//  SettingsViewController.m
//  portal
//
//  Created by Neil Ballard on 11/28/15.
//  Copyright © 2015 Neil_appworld. All rights reserved.
//

#import "SettingsViewController.h"
#import "DeviceManager.h"
#import "DataAccess.h"

@interface SettingsViewController ()

@property (nonatomic, retain) UIView * background;
@property (nonatomic, retain) UIView * Line;
@property (nonatomic, retain) UIView * Line2;


@property (nonatomic, retain) UILabel *optionUseLabel;
@property (nonatomic, retain) UIImageView * checkboxUse;

@property (nonatomic, retain) UILabel *optionHideLabel;
@property (nonatomic, retain) UIImageView * checkboxHide;



@property (nonatomic, retain) UINavigationBar * navBar;

@property (nonatomic, retain) CERangeSlider *ageRangeSlider;
@property (nonatomic, retain) DistanceRangeSlider *distanceRangeSlider;


@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect full = [[UIScreen mainScreen]bounds];
    self.background = [[UIView alloc] initWithFrame:full];
    self.background.hidden = NO;
    self.background.backgroundColor = [UIColor whiteColor];
    self.background.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:self.background];
    
    
    [self styleNavBar];
    [self setupAgeLabel];
    [self addAgeSlider];
    [self addLine];
    
    [self setupDistanceLabel];
    [self addDistanceSlider];
    [self addLine2];
    
    
    [self.ageRangeSlider addTarget:self
                     action:@selector(slideAgeValueChanged:)
           forControlEvents:UIControlEventValueChanged];
    
    [self.distanceRangeSlider addTarget:self
                            action:@selector(slideDistanceValueChanged:)
                  forControlEvents:UIControlEventValueChanged];
    
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
    
    
    UIImage *image = [[UIImage imageNamed:@"down_arrow"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(goback)];
    
    
    newItem.rightBarButtonItem = rightBtn;
    
    
    
    UIButton *titleView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [titleView setUserInteractionEnabled:NO];
    
    UIImage *connections_image = [[UIImage imageNamed:@"settings"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [titleView setBackgroundImage:connections_image forState:UIControlStateNormal];
    //    NSString *titleText = @"Name";
    //    [titleView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    //    [titleView setTitle:titleText forState:UIControlStateNormal];
    
    
    newItem.titleView = titleView;
    
    
    
    
    
    // newItem.titleView = backView;
    // 4. add the nav bar to the main view
    [self.navBar setItems:@[newItem]];
    [self.view addSubview:self.navBar];
    
    
}


- (void)setupAgeLabel {
    UIFont *font;
    
    CGFloat height = 0;
    
    self.ageLabel = [[UILabel alloc] init];
    
    self.ageLabel.font = [UIFont systemFontOfSize:5];
    height = 15;
    
    
    
    [self.ageLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.ageLabel invalidateIntrinsicContentSize];
    self.ageLabel.font = font;
    self.ageLabel.textColor = [UIColor blackColor];
    
    self.ageLabel.text = @"Age Range";
    
    [self.view addSubview:self.ageLabel];
    
    NSDictionary *viewsDictionary = @{@"top":self.navBar, @"label" : self.ageLabel};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-21-[label]" options:0 metrics:nil views:viewsDictionary];
    [self.view addConstraints:constraint1];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[top]-10-[label]" options:0 metrics:nil views:viewsDictionary];
    [self.view addConstraints:constraint2];
    
}

- (void)setupDistanceLabel {
    UIFont *font;
    
    CGFloat height = 0;
    
    self.distanceLabel = [[UILabel alloc] init];
    
    self.distanceLabel.font = [UIFont systemFontOfSize:5];
    height = 15;
    
    
    
    [self.distanceLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.distanceLabel invalidateIntrinsicContentSize];
    self.distanceLabel.font = font;
    self.distanceLabel.textColor = [UIColor blackColor];
    
    self.distanceLabel.text = @"Distance";
    
    [self.view addSubview:self.distanceLabel];
    
    NSDictionary *viewsDictionary = @{@"top":self.Line, @"label" : self.distanceLabel};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-21-[label]" options:0 metrics:nil views:viewsDictionary];
    [self.view addConstraints:constraint1];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[top]-10-[label]" options:0 metrics:nil views:viewsDictionary];
    [self.view addConstraints:constraint2];
    
}


- (void)addLine{
    
    self.Line = [[UIView alloc]init];
    
    self.Line.backgroundColor = [self lineColor];
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]) - 20;
    self.Line.translatesAutoresizingMaskIntoConstraints = NO;
    [self.Line invalidateIntrinsicContentSize];
    
    
    
    [self.view addSubview:self.Line];
    
    CGFloat pad = 0, height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 8;
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
    
    
    
    NSDictionary *viewsDictionary = @{@"top":self.ageRangeSlider, @"line": self.Line};
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.Line attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[top]-pad-[line]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraint:constraint1];
    [self.view addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.Line attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.view addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.Line attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.view addConstraint:constraint4];
    
}


- (void)addLine2{
    
    self.Line2 = [[UIView alloc]init];
    
    self.Line2.backgroundColor = [self lineColor];
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]) - 20;
    self.Line2.translatesAutoresizingMaskIntoConstraints = NO;
    [self.Line2 invalidateIntrinsicContentSize];
    
    
    
    [self.view addSubview:self.Line2];
    
    CGFloat pad = 0, height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 8;
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
    
    
    
    NSDictionary *viewsDictionary = @{@"top":self.distanceRangeSlider, @"line": self.Line2};
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.Line2 attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[top]-pad-[line]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraint:constraint1];
    [self.view addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.Line2 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.view addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.Line2 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.view addConstraint:constraint4];
    
}



-(void)addAgeSlider{
    
    
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]) - 40;
    
    CGFloat pad = 0, height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 20;
        height = 30;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 10;
        height = 30;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 10;
        height = 30;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 10;
        height = 30;
    }
    
    
    self.ageRangeSlider = [[CERangeSlider alloc] initWithFrame:CGRectMake(pad, 100, width - 10 * 2, height)];
    self.ageRangeSlider.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:self.ageRangeSlider];
    
    
    
}

-(void)addDistanceSlider{
    
    
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]) - 40;
    
    CGFloat pad = 0, height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 20;
        height = 30;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 10;
        height = 30;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 10;
        height = 30;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 10;
        height = 30;
    }
    
    
    self.distanceRangeSlider = [[DistanceRangeSlider alloc] initWithFrame:CGRectMake(pad, 200, width - 10 * 2, height)];
    self.distanceRangeSlider.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:self.distanceRangeSlider];
    
}




- (void)slideAgeValueChanged:(id)control
{
    NSLog(@"Slider Age value changed: (%.2f,%.2f)",
          self.ageRangeSlider.lowerValue, self.ageRangeSlider.upperValue);
}

- (void)slideDistanceValueChanged:(id)control
{
    NSLog(@"Slider Distance value changed: (%.2f,%.2f)",
          self.distanceRangeSlider.lowerValue, self.distanceRangeSlider.upperValue);
}

-(void)goback{
    
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

@end
