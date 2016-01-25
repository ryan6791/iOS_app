//
//  OAuthSecurity.m
//
//  Created by Brian Merz on 9/29/15.
//  Copyright © 2015 Blackfeetpdx. All rights reserved.
//

#import "OAuthSecurity.h"
#import "NSMutableData+AES.h"
#import "GlobalConstants.h"

@implementation OAuthSecurity

+ (NSString*)base64HashForString:(NSString*)forHashing {
    NSMutableData *dataForHashing = (NSMutableData*)[forHashing dataUsingEncoding:NSUTF8StringEncoding];
    NSData *hashedData = [dataForHashing encryptAES];
    return [hashedData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
}

+ (NSString*)retrievePasswordSalt {
    return @"==MethodInnocenceMillBuryingCommitmentPoundIncome==";
}

+ (NSString*)retriveOAuthConsumerKey {
    return consumerKey;
}

+ (NSString*)retrieveOAauthConsumerSecret {
    return @"==MethodInnocenceMillBuryingCommitmentPoundIncome==";
}

@end