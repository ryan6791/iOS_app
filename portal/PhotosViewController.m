//
//  PhotosViewController.m
//  pairedUP
//
//  Created by Neil Ballard on 1/26/16.
//  Copyright © 2016 Neil_appworld. All rights reserved.
//

#import "PhotosViewController.h"
#import "SinglePhotoViewController.h"
#import "DeviceManager.h"

@interface PhotosViewController ()

@property (nonatomic, retain) UINavigationBar * navBar;


@end

static NSString * const reuseIdentifier = @"Cell1";


@implementation PhotosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
        [self.collectionView registerNib:[UINib nibWithNibName:@"PhotosCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.didLoad = false;
    
    self.navigationController.navigationBarHidden = YES;
    [self styleNavBar];
    [self addCollectionContainer];
    dispatch_async(dispatch_get_main_queue(), ^{
        
        PhotoManager *albums = [PhotoManager singletonInstance];
        [albums getFacebookProfileInfos:2 completion:^{
            
            self.didLoad = true;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (PhotosCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PhotosCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    
    if(self.didLoad){
        
        PhotoManager *album = (PhotoManager*)[[[PhotoManager singletonInstance] photos] objectAtIndex:indexPath.row];
        
        cell.userInteractionEnabled = YES;
        
        cell.fbImageView.image = album.photo;
        
        //   cell.PhotoImageView.image = [UIImage imageNamed:@"logo_.png"];
        
        cell.backgroundColor = [UIColor blackColor];
        
    }
    return cell;
}

- (void)addCollectionContainer {
    
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.collectionView invalidateIntrinsicContentSize];
    
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]);

    
    [self.view addSubview:self.collectionView];
    
    CGFloat pad = 0, heightOffset = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        heightOffset = 64;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        heightOffset = 70;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        heightOffset = 80;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        heightOffset = 55;
    }
    
    CGFloat height = CGRectGetHeight([[UIScreen mainScreen] bounds]) - heightOffset;

    
    
    NSDictionary *viewsDictionary = @{@"view":self.collectionView, @"nav": self.navBar};
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[nav]-pad-[view]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self.view addConstraint:constraint1];
    
    [self.view addConstraint:constraint1];
    [self.view addConstraints:constraint2];

    
     NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
     [self.view addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self.view addConstraint:constraint4];
    
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    PhotoManager *album = [PhotoManager singletonInstance];
    
    if ([album.photos count] > 0) {
        return [album.photos count];
    }
    
    return 1;
}


- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    CGFloat width = 106;
    CGFloat height = 106;
    
    
    return CGSizeMake(width, height);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 1;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 1;
}


- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    NSLog(@"nav controllers are %@", self.navigationController);
    
    PhotoManager *album = (PhotoManager*)[[[PhotoManager singletonInstance] photos] objectAtIndex:indexPath.row];
    
    SinglePhotoViewController *singleInstance = [SinglePhotoViewController singletonInstance];
    
    singleInstance.photo = album.fullSizePhoto;
    
    SinglePhotoViewController *albums = [[SinglePhotoViewController alloc] init];
    [self.navigationItem setHidesBackButton:YES];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.navigationController pushViewController:albums animated:NO];
    
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
    [self.collectionView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    
}


-(void)goback{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
