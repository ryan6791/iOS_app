//
//  LandingViewController.h
//  pairedUP
//
//  Created by Neil Ballard on 1/31/16.
//  Copyright © 2016 Neil_appworld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
#import "DMPagerViewController/DMPagerViewController.h"
#import "SwipeViewController.h"
#import "MatchProfileViewController.h"
#import "MessagesViewController.h"

@interface LandingViewController : UIViewController<UIScrollViewDelegate>

@property(nonatomic, strong) UINavigationController *navController;

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, assign) BOOL request_success;

@property (nonatomic, assign) BOOL info_success;
@property (nonatomic, assign) BOOL photo_success;



@property (nonatomic, assign) BOOL loggedin;
@property (strong, nonatomic) UIWindow *window;


@property (nonatomic, strong) UILabel *explainLabel;
@property (nonatomic, strong) UILabel *explainLabel2;
@property (nonatomic, strong) UILabel *explainLabel3;
@property (nonatomic, strong) UILabel *explainLabel4;




@property (strong, nonatomic) DMPagerViewController	*pagerController;

@end
