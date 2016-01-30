//
//  Login.h
//  pairedUP
//
//  Created by Neil Ballard on 1/29/16.
//  Copyright © 2016 Neil_appworld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

@interface Login : NSObject


@property (nonatomic, assign) BOOL request_success;



@property (nonatomic, strong) NSURLSession *session;

+ (id)singletonInstance;


-(void)Request:(NSString*)access_token completion:(void (^)(void))completionBlock;

@end
