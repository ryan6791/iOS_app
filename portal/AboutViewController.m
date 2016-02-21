//
//  AboutViewController.m
//  pairedUP
//
//  Created by Neil Ballard on 2/19/16.
//  Copyright © 2016 Neil_appworld. All rights reserved.
//

#import "AboutViewController.h"
#import "DeviceManager.h"
#import "DataAccess.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addProfileIcon];
    [self setupNameLabel];
    [self setupconnectLabel];
    
    [self addLocationIcon];
    [self setupLocationLabel];
    [self setupLocationText];
    
    [self addEduIcon];
    [self setupEduLabel];
    [self setupEduText];
    
    [self addWorkIcon];
    [self setupWorkLabel];
    [self setupWorkText];
    
    [self addinfoIcon];
    [self setupInfoLabel];
    [self setupInfoText];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)addProfileIcon {
    
    self.photoIcon = [[UIImageView alloc]init];
    
    self.photoIcon.backgroundColor = [UIColor blueColor];
    self.photoIcon.translatesAutoresizingMaskIntoConstraints = NO;
    [self.photoIcon invalidateIntrinsicContentSize];
    
    NSData* imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"matchImage"];
    UIImage* image = [UIImage imageWithData:imageData];
    
    
    if (image != nil) {
        self.photoIcon.image = image;
    }else{
        self.photoIcon.image = [UIImage imageNamed:@"image_placeholder.png"];
    }
    
    self.photoIcon.alpha = 2.0;
    
    self.photoIcon.userInteractionEnabled = YES;
    UITapGestureRecognizer *pictureTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(goToPic:)];
    [self.photoIcon addGestureRecognizer:pictureTap];
    
    [self.view addSubview:self.photoIcon];
    
    CGFloat pad = 0, height = 0, width;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 40;
        height = 40;
        width = 40;
        self.photoIcon.layer.cornerRadius = 20;
        self.photoIcon.layer.masksToBounds = YES;
        self.photoIcon.layer.shadowOffset = CGSizeMake(-.1, .2);
        self.photoIcon.layer.shadowRadius = .5;
        self.photoIcon.layer.shadowOpacity = 0.5;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 40;
        height = 205;
        width = 205;
        self.photoIcon.layer.cornerRadius = 102.50000;
        self.photoIcon.layer.masksToBounds = YES;
        self.photoIcon.layer.shadowOffset = CGSizeMake(-.1, .2);
        self.photoIcon.layer.shadowRadius = .5;
        self.photoIcon.layer.shadowOpacity = 0.5;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 40;
        height = 205;
        width = 205;
        self.photoIcon.layer.cornerRadius = 102.50000;
        self.photoIcon.layer.masksToBounds = YES;
        self.photoIcon.layer.shadowOffset = CGSizeMake(-.1, .2);
        self.photoIcon.layer.shadowRadius = .5;
        self.photoIcon.layer.shadowOpacity = 0.5;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 40;
        height = 205;
        width = 205;
        self.photoIcon.layer.cornerRadius = 102.50000;
        self.photoIcon.layer.masksToBounds = YES;
        self.photoIcon.layer.shadowOffset = CGSizeMake(-.1, .2);
        self.photoIcon.layer.shadowRadius = .5;
        self.photoIcon.layer.shadowOpacity = 0.5;
    }
    
    // CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]) - widthOffset;
    
    

    NSDictionary *viewsDictionary = @{@"icon" : self.photoIcon};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-pad-[icon]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:50]} views:viewsDictionary];
    [self.view addConstraints:constraint1];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-pad-[icon]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:15]} views:viewsDictionary];
    [self.view addConstraints:constraint2];
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.photoIcon attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.view addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.photoIcon attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.view addConstraint:constraint4];
    
}

- (void)addLocationIcon {
    
    
    
    self.locationIcon = [[UIImageView alloc]init];
    
    
    
    self.locationIcon.backgroundColor = [UIColor blueColor];
    
    self.locationIcon.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.locationIcon invalidateIntrinsicContentSize];

    self.locationIcon.image = [UIImage imageNamed:@"location"];
    
    
    
    self.locationIcon.alpha = 2.0;
    
    
    
    self.locationIcon.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *pictureTap =
    
    [[UITapGestureRecognizer alloc] initWithTarget:self
     
                                            action:@selector(goToPic:)];
    
    [self.locationIcon addGestureRecognizer:pictureTap];
    
    [self.locationIcon setBackgroundColor:[UIColor clearColor]];
    
    [self.view addSubview:self.locationIcon];
    
    
    
    CGFloat pad = 0, height = 0, width;
    
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
        
    {
        
        pad = 40;
        height = 25;
        width = 25;
        
        self.locationIcon.layer.masksToBounds = YES;
        
        self.locationIcon.layer.shadowOffset = CGSizeMake(-.1, .2);
        
        self.locationIcon.layer.shadowRadius = .5;
        
        self.locationIcon.layer.shadowOpacity = 0.5;
        
    }
    
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
        
    {
        
        pad = 40;
        
        height = 205;
        
        width = 205;
        
        self.locationIcon.layer.cornerRadius = 102.50000;
        
        self.locationIcon.layer.masksToBounds = YES;
        
        self.locationIcon.layer.shadowOffset = CGSizeMake(-.1, .2);
        
        self.locationIcon.layer.shadowRadius = .5;
        
        self.locationIcon.layer.shadowOpacity = 0.5;
        
        
        
    }
    
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
        
    {
        
        pad = 40;
        
        height = 205;
        
        width = 205;
        
        self.locationIcon.layer.cornerRadius = 102.50000;
        
        self.locationIcon.layer.masksToBounds = YES;
        
        self.locationIcon.layer.shadowOffset = CGSizeMake(-.1, .2);
        
        self.locationIcon.layer.shadowRadius = .5;
        
        self.locationIcon.layer.shadowOpacity = 0.5;
        
        
        
    }
    
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        
        pad = 40;
        
        height = 205;
        
        width = 205;
        
        self.locationIcon.layer.cornerRadius = 102.50000;
        
        self.locationIcon.layer.masksToBounds = YES;
        
        self.locationIcon.layer.shadowOffset = CGSizeMake(-.1, .2);
        
        self.locationIcon.layer.shadowRadius = .5;
        
        self.locationIcon.layer.shadowOpacity = 0.5;
        
    }
    
    
    
    // CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]) - widthOffset;
    
    
    
    
    
    
    NSDictionary *viewsDictionary = @{@"icon" : self.locationIcon, @"top" : self.photoIcon};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[top]-pad-[icon]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:28]} views:viewsDictionary];
    [self.view addConstraints:constraint1];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-pad-[icon]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:20]} views:viewsDictionary];
    [self.view addConstraints:constraint2];
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.locationIcon attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.view addConstraint:constraint3];
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.locationIcon attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    
    [self.view addConstraint:constraint4];
    
    
    
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
    
    
    
    
    
    
    
    
    NSDictionary *viewsDictionary = @{@"top" : self.workIcon, @"icon" : self.infoIcon};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[top]-pad-[icon]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:42]} views:viewsDictionary];
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
    
    
    
    
    
    
    
    
    NSDictionary *viewsDictionary = @{@"top" : self.locationIcon, @"icon" : self.educationIcon};
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
    
    
    
    NSDictionary *viewsDictionary = @{@"top" : self.educationIcon, @"icon" : self.workIcon};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[top]-pad-[icon]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:38]} views:viewsDictionary];
    [self.view addConstraints:constraint1];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-pad-[icon]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:20]} views:viewsDictionary];
    [self.view addConstraints:constraint2];
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.workIcon attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    
    [self.view addConstraint:constraint3];
    
    
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.workIcon attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    
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
        self.nameLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:22];
        pad = 55;
        pad2 = 12;
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
    
    NSDictionary *viewsDictionary = @{@"label" : self.nameLabel, @"side" : self.photoIcon};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-pad-[label]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraints:constraint1];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[side]-pad-[label]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    [self.view addConstraints:constraint2];
    
}

- (void)setupconnectLabel {
    
    
    
    
    
    self.connectLabel = [[UILabel alloc] init];
    
    [self.connectLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.connectLabel invalidateIntrinsicContentSize];
    
    self.connectLabel.textColor = [UIColor lightGrayColor];
    
    
    
    self.connectLabel.text = @"Connected 3 days ago";
    
    
    
    
    
    self.connectLabel.layer.masksToBounds = NO;
    
    
    
    //   self.connectLabel.layer.shouldRasterize = YES;
    
    
    
    CGFloat pad = 0, pad2 = 0;
    
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
        
    {
        
        self.connectLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
        
        pad = 3;
        
        pad2 = 13;
        
    }
    
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
        
    {
        
        self.connectLabel.font = [UIFont systemFontOfSize:26];
        
        pad = 3;
        
        pad2 = 20;
        
    }
    
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
        
    {
        
        pad = 9;
        
        pad2 = 16;
        
        self.connectLabel.font = [UIFont systemFontOfSize:27];
        
        
        
    }
    
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        
        pad = 6;
        
        pad2 = 8;
        
        self.connectLabel.font = [UIFont systemFontOfSize:19];
        
        
        
    }
    
    
    
    self.connectLabel.alpha = 100.0;
    
    
    
    [self.view addSubview:self.connectLabel];
    
    
    
    NSDictionary *viewsDictionary = @{@"label" : self.connectLabel, @"side" : self.photoIcon, @"top": self.nameLabel};
    
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[top]-pad-[label]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    
    [self.view addConstraints:constraint1];
    
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[side]-pad-[label]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    
    [self.view addConstraints:constraint2];
    
    
    
}


- (void)setupLocationLabel {
    
    
    self.locationLabel = [[UILabel alloc] init];
    [self.locationLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.locationLabel invalidateIntrinsicContentSize];
    self.locationLabel.textColor = [UIColor lightGrayColor];
    
    self.locationLabel.text = @"Location";
    
    
    self.locationLabel.layer.masksToBounds = NO;
    
    //   self.nameLabel.layer.shouldRasterize = YES;
    
    CGFloat pad = 0, pad2 = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        self.locationLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:17];
        pad = 25;
        pad2 = 17;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        self.locationLabel.font = [UIFont systemFontOfSize:26];
        pad = 8;
        pad2 = 12;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 9;
        pad2 = 16;
        self.locationLabel.font = [UIFont systemFontOfSize:27];
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 6;
        pad2 = 8;
        self.locationLabel.font = [UIFont systemFontOfSize:19];
        
    }
    
    self.locationLabel.alpha = 100.0;
    
    [self.view addSubview:self.locationLabel];
    
    NSDictionary *viewsDictionary = @{@"label" : self.locationLabel, @"side" : self.locationIcon, @"top": self.connectLabel};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[top]-pad-[label]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraints:constraint1];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[side]-pad-[label]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    [self.view addConstraints:constraint2];
    
}

- (void)setupLocationText {
    
    
    self.locationTextLabel = [[UILabel alloc] init];
    [self.locationTextLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.locationTextLabel invalidateIntrinsicContentSize];
    self.locationTextLabel.textColor = [UIColor lightGrayColor];
    
    self.locationTextLabel.text = @"Portland, Oregon";
    
    
    self.locationTextLabel.layer.masksToBounds = NO;
    
    //   self.nameLabel.layer.shouldRasterize = YES;
    
    CGFloat pad = 0, pad2 = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        self.locationTextLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
        pad = 3;
        pad2 = 18;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        self.locationTextLabel.font = [UIFont systemFontOfSize:26];
        pad = 8;
        pad2 = 12;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 9;
        pad2 = 16;
        self.locationTextLabel.font = [UIFont systemFontOfSize:27];
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 6;
        pad2 = 8;
        self.locationTextLabel.font = [UIFont systemFontOfSize:19];
        
    }
    
    self.locationTextLabel.alpha = 100.0;
    
    [self.view addSubview:self.locationTextLabel];
    
    NSDictionary *viewsDictionary = @{@"label" : self.locationTextLabel, @"side" : self.locationIcon, @"top": self.locationLabel};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[top]-pad-[label]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraints:constraint1];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[side]-pad-[label]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    [self.view addConstraints:constraint2];
    
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
        pad = 25;
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
    
    NSDictionary *viewsDictionary = @{@"label" : self.eduLabel, @"side" : self.educationIcon, @"top": self.locationTextLabel};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[top]-pad-[label]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraints:constraint1];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[side]-pad-[label]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    [self.view addConstraints:constraint2];
    
}

- (void)setupEduText {
    
    
    self.eduTextLabel = [[UILabel alloc] init];
    [self.eduTextLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.eduTextLabel invalidateIntrinsicContentSize];
    self.eduTextLabel.textColor = [UIColor lightGrayColor];
    
    self.eduTextLabel.text = @"Florida State University";
    
    
    self.eduTextLabel.layer.masksToBounds = NO;
    
    //   self.nameLabel.layer.shouldRasterize = YES;
    
    CGFloat pad = 0, pad2 = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        self.eduTextLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
        pad = 3;
        pad2 = 18;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        self.eduTextLabel.font = [UIFont systemFontOfSize:26];
        pad = 8;
        pad2 = 12;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 9;
        pad2 = 16;
        self.eduTextLabel.font = [UIFont systemFontOfSize:27];
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 6;
        pad2 = 8;
        self.eduTextLabel.font = [UIFont systemFontOfSize:19];
        
    }
    
    self.eduTextLabel.alpha = 100.0;
    
    [self.view addSubview:self.eduTextLabel];
    
    NSDictionary *viewsDictionary = @{@"label" : self.eduTextLabel, @"side" : self.educationIcon, @"top": self.eduLabel};
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
        pad = 23;
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
    
    NSDictionary *viewsDictionary = @{@"label" : self.workLabel, @"side" : self.workIcon, @"top": self.eduTextLabel};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[top]-pad-[label]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraints:constraint1];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[side]-pad-[label]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    [self.view addConstraints:constraint2];
    
}

- (void)setupWorkText {
    
    
    self.workTextLabel = [[UILabel alloc] init];
    [self.workTextLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.workTextLabel invalidateIntrinsicContentSize];
    self.workTextLabel.textColor = [UIColor lightGrayColor];
    
    self.workTextLabel.text = @"Software Engineer at Nowhere";
    
    
    self.workTextLabel.layer.masksToBounds = NO;
    
    //   self.nameLabel.layer.shouldRasterize = YES;
    
    CGFloat pad = 0, pad2 = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        self.workTextLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
        pad = 3;
        pad2 = 18;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        self.workTextLabel.font = [UIFont systemFontOfSize:26];
        pad = 8;
        pad2 = 12;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 9;
        pad2 = 16;
        self.workTextLabel.font = [UIFont systemFontOfSize:27];
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 6;
        pad2 = 8;
        self.workTextLabel.font = [UIFont systemFontOfSize:19];
        
    }
    
    self.workTextLabel.alpha = 100.0;
    
    [self.view addSubview:self.workTextLabel];
    
    NSDictionary *viewsDictionary = @{@"label" : self.workTextLabel, @"side" : self.workIcon, @"top": self.workLabel};
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
        pad = 25;
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
    
    NSDictionary *viewsDictionary = @{@"label" : self.infoLabel, @"side" : self.infoIcon, @"top": self.workTextLabel};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[top]-pad-[label]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraints:constraint1];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[side]-pad-[label]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    [self.view addConstraints:constraint2];
    
}



- (void)setupInfoText {
    
    
    self.infoTextLabel = [[UITextView alloc] init];
    [self.infoTextLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.infoTextLabel invalidateIntrinsicContentSize];
    self.infoTextLabel.textColor = [UIColor lightGrayColor];
    self.infoTextLabel.backgroundColor = [UIColor clearColor];
    
    self.infoTextLabel.text = @"Lover of long walks on the beach. Candlelit dinners under the stars. BE A GENTLEMAN. Not here for a one night stand. snapchat: @wineloverxx3";
    
    
    self.infoTextLabel.layer.masksToBounds = NO;
    
    //   self.nameLabel.layer.shouldRasterize = YES;
    
    CGFloat pad = 0, pad2 = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        self.infoTextLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
        pad = -5;
        pad2 = 14;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        self.infoTextLabel.font = [UIFont systemFontOfSize:26];
        pad = 8;
        pad2 = 12;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 9;
        pad2 = 16;
        self.infoTextLabel.font = [UIFont systemFontOfSize:27];
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 6;
        pad2 = 8;
        self.infoTextLabel.font = [UIFont systemFontOfSize:19];
        
    }
    
    self.infoTextLabel.alpha = 100.0;
    
    [self.view addSubview:self.infoTextLabel];
    
    NSDictionary *viewsDictionary = @{@"label" : self.infoTextLabel, @"side" : self.infoIcon, @"top": self.infoLabel};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[top]-pad-[label]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraints:constraint1];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[side]-pad-[label]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    [self.view addConstraints:constraint2];
    
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.infoTextLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:200];
    [self.view addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.infoTextLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:235];
    [self.view addConstraint:constraint4];
    
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
