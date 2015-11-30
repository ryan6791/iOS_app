//
//  PhotosCollectionViewController.m
//  portal
//
//  Created by Neil Ballard on 10/10/15.
//  Copyright © 2015 Neil_appworld. All rights reserved.
//

#import "PhotosCollectionViewController.h"
#import "PhotoManager.h"
#import "PhotosCollectionViewCell.h"
#import "SinglePhotoViewController.h"

@interface PhotosCollectionViewController ()

@property (nonatomic, strong, readwrite) UIImageView *photoImageView;

@property (strong, nonatomic) IBOutlet UICollectionView *parallaxCollectionView;


@end

@implementation PhotosCollectionViewController

static NSString * const reuseIdentifier = @"Cell1";


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.didLoad = false;
    
    self.navigationController.navigationBarHidden = NO;
    [self.navigationItem setTitle:@"Menu"];
    [self setupTitleViewWithTitleText];
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        PhotoManager *albums = [PhotoManager singletonInstance];
        [albums getFacebookProfileInfos:2 completion:^{
            
            self.didLoad = true;
        }];
    });


    
}

- (void)setupTitleViewWithTitleText {
    UIButton *titleView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [titleView setUserInteractionEnabled:NO];
    
    [titleView setImage:[UIImage imageNamed:@"logo_.png"] forState:UIControlStateNormal];
    
    self.navigationItem.titleView = titleView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDatasource Methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    PhotoManager *album = [PhotoManager singletonInstance];
    
    if ([album.photos count] > 0) {
        return [album.photos count];
    }
    
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotosCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    

    if(self.didLoad){
        
    PhotoManager *album = (PhotoManager*)[[[PhotoManager singletonInstance] photos] objectAtIndex:indexPath.row];
        
    cell.userInteractionEnabled = YES;
        
    cell.PhotoImageView.image = album.photo;
    
 //   cell.PhotoImageView.image = [UIImage imageNamed:@"logo_.png"];
    
    cell.backgroundColor = [UIColor blackColor];
        
    }
    
    return cell;
}
/*
#pragma mark - UIScrollViewdelegate methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    for(PhotosCollectionViewCell *view in self.parallaxCollectionView.visibleCells) {
        CGFloat yOffset = ((self.parallaxCollectionView.contentOffset.y - view.frame.origin.y) / IMAGE_HEIGHT) * IMAGE_OFFSET_SPEED;
        view.imageOffset = CGPointMake(0.0f, yOffset);
    }
}
*/
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
    
    PhotoManager *album = (PhotoManager*)[[[PhotoManager singletonInstance] photos] objectAtIndex:indexPath.row];
    
    SinglePhotoViewController *singleInstance = [SinglePhotoViewController singletonInstance];
    
    singleInstance.photo = album.fullSizePhoto;
    
    
    SinglePhotoViewController *menuVC = [[SinglePhotoViewController alloc]init];
    UINavigationController  *navController = [[UINavigationController alloc] initWithRootViewController:menuVC];
    [self presentViewController:navController animated:YES completion:nil];
    

    
    
}

/*
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    self.collectionView=[[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    [self.collectionView setDataSource:self];
    [self.collectionView setDelegate:self];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [self.collectionView setBackgroundColor:[UIColor redColor]];
    
    [self.view addSubview:self.collectionView];
    
    
    // Do any additional setup after loading the view.
}
*/

/*
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoManager *album = (PhotoManager*)[[[PhotoManager singletonInstance] photos] objectAtIndex:indexPath.row];
   
    album.photo = 

    NSString *searchTerm = self.searches[indexPath.section]; FlickrPhoto *photo =
    self.searchResults[searchTerm][indexPath.row];
    // 2
    CGSize retval = photo.thumbnail.size.width > 0 ? photo.thumbnail.size : CGSizeMake(100, 100);
    retval.height += 35; retval.width += 35; return retval;
}
*/
// 3
/*
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(50, 20, 50, 20);
}*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
 
    
    [self.collectionView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    
}

/*
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
   
    PhotoManager *album = [PhotoManager singletonInstance];
    
    if ([album.photos count] > 0) {
        NSLog(@"%u", [album.photos count]);
       return [album.photos count];
    }
    
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
    PhotoManager *album = (PhotoManager*)[[[PhotoManager singletonInstance] photos] objectAtIndex:indexPath.row];
    
    cell.backgroundColor=[UIColor greenColor];
    

    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(50, 50);
}


- (id)initWithCollectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        // additional setup here if required.
    }
    return self;
}

*/
/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected

*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
