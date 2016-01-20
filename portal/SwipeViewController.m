//
//  SwipeViewController.m
//  portal
//
//  Created by Neil Ballard on 12/13/15.
//  Copyright © 2015 Neil_appworld. All rights reserved.
//

#import "SwipeViewController.h"
#import "UserMenuViewController.h"
#import "SwipeAlbumViewController.h"
#import "JSQMessagesViewController.h"
#import "NewMatchViewController.h"
#import "MatchProfileViewController.h"

@interface SwipeViewController ()


@end

@implementation SwipeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushDetailView:) name:@"pushDetailView" object:nil];

    
    self.view.userInteractionEnabled = YES;
    
    
    [self styleNavBar];
    [self addMainView];
    

    

}



-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:YES];
    
    [self.navigationItem setHidesBackButton:YES];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    [self styleNavBar];
    

    
}

-(void)addMainView{
    
    DraggableViewBackground *draggableBackground = [[DraggableViewBackground alloc]init];
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    draggableBackground.translatesAutoresizingMaskIntoConstraints = NO;
    [draggableBackground invalidateIntrinsicContentSize];
    
 //   draggableBackground.layer.masksToBounds = NO;
 //   self.tableBack.layer.shadowOffset = CGSizeMake(-.1, .2);
 //   self.tableBack.layer.shadowRadius = .5;
 ///   self.tableBack.layer.shadowOpacity = 0.5;
    
    //
    
    //
    
    //
    
    //
    
    
    CGFloat pad = 0, sub;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 0;
        sub = 64;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 0;
        sub = 70;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 0;
        sub = 80;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 0;
        sub = 55;
    }
    
    CGFloat height = CGRectGetHeight([[UIScreen mainScreen] bounds]) - sub;

    
    [self.view addSubview:draggableBackground];
    
    
    
    NSDictionary *viewsDictionary = @{@"back":draggableBackground, @"top": self.navBar};
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:draggableBackground attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[top]-pad-[back]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraint:constraint1];
    [self.view addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:draggableBackground attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.view addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:draggableBackground attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.view addConstraint:constraint4];
    
}

- (void)styleNavBar {
    
    CGFloat height = 0;
    
    height = 64;
    
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
    self.navBar.barTintColor = [UIColor whiteColor];//[UIColor blueColor];
  //  self.navBar.tintColor = [UIColor clearColor];
    self.navBar.translucent = NO;
    

    
 //   UIImage *connections_image = [[UIImage imageNamed:@"connections"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
  //  UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithImage:connections_image  style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonPressed:)];
    
    UIImage *image = [[UIImage imageNamed:@"settings"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(leftButtonPressed:)];
    
    
 //   newItem.rightBarButtonItem = rightBtn;
    newItem.leftBarButtonItem = leftBtn;
    
    
    UIButton *titleView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [titleView setUserInteractionEnabled:NO];
    
    NSString *titleText = @"pairedUP";
    [titleView setTitleColor:[self navColor] forState:UIControlStateNormal];
    
    [titleView setTitle:titleText forState:UIControlStateNormal];
    
    titleView.titleLabel.font = [UIFont fontWithName:@"Superclarendon-Regular" size:21.0];
    
    titleView.layer.shadowRadius = 0.05;
    titleView.layer.shadowOpacity = 0.02;
    
    titleView.layer.masksToBounds = NO;
    
  //  titleView.layer.shouldRasterize = YES;
    
    
    newItem.titleView = titleView;
    
    
    
    // newItem.titleView = backView;
    // 4. add the nav bar to the main view
    [self.navBar setItems:@[newItem]];
    [self.view addSubview:self.navBar];
    
    UIImageView *proImage =[[UIImageView alloc] init];// Here you can set View width and height as per your requirement for displaying titleImageView position in navigationbar
    proImage.translatesAutoresizingMaskIntoConstraints = NO;
    [proImage invalidateIntrinsicContentSize];
    proImage.image = [[DataAccess singletonInstance] getMatchImage];
    proImage.layer.masksToBounds = YES;
    proImage.layer.cornerRadius = 15;
    proImage.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *imageTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(rightButtonPressed:)];
    [proImage addGestureRecognizer:imageTap];
    
    [self.navBar addSubview:proImage];
    
    CGFloat pic_width = 0, pic_height = 0, x_pad = 0, y_pad = 0;


    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pic_height = 29;
        pic_width = 31;
        x_pad = 14;
        y_pad = 27;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pic_height = 29;
        pic_width = 31;
        x_pad = 16;
        y_pad = 33;

    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pic_height = 29;
        pic_width = 31;
        x_pad = 16;
        y_pad = 30;

    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
       
        pic_height = 29;
        pic_width = 31;
        x_pad = 14;
        y_pad = 17;
    }
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:proImage attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:pic_height];
    [self.view addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:proImage attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:pic_width];
    [self.view addConstraint:constraint4];
    
    NSDictionary *viewsDictionary = @{@"back":proImage};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[back]-pad-|" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:x_pad]} views:viewsDictionary];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-pad-[back]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat: y_pad ]} views:viewsDictionary];
    [self.view addConstraints:constraint1];
    [self.view addConstraints:constraint2];

    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)leftButtonPressed:(id)sender {
    
    UserMenuViewController *account = [[UserMenuViewController alloc] init];
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.6f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionReveal;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    [self.navigationItem setHidesBackButton:NO];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.navigationController pushViewController:account animated:YES];
    
}

- (void)rightButtonPressed:(id)sender {
    
    

  //  MessagesViewController *vc = [MessagesViewController messagesViewController];
    MatchProfileViewController *vc = [[MatchProfileViewController alloc]init];
    [self.navigationItem setHidesBackButton:YES];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self.navigationController pushViewController:vc animated:YES];

    
/*
    NewMatchViewController *account = [[NewMatchViewController alloc] init];
    self.providesPresentationContextTransitionStyle = YES;
    self.definesPresentationContext = YES;
    [account setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    account.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:account animated:YES completion:nil]; */
    
}

-(void) pushDetailView:(id)sender
{
    // do your pushViewController

    SwipeAlbumViewController *album = [[SwipeAlbumViewController alloc] init];
    [self.navigationItem setHidesBackButton:NO];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.navigationController pushViewController:album animated:NO];
    
    /*
     -(void) pushDetailView:(NSNotification*)note
     {
     NSNumber indexPathRow = [note object];
     NSDictionary *product = self.products[[indexPathRow intValue]];
     // and on with your pushViewController code
     }
     */
}

-(UIColor*)navColor{
    
    return [UIColor colorWithRed:0.0 green:172.0f/255.0f blue:237.0f/255.0f alpha:1.0];
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
