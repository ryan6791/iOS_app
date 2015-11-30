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

#import <linkedin-sdk/LISDK.h>

@interface LoginViewController : UIViewController

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, assign) BOOL request_success;

@property (nonatomic, assign) BOOL loggedin;


-(void)sendData:(NSString*)access_token;


@end
