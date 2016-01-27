//
//  FBAlbumsViewController.h
//  pairedUP
//
//  Created by Neil Ballard on 1/27/16.
//  Copyright © 2016 Neil_appworld. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FBAlbumsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *albums;

@end
