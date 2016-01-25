//
//  GlobalConstants.m
//
//  Created by Brian Merz on 1/23/15.
//  Copyright (c) 2015 blackfeetpdx. All rights reserved.
//

#import "GlobalConstants.h"

#ifdef DEBUG
BOOL const kDebugMode = YES;
#endif

#ifndef DEBUG
BOOL const kDebugMode = NO;
#endif

int const kOAuthTokenTypeRequestToken = 2;
int const kOAuthTokenTypeAccessToken = 1;

//NOT CONSTRUCTED
NSString *const URL_Live = @"http://xx/service";

//NOAUTH
NSString *const URL_Stage = @"http://xx/service";

//OAUTH Testing
NSString *const URL_Dev = @"http://52.35.207.96/service";

NSString *const consumerKey = @"com+gohard503";