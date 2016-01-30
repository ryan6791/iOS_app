//
//  LockedNewMatchViewController.m
//  pairedUP
//
//  Created by Neil Ballard on 1/13/16.
//  Copyright © 2016 Neil_appworld. All rights reserved.
//

#import "LockedNewMatchViewController.h"
#import "DeviceManager.h"
#import "DataAccess.h"

@interface LockedNewMatchViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *pic;
@property (strong, nonatomic) IBOutlet UIView *background;

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *contact_time;

@end

@implementation LockedNewMatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden = YES;
    [self.navigationItem setHidesBackButton:YES];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    //  self.background.hidden = YES;
    self.pic.hidden = YES;
    self.nameLabel.hidden = YES;
    self.contact_time.hidden = YES;
    
    [self addBackground];
    [self setupMatchLabel];
    [self addProfileImage];
    [self setupNameLabel];
    
    
    [self setDumpBtn];
    [self setMoveOnBtn];
    [self setupDecisionLabel];
}

- (void)addBackground{
    
    self.background = [[UIView alloc]init];
    
    
    
    self.background.backgroundColor = [UIColor whiteColor];
    self.background.translatesAutoresizingMaskIntoConstraints = NO;
    [self.background invalidateIntrinsicContentSize];
    
    
    self.background.alpha = 0.95f;
    
    self.background.userInteractionEnabled = YES;
    
    
    
    
    
    [self.view addSubview:self.background];
    
    self.background.layer.masksToBounds = YES;
    self.background.layer.shadowOffset = CGSizeMake(-.1, .2);
    self.background.layer.shadowRadius = .5;
    self.background.layer.shadowOpacity = 0.5;
    
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
    
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]) - Offset;
    CGFloat height = CGRectGetHeight([[UIScreen mainScreen] bounds]) - Offset;
    
    
    
    
    NSDictionary *viewsDictionary = @{@"back":self.background};
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.background attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-pad-[back]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraint:constraint1];
    [self.view addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.background attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.view addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.background attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.view addConstraint:constraint4];
    
    
}


- (void)setupMatchLabel {
    
    
    self.matchLabel = [[UILabel alloc] init];
    [self.matchLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.matchLabel invalidateIntrinsicContentSize];
    self.matchLabel.textColor = [UIColor lightGrayColor];
    
    self.matchLabel.text = @"Your matched with:";
    
    
    self.matchLabel.layer.masksToBounds = NO;
    
    
    CGFloat pad = 0, pad2 = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        self.matchLabel.font = [UIFont systemFontOfSize:24];
        pad = 17;
        pad2 = 80;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        self.matchLabel.font = [UIFont systemFontOfSize:26];
        pad = 8;
        pad2 = 90;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 9;
        pad2 = 100;
        self.nameLabel.font = [UIFont systemFontOfSize:27];
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 6;
        pad2 = 75;
        self.matchLabel.font = [UIFont systemFontOfSize:19];
        
    }
    
    self.matchLabel.alpha = 100.0;
    
    [self.view addSubview:self.matchLabel];
    
    NSDictionary *viewsDictionary = @{@"label" : self.matchLabel};
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.matchLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    [self.view addConstraint:constraint1];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-pad-[label]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    [self.view addConstraints:constraint2];
    
}


- (void)addProfileImage {
    
    self.pic = [[UIImageView alloc]init];
    
    self.pic.backgroundColor = [UIColor blueColor];
    self.pic.translatesAutoresizingMaskIntoConstraints = NO;
    [self.pic invalidateIntrinsicContentSize];
    
    NSData* imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"ProfileImage"];
    UIImage* image = [UIImage imageWithData:imageData];
    
    
    if (image != nil) {
        self.pic.image = [[DataAccess singletonInstance] getProfileImage];
    }else{
        self.pic.image = [UIImage imageNamed:@"image_placeholder.png"];
    }
    
    self.pic.alpha = 2.0;
    
    
    
    
    [self.view addSubview:self.pic];
    
    CGFloat pad = 0, height = 0, widthOffset;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 30;
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
        self.pic.layer.cornerRadius = 105;
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
    
    
    
    NSDictionary *viewsDictionary = @{@"image":self.pic, @"label": self.matchLabel};
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.pic attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[label]-pad-[image]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
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
    
    self.nameLabel.text = [[DataAccess singletonInstance] getName];
    
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
        pad2 = 16;
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


-(void)setDumpBtn{
    
    
    self.goDump = [[UIButton alloc] init];
    self.goDump=[UIButton buttonWithType:UIButtonTypeCustom];
    self.goDump.backgroundColor = [self facebookBlue];
    NSString *dropText = @"Drop ";
    NSString *name = [[DataAccess singletonInstance]  getName];
    dropText = [dropText stringByAppendingString:name];
    [self.goDump setTitle:dropText forState: UIControlStateNormal];
    
    // Handle clicks on the button
    [self.goDump
     addTarget:self
     action:@selector(KeepSwipingBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.goDump.alpha = 1.0;
    self.goDump.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
    
    self.goDump.layer.cornerRadius = 3.0;
    
    self.goDump.translatesAutoresizingMaskIntoConstraints = NO;
    [self.goDump invalidateIntrinsicContentSize];
    
    CGFloat buttonWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]) - 30;
    
    [self.goDump setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.goDump.titleEdgeInsets = UIEdgeInsetsMake(15, 0, 15, 0);
    
    CGFloat pad = 0, height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 20;
        height = 50;
        self.goDump.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 20;
        height = ceilf(103/2);
        self.goDump.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:24];
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 20;
        height = ceilf(171/3);
        self.goDump.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:25];
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 20;
        height = 35;
        self.goDump.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15];
    }
    
    
    [self.view addSubview:self.goDump];
    
    NSDictionary *viewsDictionary = @{@"Button" : self.goDump};
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.goDump attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[Button]-pad-|" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraint:constraint1];
    [self.view addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.goDump attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.view addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.goDump attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:buttonWidth];
    [self.view addConstraint:constraint4];
    
    
    
}

-(void)setMoveOnBtn{
    
    
    self.moveOn = [[UIButton alloc] init];
    self.moveOn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.moveOn.backgroundColor = [self linkedinBlue];
    [self.moveOn setTitle: @"Keep Swiping" forState: UIControlStateNormal];
    // Handle clicks on the button
    [self.moveOn
     addTarget:self
     action:@selector(KeepSwipingBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.moveOn.alpha = 1.0;
    self.moveOn.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
    
    self.moveOn.layer.cornerRadius = 3.0;
    
    self.moveOn.translatesAutoresizingMaskIntoConstraints = NO;
    [self.moveOn invalidateIntrinsicContentSize];
    
    CGFloat buttonWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]) - 30;
    
    [self.moveOn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.moveOn.titleEdgeInsets = UIEdgeInsetsMake(15, 0, 15, 0);
    
    CGFloat pad = 0, height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 10;
        height = 50;
        self.moveOn.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 10;
        height = ceilf(103/2);
        self.moveOn.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:24];
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 10;
        height = ceilf(171/3);
        self.moveOn.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:25];
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 10;
        height = 35;
        self.moveOn.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15];
    }
    
    
    [self.view addSubview:self.moveOn];
    
    NSDictionary *viewsDictionary = @{@"Bottom" : self.goDump, @"Button" : self.moveOn};
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.moveOn attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[Button]-pad-[Bottom]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraint:constraint1];
    [self.view addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.moveOn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.view addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.moveOn attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:buttonWidth];
    [self.view addConstraint:constraint4];
    
    
    
}

- (void)setupDecisionLabel {
    
    
    self.decisionLabel = [[UILabel alloc] init];
    [self.decisionLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.decisionLabel invalidateIntrinsicContentSize];
    self.decisionLabel.textColor = [UIColor lightGrayColor];
    
    NSString *label = [@"Do you want to drop " stringByAppendingString:[[DataAccess singletonInstance] getName]];
    
    self.decisionLabel.text = [label stringByAppendingString:@"?"];

    
    
    self.decisionLabel.layer.masksToBounds = NO;
    
    
    CGFloat pad = 0, pad2 = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        self.decisionLabel.font = [UIFont systemFontOfSize:16];
        pad = 17;
        pad2 = 80;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        self.decisionLabel.font = [UIFont systemFontOfSize:18];
        pad = 8;
        pad2 = 90;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 9;
        pad2 = 100;
        self.decisionLabel.font = [UIFont systemFontOfSize:19];
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 6;
        pad2 = 75;
        self.decisionLabel.font = [UIFont systemFontOfSize:15];
        
    }
    
    self.decisionLabel.alpha = 100.0;
    
    [self.view addSubview:self.decisionLabel];
    
    NSDictionary *viewsDictionary = @{@"label" : self.decisionLabel, @"button": self.goDump};
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.decisionLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    [self.view addConstraint:constraint1];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[label]-pad-[button]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    [self.view addConstraints:constraint2];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIColor *) facebookBlue
{
    return [UIColor colorWithRed:0.23 green:0.35 blue:0.60 alpha:1.0];
}

- (UIColor *) linkedinBlue
{
    return [UIColor colorWithRed:0.00 green:0.48 blue:0.71 alpha:1.0];
}

-(void)KeepSwipingBtnPressed
{
    [self dismissViewControllerAnimated:NO completion:nil];
    NSLog(@"hello");
    
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
