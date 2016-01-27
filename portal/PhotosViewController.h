//
//  PhotosViewController.h
//  pairedUP
//
//  Created by Neil Ballard on 1/26/16.
//  Copyright © 2016 Neil_appworld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoManager.h"
#import "PhotosCollectionViewCell.h"

@interface PhotosViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, assign) BOOL didLoad;

@end
