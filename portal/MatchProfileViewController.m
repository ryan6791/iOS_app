//
//  MatchProfileViewController.m
//  pairedUP
//
//  Created by Neil Ballard on 1/17/16.
//  Copyright © 2016 Neil_appworld. All rights reserved.
//

#import "MatchProfileViewController.h"
#import "DeviceManager.h"
#import "DataAccess.h"
#import "MessagesViewController.h"
#import "UserAlbumsViewController.h"


@interface MatchProfileViewController ()

@end

@implementation MatchProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNameLabel];
    [self setupDateLabel];
    
    [self addProfileBackBackground];
    [self addProfileImage];
    [self addButton1Background];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)init
{
    self = [super init];
    if (self) {
        
        // self.title = @"My Title";
    }

    return self;
}


- (void)addProfileBackBackground{
    
    self.picBackBackground = [[UIView alloc]init];
    
    self.picBackBackground.backgroundColor = [UIColor clearColor];
    self.picBackBackground.translatesAutoresizingMaskIntoConstraints = NO;
    [self.picBackBackground invalidateIntrinsicContentSize];

    
    self.picBackBackground.userInteractionEnabled = YES;
    
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    
    [circleLayer setPath:[[UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 210, 210)]CGPath]];
    
    [circleLayer setStrokeColor:[[UIColor grayColor]CGColor]];
    [circleLayer setFillColor:[[UIColor whiteColor]CGColor]];
    
    circleLayer.borderWidth = 2.0;
    
    
    [[self.picBackBackground layer] addSublayer:circleLayer];

    
    [self.view addSubview:self.picBackBackground];
    
    
    CGFloat pad = 0, height = 0, widthOffset;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 15;
        height = 210;
        widthOffset = 110;
    //    self.picBackBackground.layer.cornerRadius = 105;
        self.picBackBackground.layer.masksToBounds = NO;
        self.picBackBackground.layer.shadowOffset = CGSizeMake(-.5, .5);
        self.picBackBackground.layer.shadowRadius = 0.7;
        self.picBackBackground.layer.shadowOpacity = 0.5;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 40;
        height = 250;
        widthOffset = 100;
        self.picBackBackground.layer.cornerRadius = 115;
        self.picBackBackground.layer.masksToBounds = YES;
        self.picBackBackground.layer.shadowOffset = CGSizeMake(-.1, .2);
        self.picBackBackground.layer.shadowRadius = .5;
        self.picBackBackground.layer.shadowOpacity = 0.5;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 50;
        height = 300;
        widthOffset = 120;
        self.picBackBackground.layer.cornerRadius = 105;
        self.picBackBackground.layer.masksToBounds = YES;
        self.picBackBackground.layer.shadowOffset = CGSizeMake(-.1, .2);
        self.picBackBackground.layer.shadowRadius = .5;
        self.picBackBackground.layer.shadowOpacity = 0.5;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 25;
        height = 200;
        widthOffset = 97;
        self.picBackBackground.layer.cornerRadius = 105;
        self.picBackBackground.layer.masksToBounds = YES;
        self.picBackBackground.layer.shadowOffset = CGSizeMake(-.1, .2);
        self.picBackBackground.layer.shadowRadius = .5;
        self.picBackBackground.layer.shadowOpacity = 0.5;
    }
    
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]) - widthOffset;
    
    
    
    NSDictionary *viewsDictionary = @{@"image":self.picBackBackground, @"connection": self.dateLabel};
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.picBackBackground attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[connection]-pad-[image]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraint:constraint1];
    [self.view addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.picBackBackground attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.view addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.picBackBackground attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.view addConstraint:constraint4];
    
    
}


- (void)addProfileImage {
    
    self.pic = [[UIImageView alloc]init];
    
    self.pic.backgroundColor = [UIColor blueColor];
    self.pic.translatesAutoresizingMaskIntoConstraints = NO;
    [self.pic invalidateIntrinsicContentSize];
    
    NSData* imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"matchImage"];
    UIImage* image = [UIImage imageWithData:imageData];
    
    
    if (image != nil) {
        self.pic.image = image;
    }else{
        self.pic.image = [UIImage imageNamed:@"image_placeholder.png"];
    }
    
    self.pic.alpha = 2.0;
    
    self.pic.userInteractionEnabled = YES;
    UITapGestureRecognizer *pictureTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(goToPic:)];
    [self.pic addGestureRecognizer:pictureTap];
    
    [self.picBackBackground addSubview:self.pic];
    
    CGFloat pad = 0, height = 0, width;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 40;
        height = 205;
        width = 205;
        self.pic.layer.cornerRadius = 102.50000;
        self.pic.layer.masksToBounds = YES;
        self.pic.layer.shadowOffset = CGSizeMake(-.1, .2);
        self.pic.layer.shadowRadius = .5;
        self.pic.layer.shadowOpacity = 0.5;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 40;
        height = 250;
        width = 110;
        self.pic.layer.masksToBounds = YES;
        self.pic.layer.shadowOffset = CGSizeMake(-.1, .2);
        self.pic.layer.shadowRadius = .5;
        self.pic.layer.shadowOpacity = 0.5;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 50;
        height = 300;
        width = 120;
        self.pic.layer.cornerRadius = 105;
        self.pic.layer.masksToBounds = YES;
        self.pic.layer.shadowOffset = CGSizeMake(-.1, .2);
        self.pic.layer.shadowRadius = .5;
        self.pic.layer.shadowOpacity = 0.5;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 25;
        height = 190;
        width = 97;
        self.pic.layer.cornerRadius = 105;
        self.pic.layer.masksToBounds = YES;
        self.pic.layer.shadowOffset = CGSizeMake(-.1, .2);
        self.pic.layer.shadowRadius = .5;
        self.pic.layer.shadowOpacity = 0.5;
    }
    
   // CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]) - widthOffset;
    
    
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.pic attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.picBackBackground attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSLayoutConstraint *constraint2 = [NSLayoutConstraint constraintWithItem:self.pic attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.picBackBackground attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    [self.view addConstraint:constraint1];
    [self.view addConstraint:constraint2];
    
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
    
    self.nameLabel.text = [[DataAccess singletonInstance] getMatchName];
    
    self.nameLabel.text = [self.nameLabel.text stringByAppendingString:@", 24"];
    
    
    self.nameLabel.layer.masksToBounds = NO;
    
    //   self.nameLabel.layer.shouldRasterize = YES;
    
    CGFloat pad = 0, pad2 = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        self.nameLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:30];
        pad = 17;
        pad2 = 50;
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
    
    NSDictionary *viewsDictionary = @{@"label" : self.nameLabel};
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    [self.view addConstraint:constraint1];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-pad-[label]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    [self.view addConstraints:constraint2];
    
}

- (void)setupDateLabel {
    
    
    self.dateLabel = [[UILabel alloc] init];
    [self.dateLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.dateLabel invalidateIntrinsicContentSize];
    self.dateLabel.textColor = [UIColor lightGrayColor];
    
    self.dateLabel.text = @"Connected 3 days ago";
    
    
    self.dateLabel.layer.masksToBounds = NO;
    
    //   self.nameLabel.layer.shouldRasterize = YES;
    
    CGFloat pad = 0, pad2 = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        self.dateLabel.font = [UIFont fontWithName:@"HelveticaNeue-light" size:17];
        pad = 17;
        pad2 = 3;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        self.dateLabel.font = [UIFont systemFontOfSize:26];
        pad = 8;
        pad2 = 12;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 9;
        pad2 = 16;
        self.dateLabel.font = [UIFont systemFontOfSize:27];
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 6;
        pad2 = 8;
        self.dateLabel.font = [UIFont systemFontOfSize:19];
        
    }
    
    self.dateLabel.alpha = 100.0;
    
    [self.view addSubview:self.dateLabel];
    
    NSDictionary *viewsDictionary = @{@"name":self.nameLabel, @"label" : self.dateLabel};
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.dateLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    [self.view addConstraint:constraint1];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[name]-pad-[label]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    [self.view addConstraints:constraint2];
    
}

- (void)setupInfoTextView {
    
    
    self.infoText = [[UITextView alloc] init];
    [self.infoText setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.infoText invalidateIntrinsicContentSize];
    self.infoText.textColor = [UIColor lightGrayColor];
    
    
    self.infoText.text = @"Lover of long walks on the beach. Candlelit dinners under the stars. BE A GENTLEMAN. Not here for a one night stand. snapchat: @wineloverxx3";
    
    
    self.infoText.layer.masksToBounds = NO;
    
    //   self.nameLabel.layer.shouldRasterize = YES;
    
    CGFloat pad = 0, pad2 = 0, widthOffset = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        self.infoText.font = [UIFont fontWithName:@"HelveticaNeue-light" size:15];
        pad = 17;
        pad2 = 10;
        widthOffset = 40;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        self.infoText.font = [UIFont systemFontOfSize:19];
        pad = 8;
        pad2 = 16;
        widthOffset = 60;

    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 9;
        pad2 = 16;
        self.infoText.font = [UIFont systemFontOfSize:21];
        widthOffset = 64;

        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 17;
        pad2 = 10;
        self.infoText.font = [UIFont systemFontOfSize:14];
        widthOffset = 70;
        
    }
    
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]) - widthOffset;
    
    self.infoText.alpha = 100.0;
    
    [self.view addSubview:self.infoText];
    
    NSDictionary *viewsDictionary = @{@"text":self.infoText, @"back" : self.picBackBackground};
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.infoText attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    [self.view addConstraint:constraint1];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[back]-pad-[text]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    [self.view addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.infoText attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:100];
    [self.view addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.infoText attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.view addConstraint:constraint4];
    
}



- (void)addButton1Background{
    
    self.buttonBackground1 = [[UIButton alloc] init];
    self.buttonBackground1=[UIButton buttonWithType:UIButtonTypeCustom];
    self.buttonBackground1.backgroundColor = [UIColor whiteColor];
    NSString *dropLabel = [@"DROP " stringByAppendingString:[[[DataAccess singletonInstance] getMatchName] uppercaseString]];
    [self.buttonBackground1 setTitle: dropLabel forState: UIControlStateNormal];
    // Handle clicks on the button
    [self.buttonBackground1
     addTarget:self
     action:@selector(LoginButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
 //   self.buttonBackground1.layer.borderWidth = 1;
 //   self.buttonBackground1.layer.borderColor = [self redishColor].CGColor;
    self.buttonBackground1.alpha = 1.0;
    self.buttonBackground1.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:18];
//    self.buttonBackground1.layer.cornerRadius = 10.0;
    
    self.buttonBackground1.translatesAutoresizingMaskIntoConstraints = NO;
    [self.buttonBackground1 invalidateIntrinsicContentSize];
    
    [self.buttonBackground1 setTitleColor:[self redishColor] forState:UIControlStateNormal];
    self.buttonBackground1.titleEdgeInsets = UIEdgeInsetsMake(15, 0, 15, 0);
    [self.view addSubview:self.buttonBackground1];
 //   self.buttonBackground1.layer.shadowColor = [self redishColor].CGColor;

    
    CGFloat pad = 0, height = 0, widthOffset;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 25;
        height = 50;
        widthOffset = 40;
        //    self.picBackBackground.layer.cornerRadius = 105;
        self.buttonBackground1.layer.masksToBounds = NO;
        self.buttonBackground1.layer.shadowOffset = CGSizeMake(-.5, .5);
        self.buttonBackground1.layer.shadowRadius = 0.7;
        self.buttonBackground1.layer.shadowOpacity = 0.2;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 40;
        height = 100;
        widthOffset = 20;
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
    
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]);// - widthOffset;
    
    
    
    NSDictionary *viewsDictionary = @{@"back":self.buttonBackground1};
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.buttonBackground1 attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[back]-pad-|" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraint:constraint1];
    [self.view addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.buttonBackground1 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.view addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.buttonBackground1 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.view addConstraint:constraint4];
    
    
}



- (void)rightButtonPressed:(id)sender {
    
    
    
    MessagesViewController *vc = [MessagesViewController messagesViewController];
    [self.navigationItem setHidesBackButton:YES];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (void)leftButtonPressed:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)goToPic:(id)sender{
    
    
    UserAlbumsViewController *account = [[UserAlbumsViewController alloc] init];
    [self.navigationItem setHidesBackButton:YES];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self.navigationController pushViewController:account animated:NO];
    
}



-(UIColor*)redishColor{
    return [UIColor colorWithRed:225.0f/255.0f green:117.0f/255.0f blue:117.0f/255.0f alpha:1.0];
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
