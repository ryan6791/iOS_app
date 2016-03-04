//
//  BioInfoViewController.m
//  pairedUP
//
//  Created by Neil Ballard on 1/27/16.
//  Copyright © 2016 Neil_appworld. All rights reserved.
//

#import "BioInfoViewController.h"
#import "DeviceManager.h"
#import "DataAccess.h"

@interface BioInfoViewController ()

@end

@implementation BioInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self styleNavBar];
 //   [self setupbioLabel];
  //  [self setupBioTextField];
    [self addEduIcon];
    [self setupEduLabel];
    [self setupEduTextField];
    
    [self addWorkIcon];
    [self setupWorkLabel];
    [self setupJobTextField];
    
    [self addinfoIcon];
    [self setupInfoLabel];
    [self setupBioTextField];
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
    self.navBar.barTintColor = [UIColor whiteColor];
    
    
    
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
     
     [titleView setBackgroundImage:[UIImage imageNamed:@"settings"] forState:UIControlStateNormal];
     
     //  NSString *titleText = @"Portal";
     //  [titleView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
     
     //  [titleView setTitle:titleText forState:UIControlStateNormal];
     
     newItem.titleView = titleView; */
    
    
    
    
    
    // newItem.titleView = backView;
    // 4. add the nav bar to the main view
    [self.navBar setItems:@[newItem]];
    [self.view addSubview:self.navBar];
    
    
}


- (void)setupEduTextField {
    
    self.eduTextField = [[UITextField alloc]init];
    self.eduTextField.delegate = self;
    self.eduTextField.layer.cornerRadius = 7.0;
    self.eduTextField.translatesAutoresizingMaskIntoConstraints = NO;
    [self.eduTextField invalidateIntrinsicContentSize];
    
    NSString *bio = [[DataAccess singletonInstance] getEdu];
    
    if (bio != nil) {
        self.eduTextField.text = bio;
    }
    
    CGRect screen = [[UIScreen mainScreen] bounds];
    CGFloat height = 0, width = 0, xpad = 0, ypad = 0;
    width = screen.size.width - 85;
    CGFloat font_size = 0;
    
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        height = 35;
        xpad = 15;
        ypad = 3;
        font_size = 12;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        height = 35;
        xpad = 15;
        ypad = 5;
        font_size = 13;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        height = 35;
        xpad = 15;
        ypad = 10;
        font_size = 14;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad])
    {
        height = 35;
        xpad = 15;
        ypad = 0;
        font_size = 11;
        
    }
    
    UIColor *color = [UIColor lightGrayColor];
    
    
    self.eduTextField.backgroundColor = [UIColor whiteColor];
    self.eduTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.eduTextField.layer.borderWidth = 0.5f;
    self.eduTextField.layer.masksToBounds = true;
    
    NSMutableDictionary *viewsDictionary = [[NSMutableDictionary alloc] init];
    [viewsDictionary setObject:self.eduTextField forKey:@"textField"];
    [viewsDictionary setObject:self.eduLabel forKey:@"label"];
    [viewsDictionary setObject:self.educationIcon forKey:@"side"];
    
    [self.view addSubview:self.eduTextField];
    
    NSArray *hConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[side]-xpad-[textField]" options:0 metrics:@{@"xpad" : [NSNumber numberWithFloat:xpad], @"width" : [NSNumber numberWithFloat:width]} views:viewsDictionary];
    NSArray *vConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[label]-pad-[textField(height)]" options:0 metrics:@{@"height" : [NSNumber numberWithFloat:height], @"pad" : [NSNumber numberWithFloat:ypad]} views:viewsDictionary];
    
    [self.view addConstraints:hConstraints];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.eduTextField attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width]];
    
    [self.view addConstraints:vConstraints];
    
}

- (void)setupJobTextField {
    
    self.jobTextField = [[UITextField alloc]init];
    self.jobTextField.delegate = self;
    self.jobTextField.layer.cornerRadius = 7.0;
    self.jobTextField.translatesAutoresizingMaskIntoConstraints = NO;
    [self.jobTextField invalidateIntrinsicContentSize];
    
    NSString *bio = [[DataAccess singletonInstance] getWork];
    
    if (bio != nil) {
        self.jobTextField.text = bio;
    }
    
    CGRect screen = [[UIScreen mainScreen] bounds];
    CGFloat height = 0, width = 0, xpad = 0, ypad = 0;
    width = screen.size.width - 85;
    CGFloat font_size = 0;
    
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        height = 35;
        xpad = 15;
        ypad = 3;
        font_size = 12;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        height = 35;
        xpad = 15;
        ypad = 5;
        font_size = 13;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        height = 35;
        xpad = 15;
        ypad = 10;
        font_size = 14;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad])
    {
        height = 35;
        xpad = 15;
        ypad = 0;
        font_size = 11;
        
    }
    
    UIColor *color = [UIColor lightGrayColor];
    
    
    self.jobTextField.backgroundColor = [UIColor whiteColor];
    self.jobTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.jobTextField.layer.borderWidth = 0.5f;
    self.jobTextField.layer.masksToBounds = true;
    
    NSMutableDictionary *viewsDictionary = [[NSMutableDictionary alloc] init];
    [viewsDictionary setObject:self.jobTextField forKey:@"textField"];
    [viewsDictionary setObject:self.workLabel forKey:@"label"];
    [viewsDictionary setObject:self.workIcon forKey:@"side"];
    
    [self.view addSubview:self.jobTextField];
    
    NSArray *hConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[side]-xpad-[textField]" options:0 metrics:@{@"xpad" : [NSNumber numberWithFloat:xpad], @"width" : [NSNumber numberWithFloat:width]} views:viewsDictionary];
    NSArray *vConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[label]-pad-[textField(height)]" options:0 metrics:@{@"height" : [NSNumber numberWithFloat:height], @"pad" : [NSNumber numberWithFloat:ypad]} views:viewsDictionary];
    
    [self.view addConstraints:hConstraints];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.jobTextField attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width]];
    
    [self.view addConstraints:vConstraints];
    
}

- (void)setupBioTextField {
    
    self.bioTextView = [[UITextView alloc]init];
    self.bioTextView.delegate = self;
    self.bioTextView.layer.cornerRadius = 7.0;
    self.bioTextView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.bioTextView invalidateIntrinsicContentSize];
    
    NSString *bio = [[DataAccess singletonInstance] getBio];
    
      if (bio != nil) {
          self.bioTextView.text = bio;
      }
    
    CGRect screen = [[UIScreen mainScreen] bounds];
    CGFloat height = 0, width = 0, xpad = 0, ypad = 0;
    width = screen.size.width - 85;
    CGFloat font_size = 0;
    
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        height = 150;
        xpad = 15;
        ypad = 3;
        font_size = 12;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        height = 200;
        xpad = 15;
        ypad = 5;
        font_size = 13;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        height = 45;
        xpad = 15;
        ypad = 10;
        font_size = 14;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad])
    {
        height = 30;
        xpad = 15;
        ypad = 0;
        font_size = 11;
        
    }
    
    UIColor *color = [UIColor lightGrayColor];
    
    
    self.bioTextView.backgroundColor = [UIColor whiteColor];
    self.bioTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.bioTextView.layer.borderWidth = 0.5f;
    self.bioTextView.layer.masksToBounds = true;
    
    NSMutableDictionary *viewsDictionary = [[NSMutableDictionary alloc] init];
    [viewsDictionary setObject:self.bioTextView forKey:@"textField"];
    [viewsDictionary setObject:self.infoLabel forKey:@"label"];
    [viewsDictionary setObject:self.infoIcon forKey:@"side"];
    
    [self.view addSubview:self.bioTextView];
    
    NSArray *hConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[side]-xpad-[textField]" options:0 metrics:@{@"xpad" : [NSNumber numberWithFloat:xpad], @"width" : [NSNumber numberWithFloat:width]} views:viewsDictionary];
    NSArray *vConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[label]-pad-[textField(height)]" options:0 metrics:@{@"height" : [NSNumber numberWithFloat:height], @"pad" : [NSNumber numberWithFloat:ypad]} views:viewsDictionary];
    
    [self.view addConstraints:hConstraints];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bioTextView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width]];
    
    [self.view addConstraints:vConstraints];
    
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
    
    
    
    
    
    
    
    
    NSDictionary *viewsDictionary = @{@"top" : self.jobTextField, @"icon" : self.infoIcon};
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
    
    
    
    
    
    
    
    
    NSDictionary *viewsDictionary = @{@"top" : self.navBar, @"icon" : self.educationIcon};
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
    
    
    
    NSDictionary *viewsDictionary = @{@"top" : self.eduTextField, @"icon" : self.workIcon};
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
    
    NSDictionary *viewsDictionary = @{@"label" : self.eduLabel, @"side" : self.educationIcon, @"top": self.navBar};
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
        pad = 38;
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
    
    NSDictionary *viewsDictionary = @{@"label" : self.workLabel, @"side" : self.workIcon, @"top": self.eduTextField};
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
        pad = 32;
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
    
    NSDictionary *viewsDictionary = @{@"label" : self.infoLabel, @"side" : self.infoIcon, @"top": self.jobTextField};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[top]-pad-[label]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraints:constraint1];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[side]-pad-[label]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    [self.view addConstraints:constraint2];
    
}


- (void)textFieldDidChange {
    //
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [textField setReturnKeyType:UIReturnKeyDone];
    return TRUE;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if(textField == self.jobTextField) {
        [[DataAccess singletonInstance] setWork:self.jobTextField.text];
        [self.jobTextField resignFirstResponder];
        [self.jobTextField endEditing:YES];
    }
    else if(textField == self.eduTextField) {
        [[DataAccess singletonInstance] setEdu:self.eduTextField.text];
        [self.eduTextField endEditing:YES];
        [self.eduTextField resignFirstResponder];
    }

    
 /*   if([self.jobTextField isFirstResponder]) {
        [[DataAccess singletonInstance] setWork:self.jobTextField.text];
        [self.jobTextField resignFirstResponder];
        [self.jobTextField endEditing:YES];
    }
    else if([self.eduTextField isFirstResponder]) {
        [[DataAccess singletonInstance] setEdu:self.eduTextField.text];
        [self.eduTextField endEditing:YES];
        [self.eduTextField resignFirstResponder];
    }
    else if([self.biotextView isFirstResponder]) {
        [[DataAccess singletonInstance] setBio:self.biotextView.text];
        [self.biotextView endEditing:YES];
        [self.biotextView resignFirstResponder];
    } */
}

- (void)touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event {
    NSArray *subviews = [self.view subviews];
    for (id objects in subviews) {
        if ([objects isKindOfClass:[UITextField class]]) {
            UITextField *theTextField = objects;
            if ([objects isFirstResponder]) {
                [theTextField resignFirstResponder];
            }
        }
        if ([objects isKindOfClass:[UITextView class]]) {
            UITextView *theTextView = objects;
            if ([objects isFirstResponder]) {
                [theTextView resignFirstResponder];
            }
        }
    }
}


- (void)textViewDidChange {
    //
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    [textView setReturnKeyType:UIReturnKeyDone];
    return TRUE;
}

- (BOOL)textViewShouldClear:(UITextView *)textView{
    return YES;
}

- (BOOL)textViewShouldReturn:(UITextView *)textView{
    [textView resignFirstResponder];
    return YES;
}


- (void)textViewDidEndEditing:(UITextView *)textView {
    

    [[DataAccess singletonInstance] setBio:self.bioTextView.text];
    [self.bioTextView endEditing:YES];
    [self.bioTextView resignFirstResponder];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSRange resultRange = [text rangeOfCharacterFromSet:[NSCharacterSet newlineCharacterSet] options:NSBackwardsSearch];
    if ([text length] == 1 && resultRange.location != NSNotFound) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}





- (UIColor *) cdBlue {
    return [UIColor colorWithRed:0.00 green:0.59 blue:0.84 alpha:1.0];
}

-(void)goback{
    
    [self.navigationController popViewControllerAnimated:YES];
    
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
