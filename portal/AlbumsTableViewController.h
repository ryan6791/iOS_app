//
//  AlbumsTableViewController.h
//  portal
//
//  Created by Neil Ballard on 10/11/15.
//  Copyright © 2015 Neil_appworld. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlbumsTableViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *albums;

@end
