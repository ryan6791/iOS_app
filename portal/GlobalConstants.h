//
//  GlobalConstants.h
//
//  Created by Brian Merz on 11/17/14.
//  Copyright (c) 2014 blackfeetpdx. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT int const kOAuthTokenTypeRequestToken;
FOUNDATION_EXPORT int const kOAuthTokenTypeAccessToken;

FOUNDATION_EXPORT NSString *const URL_Live;
FOUNDATION_EXPORT NSString *const URL_Stage;
FOUNDATION_EXPORT NSString *const URL_Dev;
FOUNDATION_EXPORT NSString *const consumerKey;

#define TimeStamp [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]]
#define TimeStampMillis [NSString stringWithFormat:@"%lli", [@(floor([[NSDate date] timeIntervalSince1970] * 1000)) longLongValue]]
