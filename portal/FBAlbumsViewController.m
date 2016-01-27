//
//  FBAlbumsViewController.m
//  pairedUP
//
//  Created by Neil Ballard on 1/27/16.
//  Copyright © 2016 Neil_appworld. All rights reserved.
//

#import "FBAlbumsViewController.h"
#import "DeviceManager.h"
#import "PhotoManager.h"
#import "PhotosViewController.h"

@interface FBAlbumsViewController ()

@property (nonatomic, retain) UIView * background;
@property (nonatomic,unsafe_unretained) CGRect mainScreenBounds;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UIView * tableBack;

@property (nonatomic, retain) UINavigationBar * navBar;

@property (nonatomic, retain) UIActivityIndicatorView * activityindicator;
@property (strong, nonatomic) PhotoManager *album;

@end

@implementation FBAlbumsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    CGRect full = [[UIScreen mainScreen]bounds];
    self.navigationController.navigationBarHidden = NO;
    
    self.background = [[UIView alloc] initWithFrame:full];
    self.background.hidden = NO;
    self.background.backgroundColor = [UIColor whiteColor];
    self.background.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:self.background];
    
    [self styleNavBar];
    [self addTableContainer];
    
    [self initTableView];
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)initTableView {
    CGRect frame = [[UIScreen mainScreen] bounds];
    self.tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableBack addSubview:self.tableView];
    self.tableView.scrollEnabled = NO;
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 1)];
    
    //  self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    
    
    CGFloat pad = 0, height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 0;
        height = 100;
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
    [self.view addConstraint:YConstraint];
    [self.tableBack addConstraint:constraint1];
    
    /*
     NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.pic attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
     [self.pickbackground addConstraint:constraint3];*/
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.tableBack addConstraint:constraint4];
    
}

-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:YES];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self.navigationItem setHidesBackButton:NO];
    [self styleNavBar];

        
    dispatch_async(dispatch_get_main_queue(), ^{
            
            PhotoManager *albums = [PhotoManager singletonInstance];
            [albums getFacebookProfileInfos:1 completion:^{
                
                
                [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
                //         [self.tableView reloadData];
                
                
                
        }];
    });
    
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


- (void)addTableContainer {
    
    self.tableBack = [[UIView alloc]init];
    
    self.tableBack.backgroundColor = [UIColor whiteColor];
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
        height = 450;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 0;
        height = 180;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 0;
        height = 180;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 0;
        height = 180;
    }
    
    
    
    NSDictionary *viewsDictionary = @{@"back":self.tableBack, @"nav": self.navBar};
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.tableBack attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[nav]-pad-[back]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraint:constraint1];
    [self.view addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.tableBack attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self.view addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.tableBack attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.view addConstraint:constraint4];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    PhotoManager *albums = [PhotoManager singletonInstance];
    return [albums.albums count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
        PhotoManager *album = (PhotoManager*)[[[PhotoManager singletonInstance] albums] objectAtIndex:indexPath.row];
        cell.textLabel.text = album.album_name;
        UIFont *font;
        CGFloat indent = 0.0;
        if([[DeviceManager sharedInstance] getIsIPhone5Screen])
        {
            font = [UIFont fontWithName:@"HelveticaNeue" size:ceilf(36/2)];
            indent = ceilf(30/2);
        }
        else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
        {
            font = [UIFont fontWithName:@"HelveticaNeue" size:ceilf(42/2)];
            indent = ceilf(34/2);
        }
        else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
        {
            font = [UIFont fontWithName:@"HelveticaNeue" size:ceilf(70/3)];
            indent = ceilf(58/3);
        }
        else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad])
        {
            font = [UIFont fontWithName:@"HelveticaNeue" size:ceilf(35/2)];
            indent = ceilf(35/2);
        }
        
        cell.textLabel.font = font;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        
    }
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView.delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    return NO;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PhotoManager *album = (PhotoManager*)[[[PhotoManager singletonInstance] albums] objectAtIndex:indexPath.row];
    
    PhotoManager *instance = [PhotoManager singletonInstance];
    
    instance.album_id = album.album_id;
    
    NSLog(@"%@", album.album_id);
    
    PhotoManager *albums = [PhotoManager singletonInstance];
    [albums getFacebookProfileInfos:2 completion:^{
        
        
        PhotosViewController *controller = [[PhotosViewController alloc] initWithNibName:NSStringFromClass([PhotosViewController class]) bundle:nil];
        
        [self.navigationItem setHidesBackButton:YES];
        [self.navigationController setNavigationBarHidden:NO animated:NO];
        [self.navigationController pushViewController:controller animated:YES];
        
    }];
    
    
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

//[UIColor colorWithRed:0.00 green:0.00 blue:0.30 alpha:1.0];

-(UIColor*)headerColor{
    
    return [UIColor colorWithRed:0.00 green:0.00 blue:0.40 alpha:1.0];
    
    
}

-(void)goback{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (UIColor *) cdBlue {
    return [UIColor colorWithRed:0.00 green:0.59 blue:0.84 alpha:1.0];
}


@end
