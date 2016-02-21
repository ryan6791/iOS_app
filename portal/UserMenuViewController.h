//
//  UserMenuViewController.h
//  portal
//
//  Created by Neil Ballard on 11/16/15.
//  Copyright © 2015 Neil_appworld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
#import "DMPagerViewController.h"

@class DMPagerNavigationBarItem;


@interface UserMenuViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,DMPagerViewControllerProtocol>

@property (nonatomic,strong) DMPagerNavigationBarItem	*pagerObj;
@property (strong, nonatomic) DMPagerNavigationBar	*pagerNav;


- (instancetype)initWithText:(NSString *) aText backgroundColor:(UIColor *) aBkgColor;


@end
