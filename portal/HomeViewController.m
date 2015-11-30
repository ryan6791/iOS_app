//
//  HomeViewController.m
//  portal
//
//  Created by Neil Ballard on 10/9/15.
//  Copyright © 2015 Neil_appworld. All rights reserved.
//

#import "HomeViewController.h"
#import "AccountViewController.h"
#import "MyProfileViewController.h"
#import "UserMenuViewController.h"
#import "ProfileViewController.h"
#import "DeviceManager.h"
#import "DataAccess.h"
#import "HomeTableViewCell.h"
#import "ConnectionsViewController.h"



@interface HomeViewController ()


@property (nonatomic, retain) UIView * background;


@property (strong, nonatomic) IBOutlet UILabel *networksLabel;


@property (nonatomic, retain) UIView * Line;
@property (nonatomic, retain) UIView * Line1;
@property (nonatomic, retain) UIView * Line2;
@property (nonatomic, retain) UIView * Line3;
@property (nonatomic, retain) UIView * Line4;

@property (nonatomic,unsafe_unretained) CGRect mainScreenBounds;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UIView * tableBack;
@property (nonatomic, strong) UINavigationBar *navBar;



@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGRect full = [[UIScreen mainScreen]bounds];
    self.navigationController.navigationBarHidden = YES;
    [self.navigationItem setHidesBackButton:YES];
    self.background = [[UIView alloc] initWithFrame:full];
    self.background.hidden = NO;
    self.background.backgroundColor = [self grayColor];
    self.background.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:self.background];
    
    // [self initViewItems];
    [self styleNavBar];
    [self addLine];
    
    
    [self addTableContainer];
    
    [self initTableView];
    
    [self addBottomLine];
    
    
    
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
    NSIndexPath *pathForCenterCell = [self.tableView indexPathForRowAtPoint:CGPointMake(CGRectGetMidX(self.tableView.bounds), CGRectGetMidY(self.tableView.bounds))];
    
    [self.tableView scrollToRowAtIndexPath:pathForCenterCell atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}

-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    [self centerTable];

}
/*
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self centerTable];
}*/

- (void)centerTable {
    NSIndexPath *pathForCenterCell = [self.tableView indexPathForRowAtPoint:CGPointMake(CGRectGetMidX(self.tableView.bounds), CGRectGetMidY(self.tableView.bounds))];
    
    [self.tableView scrollToRowAtIndexPath:pathForCenterCell atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}


- (void)initTableView {
    CGRect frame = [[UIScreen mainScreen] bounds];
    self.tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableBack addSubview:self.tableView];
    self.tableView.scrollEnabled = YES;
    self.tableView.backgroundColor = [self grayColor];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 1)];
    
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 60, 0);

    
    
    CGFloat pad = 0, height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 0;
        height = 500;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 0;
        height = 250;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 0;
        height = 250;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 0;
        height = 250;
    }
    
    
    
    NSDictionary *viewsDictionary = @{@"top":self.tableBack, @"table": self.tableView};
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.tableBack attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSLayoutConstraint *YConstraint = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.tableBack attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    [self.tableBack addConstraint:YConstraint];
    [self.tableBack addConstraint:constraint1];
    
    /*
     NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.pic attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
     [self.pickbackground addConstraint:constraint3];*/
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.tableBack addConstraint:constraint4];
    
}

-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:YES];
    
    [self.navigationItem setHidesBackButton:YES];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    [self styleNavBar];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)styleNavBar {
    
    CGFloat height = 0, ypad = 0;
    
    height = 64;
    ypad = 36;
    
    
    // 1. hide the existing nav bar
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    // 2. create a new nav bar and style it
    self.navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), height)];
    self.navBar.translucent = YES;
    // 3. add a new navigation item w/title to the new nav bar
    UINavigationItem *newItem = [[UINavigationItem alloc] init];
    self.navBar.backgroundColor = [UIColor whiteColor];
    
    UIImage *connections_image = [[UIImage imageNamed:@"connections"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    

    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithImage:connections_image  style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonPressed:)];
    
    UIImage *image = [[UIImage imageNamed:@"settings"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(leftButtonPressed:)];
    
    
    newItem.rightBarButtonItem = rightBtn;
    newItem.leftBarButtonItem = leftBtn;
    

    UIButton *titleView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [titleView setUserInteractionEnabled:NO];
    
    NSString *titleText = @"Portal";
    [titleView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [titleView setTitle:titleText forState:UIControlStateNormal];
    
    
    newItem.titleView = titleView;
    
    
    
    
    
    // newItem.titleView = backView;
    // 4. add the nav bar to the main view
    [self.navBar setItems:@[newItem]];
    [self.view addSubview:self.navBar];
    

}

- (void)setupTitleViewWithTitleText {
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"logo_.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                 style:UIBarButtonItemStylePlain
                                                                target:self
                                                                action:nil];
    
    
    //  UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"logo_.png"] style:UIBarButtonItemStylePlain target:self action:@selector(Back)];
    //  UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style: UIBarButtonItemStylePlain target:self action:@selector(Back)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    UIButton *titleView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [titleView setUserInteractionEnabled:NO];
    
    NSString *titleText = @"Portal";
    [titleView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [titleView setTitle:titleText forState:UIControlStateNormal];
    
    
    self.navigationItem.titleView = titleView;
}



- (void)addTableContainer {
    
    self.tableBack = [[UIView alloc]init];
    
    self.tableBack.backgroundColor = [self grayColor];
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    self.tableBack.translatesAutoresizingMaskIntoConstraints = NO;
    [self.tableBack invalidateIntrinsicContentSize];
    
    self.tableBack.layer.masksToBounds = NO;
    self.tableBack.layer.shadowOffset = CGSizeMake(-.1, .2);
    self.tableBack.layer.shadowRadius = .5;
    self.tableBack.layer.shadowOpacity = 0.5;
    
    [self.view addSubview:self.tableBack];
    
    CGFloat pad = 0, height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 0;
        height = 500;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 0;
        height = 500;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 0;
        height = 500;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 0;
        height = 500;
    }
    
    
    
    NSDictionary *viewsDictionary = @{@"back":self.tableBack, @"top": self.Line};
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.tableBack attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[top]-pad-[back]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraint:constraint1];
    [self.view addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.tableBack attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.view addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.tableBack attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.view addConstraint:constraint4];
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1
    ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Number of rows is the number of time zones in the region for the specified section.
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"MyReuseIdentifier";
    // UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    HomeTableViewCell *cell = (HomeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    
    if (cell == nil) {
        cell = [[HomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:MyIdentifier];
    }
    
    UIFont *myFont = [ UIFont fontWithName: @"Arial" size: 19.0 ];
    cell.textLabel.font  = myFont;
    cell.textLabel.textColor = [UIColor lightGrayColor];
    
    if (indexPath.row == 0) {
        
   //     cell.imageView.image = [UIImage imageNamed:@"facebook_icon.png"];
   //     cell.textLabel.text = @"Facebook";
        
    }else if (indexPath.row == 1) {
  //      cell.imageView.image = [UIImage imageNamed:@"instagram_icon1.png"];
        
        //      if ([[DataAccess singletonInstance] getInstagram] != nil) {
        //          cell.textLabel.text = [[DataAccess singletonInstance] getInstagram];
        //      }else{
     //   cell.textLabel.text = @"Instagram";
    //    cell.backgroundView.backgroundColor = [UIColor redColor];

        //      }
        
    }
    else if (indexPath.row == 2) {
        
  //      cell.imageView.image = [UIImage imageNamed:@"linkedin_icon.png"];
        
        //      if ([[DataAccess singletonInstance] getLinkedin] != nil) {
        //         cell.textLabel.text = [[DataAccess singletonInstance] getLinkedin];
        //      }else{
      //  cell.textLabel.text = @"Linkedin";
     //   cell.backgroundView.backgroundColor = [UIColor greenColor];
        //      }
        
    }
    else if (indexPath.row == 3) {
   //     cell.imageView.image = [UIImage imageNamed:@"snapchat_icon.png"];
        
        //        if ([[DataAccess singletonInstance] getSnapchat] != nil) {
        //            cell.textLabel.text = [[DataAccess singletonInstance] getSnapchat];
        //       }else{
      //  cell.textLabel.text = @"Snapchat";
        
        //       }
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //  CGFloat height = self.tableBack.frame.size.height;
    
    CGFloat cellHeight = 0;
    
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        cellHeight =  495;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        cellHeight = ceilf(180/2);
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        cellHeight = ceil(300/3);
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        cellHeight = ceilf(140/2);
    }
    
    return cellHeight; //(height / 5);//[self getCellHeight];
}


/*
 -(CGFloat)getCellHeight {
 CGFloat cellHeight = 0.0;
 if([[DeviceManager sharedInstance] getIsIPhone5Screen])
 {
 cellHeight =  ceilf(163/2);
 }
 else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
 {
 cellHeight = ceilf(180/2);
 }
 else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
 {
 cellHeight = ceil(300/3);
 }
 else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
 cellHeight = ceilf(140/2);
 }
 
 return cellHeight;
 }
 
 -(CGFloat)getAccessoryViewWidth {
 CGFloat modifier = 0.0;
 if([[DeviceManager sharedInstance] getIsIPhone5Screen])
 {
 modifier =  42;
 }
 else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
 {
 modifier = 42;
 }
 else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
 {
 modifier = 48;
 }
 else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
 modifier = 42;
 }
 
 return modifier;
 }
 
 -(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
 if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
 [cell setSeparatorInset:UIEdgeInsetsZero];
 }
 if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
 [cell setLayoutMargins:UIEdgeInsetsZero];
 }
 }*/


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    
}




- (void)addLine{
    
    self.Line = [[UIView alloc]init];
    
    self.Line.backgroundColor = [self lineColor];
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    self.Line.translatesAutoresizingMaskIntoConstraints = NO;
    [self.Line invalidateIntrinsicContentSize];
    
    
    
    [self.view addSubview:self.Line];
    
    CGFloat pad = 0, height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 2;
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
    
    
    
    NSDictionary *viewsDictionary = @{@"top" : self.navBar, @"line": self.Line};
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.Line attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[top]-pad-[line]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraint:constraint1];
    [self.view addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.Line attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.view addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.Line attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.view addConstraint:constraint4];
    
}

- (void)addBottomLine{
    
    self.Line2 = [[UIView alloc]init];
    
    self.Line2.backgroundColor = [self lineColor];
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    self.Line2.translatesAutoresizingMaskIntoConstraints = NO;
    [self.Line2 invalidateIntrinsicContentSize];
    
    
    
    [self.tableBack addSubview:self.Line2];
    
    CGFloat pad = 0, height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 0;
        height = 1;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 0;
        height = 1;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 0;
        height = 1;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 0;
        height = 1;
    }
    
    
    
    NSDictionary *viewsDictionary = @{@"top":self.tableView, @"line": self.Line2};
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.tableBack attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.Line2 attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[line]-pad-|" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.tableBack addConstraint:constraint1];
    [self.tableBack addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.Line2 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.tableBack addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.Line2 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.tableBack addConstraint:constraint4];
    
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
    
    
    ConnectionsViewController *account = [[ConnectionsViewController alloc] init];
    [self.navigationItem setHidesBackButton:NO];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.navigationController pushViewController:account animated:YES];
    
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
