//
//  LoginViewController.h
//  portal
//
//  Created by Neil Ballard on 10/9/15.
//  Copyright © 2015 Neil_appworld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
#import "DMPagerViewController/DMPagerViewController.h"
#import "SwipeViewController.h"
#import "Login.h"


@interface LoginViewController : UIViewController

@property(nonatomic, strong) UINavigationController *navController;

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, assign) BOOL request_success;

@property (nonatomic, assign) BOOL info_success;
@property (nonatomic, assign) BOOL photo_success;



@property (nonatomic, assign) BOOL loggedin;
@property (strong, nonatomic) UIWindow *window;


-(void)sendData:(NSString*)access_token completion:(void (^)(void))completionBlock;


@property (strong, nonatomic) DMPagerViewController	*pagerController;


@end
